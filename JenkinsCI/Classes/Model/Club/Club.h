//
//  Club.h
//  JenkinsCI
//
//  Created by Ciprian Redinciuc on 17/10/14.
//  Copyright (c) 2014 Ciprian Redinciuc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Player;

@interface Club : NSManagedObject

@property (nonatomic, retain) NSString * clubName;
@property (nonatomic, retain) NSString * stadiumName;
@property (nonatomic, retain) NSNumber * clubId;
@property (nonatomic, retain) NSSet *squad;
@end

@interface Club (CoreDataGeneratedAccessors)

- (void)addSquadObject:(Player *)value;
- (void)removeSquadObject:(Player *)value;
- (void)addSquad:(NSSet *)values;
- (void)removeSquad:(NSSet *)values;

@end

@interface Club (Additions)

- (UIImage *)logoImage;

@end
