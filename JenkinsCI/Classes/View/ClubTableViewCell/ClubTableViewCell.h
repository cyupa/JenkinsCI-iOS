//
//  ClubTableViewCell.h
//  JenkinsCI
//
//  Created by Ciprian Redinciuc on 17/10/14.
//  Copyright (c) 2014 Ciprian Redinciuc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClubTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *clubNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *squadSizeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *clubLogoView;

@end
