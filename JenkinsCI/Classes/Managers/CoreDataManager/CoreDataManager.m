//
//  CoreDataManager.m
//  JenkinsCI
//
//  Created by Ciprian Redinciuc on 20/07/14.
//  Copyright (c) 2014 Endava. All rights reserved.
//

#import "CoreDataManager.h"

@interface CoreDataManager ()

@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory;

@end

@implementation CoreDataManager

@synthesize mainManagedObjectContext = _mainManagedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

#pragma mark - Initialization

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    __strong static id _sharedObject = nil;

    dispatch_once(&onceToken, ^{
        _sharedObject = [[self alloc] init];
    });
    
    return _sharedObject;
}


#pragma mark - CoreData Operations
- (void)saveContext {
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.mainManagedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            
            DDLogWarn(@"Unresolved error main context %@, %@", error, [error userInfo]);
            
            NSArray * conflictListArray = (NSArray*)[[error userInfo] objectForKey:@"conflictList"];
            DDLogWarn(@"conflict array: %@",conflictListArray);
            NSError * conflictFixError = nil;
            
            if ([conflictListArray count] > 0) {
                
                NSMergePolicy *mergePolicy = [[NSMergePolicy alloc] initWithMergeType:NSOverwriteMergePolicyType];
                
                if (![mergePolicy resolveConflicts:conflictListArray error:&conflictFixError]) {
                    DDLogError(@"Unresolved conflict error %@, %@", conflictFixError, [conflictFixError userInfo]);
                    DDLogError(@"abort");
                    abort();
                }
            }
        }
    }
    if (error) {
        DDLogError(@"Unresolved conflict error %@", [error userInfo]);
    }
}

- (NSArray *)fetchObjectsWithEntityName:(NSString *)entityName
                              predicate:(NSPredicate *)predicate
                             sortingKey:(NSString *)sortingKey
                              ascending:(BOOL)ascending
{
    
    // Create a fetch request with a specific entity
    NSFetchRequest *fetchRequest = [self fetchRequestWithEntityName:entityName
                                                          predicate:predicate
                                                         sortingKey:sortingKey
                                                          ascending:ascending];
    NSError *error = nil;
    NSArray *fetchedObjects = [self.mainManagedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (error) {
        DDLogError(@"Fetch Error: %@", [error description]);
    }
    
    return fetchedObjects;
}

- (NSFetchedResultsController *)fetchedResultsControllerWithEntityName:(NSString *)entityName
                                                             predicate:(NSPredicate *)predicate
                                                            sortingKey:(NSString *)sortingKey
                                                             ascending:(BOOL)ascending
                                                              delegate:(id<NSFetchedResultsControllerDelegate>)delegate
{
    
    NSFetchRequest *fetchRequest = [self fetchRequestWithEntityName:entityName
                                                          predicate:predicate
                                                         sortingKey:sortingKey
                                                          ascending:ascending];
    
    NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                               managedObjectContext:self.mainManagedObjectContext
                                                                                                 sectionNameKeyPath:nil
                                                                                                          cacheName:nil];
    fetchedResultsController.delegate = delegate;
    
    NSError *error = nil;
    if (![fetchedResultsController performFetch:&error]) {
        NSLog(@"Error: %@", error);
    }
    
    return fetchedResultsController;
}

- (NSFetchRequest *)fetchRequestWithEntityName:(NSString *)entityName
                                     predicate:(NSPredicate *)predicate
                                    sortingKey:(NSString *)sortingKey
                                     ascending:(BOOL)ascending
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:entityName];
    fetchRequest.predicate = predicate;
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:sortingKey ascending:ascending];
    fetchRequest.sortDescriptors = @[sortDescriptor];
    fetchRequest.returnsObjectsAsFaults = NO;
    
    return fetchRequest;
}

#pragma mark - CoreData stack

- (NSManagedObjectContext *)mainManagedObjectContext {
    if (_mainManagedObjectContext != nil) {
        return _mainManagedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        // Make sure the main object context executes on the main queue
        _mainManagedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_mainManagedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _mainManagedObjectContext;
}

- (NSManagedObjectContext*)backgroundQueueManagedObjectContext {
    
    // Make sure the background context executes on a private queue
    NSManagedObjectContext *backgroundQueueManagedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    // Set the background context's parent to be the main context
    [backgroundQueueManagedObjectContext setParentContext:self.mainManagedObjectContext];
    [backgroundQueueManagedObjectContext setUndoManager:nil];
    
    return backgroundQueueManagedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Doozy" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Doozy.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:@{NSPersistentStoreFileProtectionKey : NSFileProtectionComplete} error:&error]) {
        
        DDLogError(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


@end
