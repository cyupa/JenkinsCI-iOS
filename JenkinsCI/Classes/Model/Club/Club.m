//
//  Club.m
//  JenkinsCI
//
//  Created by Ciprian Redinciuc on 17/10/14.
//  Copyright (c) 2014 Ciprian Redinciuc. All rights reserved.
//

#import "Club.h"
#import "Player.h"
#import <UIKit/UIKit.h>

@implementation Club

@dynamic clubName;
@dynamic stadiumName;
@dynamic clubId;
@dynamic squad;

@end

@implementation Club (Additions)

- (UIImage *)logoImage {
    NSString *strippedString = [self.clubName stringByReplacingOccurrencesOfString:@" " withString:@"-"];
    NSString *imageName = [NSString stringWithFormat:@"%@-logo", strippedString];
    return [UIImage imageNamed:imageName];
}

@end