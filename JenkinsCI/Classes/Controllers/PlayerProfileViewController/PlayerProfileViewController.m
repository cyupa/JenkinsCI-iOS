//
//  PlayerProfileViewController.m
//  JenkinsCI
//
//  Created by Ciprian Redinciuc on 17/10/14.
//  Copyright (c) 2014 Ciprian Redinciuc. All rights reserved.
//

#import "PlayerProfileViewController.h"
#import "Player.h"
#import "Club.h"

@interface PlayerProfileViewController ()

@end

@implementation PlayerProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = [self.presentedPlayer playerFullName];
    [self setupPlayerView];
}

- (void)setupPlayerView {
    self.playerFirstNameLabel.text = self.presentedPlayer.firstName;
    self.playerLastNameLabel.text = self.presentedPlayer.lastName;
    self.playerAvatarImageView.image = [self.presentedPlayer playerImage];
    self.playerPositionLabel.text = self.presentedPlayer.position;
    self.clubNameLabel.text = self.presentedPlayer.club.clubName;
    self.clubLogoImageView.image = [self.presentedPlayer.club logoImage];
    self.playerNumberLabel.text = [NSString stringWithFormat:@"No. %@", self.presentedPlayer.shirtNumber];
}


@end
