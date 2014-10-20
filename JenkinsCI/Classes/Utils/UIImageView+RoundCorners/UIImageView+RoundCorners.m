//
//  UIImageView+RoundCorners.m
//  JenkinsCI
//
//  Created by Ciprian Redinciuc on 20/10/14.
//  Copyright (c) 2014 Ciprian Redinciuc. All rights reserved.
//

#import "UIImageView+RoundCorners.h"
@import QuartzCore;

@implementation UIImageView (RoundCorners)

- (void)applyCornerRadius:(CGFloat)radius
              borderWidth:(CGFloat)border
              borderColor:(UIColor *)color
{
    self.layer.cornerRadius = radius;
    self.clipsToBounds = YES;
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = border;
}

@end
