//
//  CoreDataManager.h
//  JenkinsCI
//
//  Created by Ciprian Redinciuc on 20/07/14.
//  Copyright (c) 2014 Endava. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

/**
 *  Singleton class that manages the CoreData stack.
 */
@interface CoreDataManager : NSObject

/**
 *  The main queue priority NSManagedObjectContext instance.
 */
@property (nonatomic, strong, readonly) NSManagedObjectContext *mainManagedObjectContext;

/**
 *  Returns a pointer to the singleton class instance.
 *
 *  @return CoreDataManager instance.
 */
+ (instancetype)sharedInstance;

/**
 *  Saves the main queue priority context.
 */
- (void)saveContext;

/**
 *  Performs a fetch request on the main queue managed object context with a set of
 *  required parameters.
 *
 *  @param entityName NSString instance representing a CoreData entity name.
 *  @param predicate  NSPredicate instance describing the fetch rule.
 *  @param sortingKey NSString instance representing the entity property by which the sorting will be done.
 *  @param ascending  YES - Ascending.
 *
 *  @return NSArray of NSManagedObject instances of that entityName type.
 */
- (NSArray *)fetchObjectsWithEntityName:(NSString *)entityName
                              predicate:(NSPredicate *)predicate
                             sortingKey:(NSString *)sortingKey
                              ascending:(BOOL)ascending;


/**
 *  Creates a NSFetchedResultsController with a set of parameters.
 *
 *  @param entityName The entity name to fetch.
 *  @param predicate  The NSPredicate instance for the search.
 *  @param sortingKey The fetch sorting key.
 *  @param ascending  YES - ascending.
 *  @param delegate   The delegate for the search.
 *
 *  @return NSFetchedResultsController instance.
 */
- (NSFetchedResultsController *)fetchedResultsControllerWithEntityName:(NSString *)entityName
                                                             predicate:(NSPredicate *)predicate
                                                            sortingKey:(NSString *)sortingKey
                                                             ascending:(BOOL)ascending
                                                              delegate:(id<NSFetchedResultsControllerDelegate>)delegate;

/**
 *  Returns a newly instantiated NSManagedObjectContext with a private queue priority.
 *
 *  @return NSManagedObjectContext instance.
 */
@property (nonatomic, strong, readonly) NSManagedObjectContext *backgroundQueueManagedObjectContext;

@end
