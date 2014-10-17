//
//  CoreDataPlayerManager.h
//  JenkinsCI
//
//  Created by Ciprian Redinciuc on 14/10/14.
//  Copyright (c) 2014 Ciprian Redinciuc. All rights reserved.
//

#import "CoreDataEntityManager.h"
#import "Player.h"

@interface CoreDataPlayerManager : CoreDataEntityManager

/**
 *  Creates a Player entity object with a first name and a last name.
 *
 *  @param firstName Player's first name.
 *  @param lastName  Player's last name.
 *
 *  @return Player instance.
 */
- (Player *)createPlayerWithFirstName:(NSString *)firstName
                             lastName:(NSString *)lastName;


- (void)deletePlayer:(Player *)player;

@end
