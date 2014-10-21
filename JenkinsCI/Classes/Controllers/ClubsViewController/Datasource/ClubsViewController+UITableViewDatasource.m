//
//  ClubsViewController+UITableViewDatasource.m
//  JenkinsCI
//
//  Created by Ciprian Redinciuc on 20/10/14.
//  Copyright (c) 2014 Ciprian Redinciuc. All rights reserved.
//

#import "ClubsViewController+UITableViewDatasource.h"
#import "ClubTableViewCell.h"
#import "Club.h"

static NSString * const kClubsCellIdentifier = @"_clubCell";

@implementation ClubsViewController (UITableViewDatasource)


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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kClubsCellIdentifier
                                                            forIndexPath:indexPath];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    Club *club = [self.fetchedResultsController objectAtIndexPath:indexPath];
    ClubTableViewCell *clubCell = (ClubTableViewCell *)cell;
    
    clubCell.clubNameLabel.text = club.clubName;
    clubCell.clubLogoView.image = [club logoImage];
    clubCell.squadSizeLabel.text = [self squadSizeForClub:club];

}


- (NSString *)squadSizeForClub:(Club *)club {
    NSInteger size = [club.squad count];
    NSString *squadSize;
    switch (size) {
        case 0:
            squadSize = @"No players";
            break;
        case 1:
            squadSize = @"One player";
            break;
        default:
            squadSize = [NSString stringWithFormat:@"%li players", size];
            break;
    }
    
    return squadSize;
}

@end
