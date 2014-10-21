//
//  SquadViewController+TableViewDatasource.h
//  JenkinsCI
//
//  Created by Ciprian Redinciuc on 20/10/14.
//  Copyright (c) 2014 Ciprian Redinciuc. All rights reserved.
//

#import "SquadViewController.h"

@interface SquadViewController (TableViewDatasource) <UITableViewDataSource>

- (void)configureCell:(UITableViewCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath;

@end
