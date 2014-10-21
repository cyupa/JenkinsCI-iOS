//
//  CoreDataEntityManager.h
//  JenkinsCI
//
//  Created by Ciprian Redinciuc on 14/10/14.
//  Copyright (c) 2014 Ciprian Redinciuc. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreData;

/**
 *  Base class for CoreData manager classes.
 */
@interface CoreDataEntityManager : NSObject

/**
 *  The NSManagedObjectContext on which the CoreDataEntityManager instace will operate on.
 */
@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;

/**
 *  Designated initializer.
 *
 *  @param context Instantiates a CoreDataEntityManager with a given context.
 *
 *  @return CoreDataEntityManager instance.
 */
- (instancetype)initWithContext:(NSManagedObjectContext *)context;

/**
 *  Creates a NSManagedObject with a given entity name on the passed NSManagedObjectContext.
 *
 *  @param entityName NSString representing a valid entity name.
 *  @param context    The NSManagedObjectContext on which the object will be created.
 *
 *  @return NSManagedObject instance or nil.
 */
- (NSManagedObject *)createNSManagedObjectWithEntityName:(NSString *)entityName
                                               onContext:(NSManagedObjectContext *)context;

/**
 *  Deletes an object from its managed object context.
 *
 *  @param object The NSManagedObject instance to be deleted;
 */
- (void)deleteObject:(NSManagedObject *)object;

@end
