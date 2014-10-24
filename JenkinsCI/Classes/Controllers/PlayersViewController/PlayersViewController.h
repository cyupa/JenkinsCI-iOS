//
//  PlayersViewController.h
//  JenkinsCI
//
//  Created by Ciprian Redinciuc on 17/10/14.
//  Copyright (c) 2014 Ciprian Redinciuc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataManager.h"
#import "FetchedResultsTableViewController.h"

@interface PlayersViewController : FetchedResultsTableViewController

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end
