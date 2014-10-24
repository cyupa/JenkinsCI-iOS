//
//  PlayersViewControllerTests.m
//  JenkinsCI
//
//  Created by Ciprian Redinciuc on 24/10/14.
//  Copyright (c) 2014 Ciprian Redinciuc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "PlayersViewController.h"

@interface PlayersViewControllerTests : XCTestCase

@property (nonatomic, strong) PlayersViewController *playersViewController;

@end

@implementation PlayersViewControllerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.playersViewController = [[PlayersViewController alloc] init];
    [self.playersViewController viewDidLoad];
    
}

- (void)tearDown {
    self.playersViewController = nil;
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testNSFecthedResultsController {
    XCTAssertNotNil(self.playersViewController.fetchedResultsController, @"The NSFetchedResultsController should not be nil");
}


@end
