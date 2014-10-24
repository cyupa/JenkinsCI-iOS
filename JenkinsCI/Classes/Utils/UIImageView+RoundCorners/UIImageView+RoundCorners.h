//
//  UIImageView+RoundCorners.h
//  JenkinsCI
//
//  Created by Ciprian Redinciuc on 20/10/14.
//  Copyright (c) 2014 Ciprian Redinciuc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (RoundCorners)

/**
 *  Applies a corner radius to a given UIImageView with a border
 *  with and color.
 *
 *  @param radius Radius value.
 *  @param border Border width.
 *  @param color  Border color.
 */
- (void)applyCornerRadius:(CGFloat)radius
              borderWidth:(CGFloat)border
              borderColor:(UIColor *)color;

@end
