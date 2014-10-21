//
//  SquadViewController+TableViewDatasource.m
//  JenkinsCI
//
//  Created by Ciprian Redinciuc on 20/10/14.
//  Copyright (c) 2014 Ciprian Redinciuc. All rights reserved.
//

#import "SquadViewController+TableViewDatasource.h"
#import "SquadProfileTableViewCell.h"
#import "Player.h"

static NSString * const kSquadCellIdentifier = @"_squadProfileCell";

@implementation SquadViewController (TableViewDatasource)


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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSquadCellIdentifier
                                                            forIndexPath:indexPath];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    SquadProfileTableViewCell *playerCell = (SquadProfileTableViewCell *)cell;
    Player *player = [self.fetchedResultsController objectAtIndexPath:indexPath];
    playerCell.playerFullNameLabel.text = [player playerFullName];
    playerCell.playerNumberLabel.text = [player.shirtNumber stringValue];
    playerCell.playerPictureView.image = [player playerImage];
    playerCell.playerPositionLabel.text = player.position;
}


@end
