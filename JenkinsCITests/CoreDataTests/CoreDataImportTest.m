//
//  CoreDataImportTest.m
//  JenkinsCI
//
//  Test cases for CoreDataImportTest.
//  Setup will instantiate an instance from the storyboard.
//
//  Instructions: modify setup to match the names of your storyboard and vc.
//
//  Created by Ciprian Redinciuc on 24/10/14.
//  Copyright (c) 2014 Ciprian Redinciuc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CoreDataManager.h"
#import "DataImporter.h"



@interface CoreDataImportTest : XCTestCase

@property   (nonatomic, strong) NSPersistentStoreCoordinator    *coordinator;
@property   (nonatomic, strong) CoreDataManager                 *manager;
@property   (nonatomic, strong) DataImporter                    *dataImporter;
@end

@implementation CoreDataImportTest
@synthesize coordinator;

- (void)setUp {
	NSError                         *error                          = nil;
	NSManagedObjectModel            *managedObjectModel             = nil;
	NSPersistentStoreCoordinator    *persistentStoreCoordinator     = nil;

	[super setUp];

	// Create a managed object model from the test bundle.
	managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:[NSArray arrayWithObject:[NSBundle mainBundle]] ];
	persistentStoreCoordinator  = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];

	// Register a custom store class.
	if ([self storeClass] != nil){
		[[persistentStoreCoordinator class] registerStoreClass:[self storeClass] forStoreType:[self storeType]];
	}
	
	[self setCoordinator:persistentStoreCoordinator];
	// Add the store to the coordinator
    // Note that in many cases, a test should also remove any previously created file at the storeURL location.
	// Doing so should work as follows:
	// [[NSFileManager defaultManager] removeItemAtURL:[self storeURL] error:&error];
	if (![[self coordinator] addPersistentStoreWithType:[self storeType] configuration:nil URL:[self storeURL] options:[self storeOptions] error:&error]){
	    XCTFail(@"Could not add store, %@", error);
	}
    
    self.manager = [CoreDataManager sharedInstance];
    self.dataImporter = [[DataImporter alloc] init];
    [self.dataImporter setDidImportData:NO];
    
    if (!self.dataImporter.didImportData) {
        [self.dataImporter importData];
    } else {
        XCTFail(@"The data import should be done at each step to ensure correct results");
    }
}

- (void)tearDown {
	NSPersistentStore   *store  = nil;
	NSError             *error  = nil;

	store = [[self coordinator] persistentStoreForURL:[self storeURL]];
	// Remove the store from the coordinator. If this fails that is fine.
	if (store != nil){
		[[self coordinator] removePersistentStore:store error:&error];
	}
	// Note that in many cases, a test should also remove any file created at the storeURL location.
	// Doing so should work as follows:
	[[NSFileManager defaultManager] removeItemAtURL:[self storeURL] error:&error];
	// Unregister the store
	if ([self storeClass] != nil){
		[[[self coordinator] class] registerStoreClass:nil forStoreType:[self storeType]];
	}
    self.manager = nil;
    
    [self.dataImporter setDidImportData:NO];
    self.dataImporter = nil;
    
	[super tearDown];
}

- (NSURL *)storeURL {
	NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
	return [url URLByAppendingPathComponent:@"JenkinsCI.sqlite"];
}

- (NSString *)storeType {
    return NSSQLiteStoreType;
}

- (Class )storeClass {
	// Only override if you are testing a custom store, such as an NSAtomicStore or NSIncrementalStore
	return nil;
}

- (NSDictionary *)storeOptions {
	return @{NSPersistentStoreFileProtectionKey : NSFileProtectionComplete};
}

- (void)testFetchDoesNotThrowException {
	NSManagedObjectContext  *context        = nil;
	NSError                 *error          = nil;
	NSPredicate             *predicate      = nil;
	NSEntityDescription	*entity		= nil;
	NSFetchRequest          *fetchRequest   = nil;
	
	// Note that in a production application you should not use NSConfinementConcurrencyType. 
	context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSConfinementConcurrencyType];
	[context setPersistentStoreCoordinator:[self coordinator]];

	entity = [[[[context persistentStoreCoordinator] managedObjectModel] entities] lastObject];
	fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[entity name]];
	// A nil predicate will return everything.
	[fetchRequest setPredicate:predicate];

	// The objective for this test is to perform a fetch without throwing an exception.
	XCTAssertNoThrow([context executeFetchRequest:fetchRequest error:&error], @"Fetch threw exception.");
}

- (void)testImportFalse {
    [self.dataImporter setDidImportData:NO];
    XCTAssertFalse(self.dataImporter.didImportData, @"DataImporter's importData should be false");
}

- (void)testImportTrue {
    [self.dataImporter importData];
    XCTAssertTrue(self.dataImporter.didImportData, @"DataImporter's importData should be true");
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