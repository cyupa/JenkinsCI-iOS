//
//  PlayerTableViewCell.m
//  JenkinsCI
//
//  Created by Ciprian Redinciuc on 17/10/14.
//  Copyright (c) 2014 Ciprian Redinciuc. All rights reserved.
//

#import "PlayerTableViewCell.h"
#import "UIImageView+RoundCorners.h"

@implementation PlayerTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    CGFloat width = CGRectGetWidth(self.playerImageView.frame);
    [self.playerImageView applyCornerRadius:width/2
                                borderWidth:1.0
                                borderColor:[UIColor darkGrayColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (void)layoutSubviews {
//    [super layoutSubviews];
//}

@end
