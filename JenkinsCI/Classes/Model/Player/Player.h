//
//  Player.h
//  JenkinsCI
//
//  Created by Ciprian Redinciuc on 14/10/14.
//  Copyright (c) 2014 Ciprian Redinciuc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Club;

@interface Player : NSManagedObject

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * position;
@property (nonatomic, retain) Club *club;

@end
