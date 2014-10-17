//
//  SquadProfileTableViewCell.h
//  JenkinsCI
//
//  Created by Ciprian Redinciuc on 17/10/14.
//  Copyright (c) 2014 Ciprian Redinciuc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SquadProfileTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *playerFullNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerPositionLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerNumberLabel;
@property (weak, nonatomic) IBOutlet UIImageView *playerPictureView;

@end
