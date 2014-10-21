//
//  CoreDataEntityManager.m
//  JenkinsCI
//
//  Created by Ciprian Redinciuc on 14/10/14.
//  Copyright (c) 2014 Ciprian Redinciuc. All rights reserved.
//

#import "CoreDataEntityManager.h"

@implementation CoreDataEntityManager

- (NSManagedObject *)createNSManagedObjectWithEntityName:(NSString *)entityName
                                               onContext:(NSManagedObjectContext *)context
{
    return [NSEntityDescription insertNewObjectForEntityForName:entityName
                                         inManagedObjectContext:context];
}

@end
