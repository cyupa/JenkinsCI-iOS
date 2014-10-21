//
//  SquadProfileTableViewCell.m
//  JenkinsCI
//
//  Created by Ciprian Redinciuc on 17/10/14.
//  Copyright (c) 2014 Ciprian Redinciuc. All rights reserved.
//

#import "SquadProfileTableViewCell.h"
#import "UIImageView+RoundCorners.h"

@implementation SquadProfileTableViewCell

- (void)awakeFromNib {
    // Initialization code
    CGFloat width = CGRectGetWidth(self.playerPictureView.frame);
    [self.playerPictureView applyCornerRadius:width/2
                                  borderWidth:1.0
                                  borderColor:[UIColor darkGrayColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
