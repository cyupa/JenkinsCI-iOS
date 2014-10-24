//
//  PlayersViewController.m
//  JenkinsCI
//
//  Created by Ciprian Redinciuc on 17/10/14.
//  Copyright (c) 2014 Ciprian Redinciuc. All rights reserved.
//

#import "PlayersViewController.h"
#import "PlayerProfileViewController.h"
#import "Player.h"


static NSString * const kPlayerFetchEntityName = @"Player";
static NSString * const kPlayerFetchSortingKeyLast = @"lastName";
static NSString * const kPlayerFetchSortingKeyFirst = @"firstName";

static NSString * const kPresentPlayerSegue = @"segue_playersShowPlayer";

@interface PlayersViewController ()

@end

@implementation PlayersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self setupPlayersFetchedResultsController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setupPlayersFetchedResultsController {
    CoreDataManager *manager = [CoreDataManager sharedInstance];
    NSArray *sortingKeys = @[kPlayerFetchSortingKeyLast, kPlayerFetchSortingKeyFirst];
    self.fetchedResultsController = [manager fetchedResultsControllerWithEntityName:kPlayerFetchEntityName
                                                                          predicate:nil
                                                                        sortingKeys:sortingKeys
                                                                     sectionNameKey:nil
                                                                          ascending:YES
                                                                           delegate:self];
    
    NSError *error = nil;
    [self.fetchedResultsController performFetch:&error];
    if (error) {
        DDLogError(@"Fetch Erorr: %@", error);
    }
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    if ([[segue identifier] isEqualToString:kPresentPlayerSegue]) {
        PlayerProfileViewController *playerViewController = (PlayerProfileViewController *)segue.destinationViewController;
        Player *player = [self.fetchedResultsController objectAtIndexPath:self.tableView.indexPathForSelectedRow];
        [playerViewController setPresentedPlayer:player];
    }
}



@end
