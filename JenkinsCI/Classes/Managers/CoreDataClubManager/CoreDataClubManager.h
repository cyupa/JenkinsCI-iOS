//
//  CoreDataClubManager.h
//  JenkinsCI
//
//  Created by Ciprian Redinciuc on 14/10/14.
//  Copyright (c) 2014 Ciprian Redinciuc. All rights reserved.
//

#import "CoreDataEntityManager.h"
#import "Club.h"

@interface CoreDataClubManager : CoreDataEntityManager

/**
 *  Method that creates a Club with a given name and stadium name.
 *
 *  @param clubName    The club name.
 *  @param clubId      The club id.
 *
 *  @return Club instance.
 */
- (Club *)createClubWithName:(NSString *)clubName
                      clubId:(NSNumber *)clubId;

/**
 *  Deletes a club from its managed object context.
 *
 *  @param club Club object.
 */
- (void)deleteClub:(Club *)club;

@end
