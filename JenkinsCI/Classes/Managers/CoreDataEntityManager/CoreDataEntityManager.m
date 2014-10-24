//
//  CoreDataEntityManager.m
//  JenkinsCI
//
//  Created by Ciprian Redinciuc on 14/10/14.
//  Copyright (c) 2014 Ciprian Redinciuc. All rights reserved.
//

#import "CoreDataEntityManager.h"

@implementation CoreDataEntityManager

- (instancetype)initWithContext:(NSManagedObjectContext *)context {
    
    NSAssert((context != nil && [context isKindOfClass:[NSManagedObjectContext class]]),
             @"The NSManagedObjectContext must not be nil or of any other type.");
    
    if (self = [super init]) {
        // Set the managed object context
        _managedObjectContext = context;
    }
    
    return self;
}

- (NSManagedObject *)createNSManagedObjectWithEntityName:(NSString *)entityName
                                               onContext:(NSManagedObjectContext *)context
{
    return [NSEntityDescription insertNewObjectForEntityForName:entityName
                                         inManagedObjectContext:context];
}

- (void)deleteObject:(NSManagedObject *)object {
    NSManagedObjectContext *context = object.managedObjectContext;
    [context deleteObject:object];
    object = nil;
}

@end
