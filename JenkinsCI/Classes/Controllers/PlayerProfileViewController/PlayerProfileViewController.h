//
//  PlayerProfileViewController.h
//  JenkinsCI
//
//  Created by Ciprian Redinciuc on 17/10/14.
//  Copyright (c) 2014 Ciprian Redinciuc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Player;

@interface PlayerProfileViewController : UIViewController

@property (nonatomic, strong) Player *presentedPlayer;

// Interface outlets
@property (weak, nonatomic) IBOutlet UILabel *playerNumberLabel;
@property (weak, nonatomic) IBOutlet UIImageView *playerAvatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *playerFirstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerLastNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *clubNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *clubLogoImageView;
@property (weak, nonatomic) IBOutlet UILabel *playerPositionLabel;


@end
