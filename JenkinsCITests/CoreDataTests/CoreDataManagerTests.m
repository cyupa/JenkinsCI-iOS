//
//  CoreDataManagerTests.m
//  JenkinsCI
//
//  Created by Ciprian Redinciuc on 22/10/14.
//  Copyright (c) 2014 Ciprian Redinciuc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "CoreDataManager.h"

@interface CoreDataManagerTests : XCTestCase

@property (nonatomic, strong) CoreDataManager *manager;

@end

@implementation CoreDataManagerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    _manager = [CoreDataManager sharedInstance];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    _manager = nil;
}

- (void)testSingleton {
    CoreDataManager *instanceB = [CoreDataManager sharedInstance];
    
    XCTAssertEqualObjects(self.manager, instanceB, @"The CoreDataManager singleton fails.");
}

- (void)testValidManagedObjectContext {
    XCTAssertNotNil(self.manager.mainManagedObjectContext, @"The CoreDataManager main managed object context should not be nil.");
}

- (void)testDifferentBackgroundManagedObjectContexts {
    NSManagedObjectContext *firstCall = [self.manager backgroundQueueManagedObjectContext];
    NSManagedObjectContext *secondCall = [self.manager backgroundQueueManagedObjectContext];
    
    XCTAssertNotEqualObjects(firstCall, secondCall, @"Two consecutive calls on the backgroundQueueManagedObjectContext getter should return different objects.");
}

- (void)testParentContext {
    NSManagedObjectContext *backgroundContext = [self.manager backgroundQueueManagedObjectContext];
    
    XCTAssertEqualObjects(self.manager.mainManagedObjectContext, backgroundContext.parentContext, @"Each newly created background context should have the main managed object context set as it's parent context.");
}

- (void)testEmptyFetch {
    NSArray *fetchedObjects = [self.manager fetchObjectsWithEntityName:@"Player"
                                                             predicate:[NSPredicate predicateWithFormat:@"firstName like %@", @"Viorel"]
                                                           sortingKeys:@[@"playerId"]
                                                             ascending:YES];
    XCTAssertEqual([fetchedObjects count], 0, @"This fetch should return an empty array.");
}

- (void)testOneFetch {
    NSArray *fetchedObjects = [self.manager fetchObjectsWithEntityName:@"Player"
                                                             predicate:[NSPredicate predicateWithFormat:@"lastName like %@", @"Gerrard"]
                                                           sortingKeys:@[@"playerId"]
                                                             ascending:YES];
    XCTAssertEqual([fetchedObjects count], 1, @"This fetch should return a single result in the array.");
}

- (void)testNSFetchedResultsController {
    NSFetchedResultsController *controller = [self.manager fetchedResultsControllerWithEntityName:@"Player"
                                                                                        predicate:[NSPredicate predicateWithFormat:@"club.clubName like %@", @"Liverpool FC"]
                                                                                      sortingKeys:@[@"firstName", @"lastName"]
                                                                                   sectionNameKey:nil
                                                                                        ascending:YES
                                                                                         delegate:nil];
    NSError *error = nil;
    [controller performFetch:&error];
    XCTAssertNil(error, @"The fetch should not return any errors");
    
    XCTAssertEqual([controller.fetchedObjects count], 4, @"The NSFetchedResultsController should fetch 4 objects.");
}

@end
