//
//  ClubsViewController+UITableViewDatasource.h
//  JenkinsCI
//
//  Created by Ciprian Redinciuc on 20/10/14.
//  Copyright (c) 2014 Ciprian Redinciuc. All rights reserved.
//

#import "ClubsViewController.h"

@interface ClubsViewController (UITableViewDatasource) <UITableViewDataSource>

- (void)configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

@end
