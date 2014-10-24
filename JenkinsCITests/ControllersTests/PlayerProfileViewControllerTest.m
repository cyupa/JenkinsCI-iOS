//
//  PlayerProfileViewControllerTest.m
//  JenkinsCI
//
//  Created by Ciprian Redinciuc on 24/10/14.
//  Copyright (c) 2014 Ciprian Redinciuc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "PlayerProfileViewController.h"
#import "Player.h"
#import "Club.h"

@interface PlayerProfileViewControllerTest : XCTestCase

@property (nonatomic, strong) PlayerProfileViewController *playerProfileViewController;
@property (nonatomic, strong) Player *player;
@property (nonatomic, strong) Club *club;

@end

@implementation PlayerProfileViewControllerTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.playerProfileViewController = [[PlayerProfileViewController alloc] init];
    
    // Wrong way of doing it
    self.player = [[Player alloc] init];
    self.player.firstName = @"Steven";
    self.player.lastName = @"Gerrard";
    self.player.shirtNumber = @8;
    self.player.position = @"Midfielder";
    self.club = [[Club alloc] init];
    self.club.clubName = @"Liverpool FC";
    self.player.club = self.club;
    
    self.playerProfileViewController.presentedPlayer = self.player;
    [self.playerProfileViewController viewWillAppear:NO];
}

- (void)tearDown {
    self.playerProfileViewController = nil;
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPlayerFirstNameLabel {
    XCTAssertEqualObjects(self.playerProfileViewController.playerFirstNameLabel.text,
                          self.player.firstName, @"Player first name is displayed wrong");
}

- (void)testPlayerLastNameLabel {
    XCTAssertEqualObjects(self.playerProfileViewController.playerLastNameLabel.text,
                          self.player.lastName, @"Player last name is displayed wrong");
}

- (void)testPlayerPositionLabel {
    XCTAssertEqualObjects(self.playerProfileViewController.playerPositionLabel.text,
                          self.player.position, @"Player position is displayed wrong");
}

- (void)testPlayerShirtNumberLabel {
    XCTAssertEqualObjects(self.playerProfileViewController.playerNumberLabel.text,
                          self.player.shirtNumber, @"Player shirt number is displayed wrong");
}

@end
