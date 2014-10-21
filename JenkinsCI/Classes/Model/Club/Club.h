//
//  Club.h
//  JenkinsCI
//
//  Created by Ciprian Redinciuc on 14/10/14.
//  Copyright (c) 2014 Ciprian Redinciuc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Club : NSManagedObject

@property (nonatomic, retain) NSString * clubName;
@property (nonatomic, retain) NSString * stadiumName;
@property (nonatomic, retain) NSSet *squad;
@end

@interface Club (CoreDataGeneratedAccessors)

- (void)addSquadObject:(NSManagedObject *)value;
- (void)removeSquadObject:(NSManagedObject *)value;
- (void)addSquad:(NSSet *)values;
- (void)removeSquad:(NSSet *)values;

@end
