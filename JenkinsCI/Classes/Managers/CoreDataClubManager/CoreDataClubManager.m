//
//  CoreDataClubManager.m
//  JenkinsCI
//
//  Created by Ciprian Redinciuc on 14/10/14.
//  Copyright (c) 2014 Ciprian Redinciuc. All rights reserved.
//

#import "CoreDataClubManager.h"
#import "CoreDataManager.h"

@implementation CoreDataClubManager

- (Club *)createClubWithName:(NSString *)clubName
                      clubId:(NSNumber *)clubId
{
    // Get the club class name
    NSString *clubClassName = NSStringFromClass([Club class]);
    // Get the main context
    NSManagedObjectContext *context = [[CoreDataManager sharedInstance] mainManagedObjectContext];
    // Create the entity
    Club *clubObject = (Club *)[self createNSManagedObjectWithEntityName:clubClassName
                                                               onContext:context];
    // Set it's properties
    clubObject.clubName = clubName;
    clubObject.clubId = clubId;
    
    return clubObject;
}

- (void)deleteClub:(Club *)club {
    [self deleteObject:club];
}

@end
