//
//  PlayersViewController+UITableViewDatasource.m
//  JenkinsCI
//
//  Created by Ciprian Redinciuc on 20/10/14.
//  Copyright (c) 2014 Ciprian Redinciuc. All rights reserved.
//

#import "PlayersViewController+UITableViewDatasource.h"
#import "PlayerTableViewCell.h"
#import "Player.h"
#import "Club.h"

static NSString * const kPlayerCellIdentifier = @"_playerCell";

@implementation PlayersViewController (UITableViewDatasource)


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [[self.fetchedResultsController fetchedObjects] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPlayerCellIdentifier
                                                            forIndexPath:indexPath];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    Player *player = [self.fetchedResultsController objectAtIndexPath:indexPath];
    PlayerTableViewCell *playerCell = (PlayerTableViewCell *)cell;
    
    playerCell.playerFullNameLabel.text = [player playerFullName];
    playerCell.playerImageView.image =  [player playerImage];
    playerCell.playerPositionLabel.text = player.position;
    playerCell.clubNameLabel.text = player.club.clubName;
}


@end
