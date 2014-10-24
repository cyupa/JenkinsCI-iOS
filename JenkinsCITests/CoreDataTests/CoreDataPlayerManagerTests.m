//
//  CoreDataPlayerManagerTests.m
//  JenkinsCI
//
//  Created by Ciprian Redinciuc on 24/10/14.
//  Copyright (c) 2014 Ciprian Redinciuc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "CoreDataPlayerManager.h"

@interface CoreDataPlayerManagerTests : XCTestCase

@property (nonatomic, strong) CoreDataPlayerManager *playerManager;

@end

@implementation CoreDataPlayerManagerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.playerManager = [[CoreDataPlayerManager alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    self.playerManager = nil;
}


- (void)testPlayerCreation {
    NSString *firstName = @"Ciprian";
    NSString *lastName = @"Redinciuc";
    Player *playerObject = [self.playerManager createPlayerWithFirstName:firstName
                                                                lastName:lastName];
    XCTAssertNotNil(playerObject, @"The object should not be nil");
    XCTAssertEqual(playerObject.firstName, firstName, @"The player first name should be equal to firstName");
    XCTAssertEqual(playerObject.lastName, lastName, @"The player last name should be equal to lastName");
}

- (void)testPlayerNoPicture {
    NSString *firstName = @"No";
    NSString *lastName = @"Picture";
    Player *playerObject = [self.playerManager createPlayerWithFirstName:firstName
                                                                lastName:lastName];
    UIImage *playerImage = [playerObject playerImage];
    XCTAssertNil(playerImage, @"The player image should be nil");
}

- (void)testPlayerWithPicture {
    NSString *firstName = @"Steven";
    NSString *lastName = @"Gerrard";
    Player *playerObject = [self.playerManager createPlayerWithFirstName:firstName
                                                                lastName:lastName];
    UIImage *playerImage = [playerObject playerImage];
    XCTAssertNotNil(playerImage, @"The player image should not be nil");
}

- (void)testPlayerFullName {
    NSString *firstName = @"Full";
    NSString *lastName = @"Name";
    Player *playerObject = [self.playerManager createPlayerWithFirstName:firstName
                                                                lastName:lastName];
    
    NSString *fullName = [playerObject playerFullName];
    NSString *expected = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    XCTAssertEqualObjects(fullName, expected, @"The expected full name should be FirstName LastName");
}

- (void)testPlayerDeletion {
    NSString *firstName = @"To Be";
    NSString *lastName = @"Deleted";
    Player *playerObject = [self.playerManager createPlayerWithFirstName:firstName
                                                                lastName:lastName];

    XCTAssertNoThrow([self.playerManager deletePlayer:playerObject]);
}



@end
