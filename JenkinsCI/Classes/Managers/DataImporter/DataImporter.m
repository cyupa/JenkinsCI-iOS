//
//  DataImporter.m
//  JenkinsCI
//
//  Created by Ciprian Redinciuc on 20/10/14.
//  Copyright (c) 2014 Ciprian Redinciuc. All rights reserved.
//

#import "DataImporter.h"
#import "CoreDataManager.h"
#import "CoreDataClubManager.h"
#import "CoreDataPlayerManager.h"

// NSUserDefaults import key
static NSString * const kDidImportDataKey = @"kDidImportData";

// JSON import keys
// Club
static NSString * const kClubsKey = @"clubs";
static NSString * const kClubId = @"clubId";
static NSString * const kClubName = @"clubName";
static NSString * const kClubStadiumName = @"stadiumName";
// Player
static NSString * const kPlayersKey = @"players";
static NSString * const kPlayerId = @"playerId";
static NSString * const kPlayerFirstName = @"firstName";
static NSString * const kPlayerLastName = @"lastName";
static NSString * const kPlayerPosition = @"position";
static NSString * const kPlayerShirtNumber = @"shirtNumber";
static NSString * const kPlayerClub = @"club";

// JSON
static NSString * const kJSonFileName = @"db";
static NSString * const kJSonFileType = @"json";

@interface DataImporter ()

@property (nonatomic, strong) NSManagedObjectContext *importerContext;
@property (nonatomic, strong) NSMutableDictionary *clubsById;

@end


@implementation DataImporter


#pragma mark - Init

- (instancetype)init {
    if (self = [super init]) {
        // Create a background context and asign it
        _importerContext = [[CoreDataManager sharedInstance] backgroundQueueManagedObjectContext];
        // Prepare a dictionary for clubs - clubId pairing
        _clubsById = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

#pragma mark - Importing data

- (BOOL)didImportData {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults boolForKey:kDidImportDataKey];
}

- (void)setDidImportData:(BOOL)didImportData {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:didImportData forKey:kDidImportDataKey];
    [userDefaults synchronize];
}

- (void)importData {
    NSDictionary *dictionary = [self jsonFileData];
    [self importDataFromDictionary:dictionary];
}

- (void)importDataFromDictionary:(NSDictionary *)dictionary {
    
    __weak typeof(self)weakSelf = self;
    
    [self.importerContext performBlockAndWait:^{
        // Create the clubs
        NSArray *clubs = [dictionary objectForKey:kClubsKey];
        [weakSelf createClubsUsingArray:clubs];
        
        // Create the players
        NSArray *players = [dictionary objectForKey:kPlayersKey];
        [weakSelf createPlayersUsingArray:players];
        
        __block NSError *error = nil;
        __block BOOL saved = [weakSelf.importerContext save:&error];
        if (saved && weakSelf.importerContext.parentContext) {
            [weakSelf.importerContext.parentContext performBlockAndWait:^{
                saved = [weakSelf.importerContext.parentContext save:&error];
            }];
        }
        
        if (!error) {
            // Mark data as imported
            [weakSelf setDidImportData:YES];
        } else {
            DDLogError(@"CoreData error: %@", error);
        }

    }];
}

#pragma mark - Club creation

- (void)createClubsUsingArray:(NSArray *)clubs {
    NSAssert(([clubs count] > 0), @"The clubs array should not be empty.");
    // Create a CoreDataClubManager
    CoreDataClubManager *clubManager = [[CoreDataClubManager alloc] initWithContext:self.importerContext];
    // Create the clubs
    for (NSDictionary *clubInfo in clubs) {
        [self createClubWithDictionary:clubInfo
                      usingClubManager:clubManager];
    }
}

- (void)createClubWithDictionary:(NSDictionary *)dictionary
                usingClubManager:(CoreDataClubManager *)clubManager
{
    // Get the club data
    NSNumber *clubId = [dictionary objectForKey:kClubId];
    NSString *clubName = [dictionary objectForKey:kClubName];
    NSString *stadiumName = [dictionary objectForKey:kClubStadiumName];
    
    // Create the club
    Club * club = [clubManager createClubWithName:clubName
                                           clubId:clubId];
    club.stadiumName = stadiumName;
    // Create a club - club id pairing for easy player creation
    [self.clubsById setObject:club
                       forKey:club.clubId];
}

#pragma mark - Player creation

- (void)createPlayersUsingArray:(NSArray *)players {
    NSAssert(([players count] > 0), @"The players array should not be empty.");
    // Create a CoreDataPlayerManager
    CoreDataPlayerManager *playerManager = [[CoreDataPlayerManager alloc] initWithContext:self.importerContext];
    // Create the players
    for (NSDictionary *playerInfo in players) {
        [self createPlayerWithDictionary:playerInfo
                      usingPlayerManager:playerManager];
    }
    
}

- (void)createPlayerWithDictionary:(NSDictionary *)dictionary
                usingPlayerManager:(CoreDataPlayerManager *)playerManager
{
    // Get player info
    NSString *firstName = [dictionary objectForKey:kPlayerFirstName];
    NSString *lastName = [dictionary objectForKey:kPlayerLastName];
    NSNumber *clubId = [dictionary objectForKey:kPlayerClub];
    // Create player object
    Player *player = [playerManager createPlayerWithFirstName:firstName
                                                     lastName:lastName];
    player.playerId = [dictionary objectForKey:kPlayerId];
    player.position = [dictionary objectForKey:kPlayerPosition];
    player.shirtNumber = [dictionary objectForKey:kPlayerShirtNumber];
    
    Club *club = [self.clubsById objectForKey:clubId];
    player.club = club;
    
}


#pragma mark - JSON file

- (NSDictionary *)jsonFileData {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:kJSonFileName
                                                         ofType:kJSonFileType];
    NSString *myJSON = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    NSError *error =  nil;
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:[myJSON dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    return jsonData;
}

@end
