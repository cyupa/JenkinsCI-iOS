//
//  CoreDataPlayerManager.m
//  JenkinsCI
//
//  Created by Ciprian Redinciuc on 14/10/14.
//  Copyright (c) 2014 Ciprian Redinciuc. All rights reserved.
//

#import "CoreDataPlayerManager.h"
#import "CoreDataManager.h"

@implementation CoreDataPlayerManager

- (Player *)createPlayerWithFirstName:(NSString *)firstName
                             lastName:(NSString *)lastName
{
    // Get the player class name
    NSString *playerClassName = NSStringFromClass([Player class]);
    // Get the main context
    NSManagedObjectContext *context = [[CoreDataManager sharedInstance] mainManagedObjectContext];
    // Create the entity
    Player *playerObject = (Player *)[self createNSManagedObjectWithEntityName:playerClassName
                                                                     onContext:context];
    // Set it's properties
    playerObject.firstName = firstName;
    playerObject.lastName = lastName;
    
    return playerObject;
}

@end
