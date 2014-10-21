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
 *  Creates a NSManagedObject with a given entity name on the passed NSManagedObjectContext.
 *
 *  @param entityName NSString representing a valid entity name.
 *  @param context    The NSManagedObjectContext on which the object will be created.
 *
 *  @return NSManagedObject instance or nil.
 */
- (NSManagedObject *)createNSManagedObjectWithEntityName:(NSString *)entityName
                                               onContext:(NSManagedObjectContext *)context;

@end
