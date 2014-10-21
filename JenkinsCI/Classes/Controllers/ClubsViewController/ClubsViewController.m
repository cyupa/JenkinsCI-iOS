//
//  ClubsViewController.m
//  JenkinsCI
//
//  Created by Ciprian Redinciuc on 17/10/14.
//  Copyright (c) 2014 Ciprian Redinciuc. All rights reserved.
//

#import "ClubsViewController.h"
#import "ClubsViewController+NSFetchedResultsController.h"
#import "SquadViewController.h"

static NSString * const kClubFetchEntityName = @"Club";
static NSString * const kClubFetchSortingKey = @"clubName";

static NSString * const kPresentSquadSegueIdentifier = @"segue_clubsShowSquad";

@interface ClubsViewController ()

@end

@implementation ClubsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self setupClubsFetchedResultsControler];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupClubsFetchedResultsControler {
    CoreDataManager *manager = [CoreDataManager sharedInstance];
    self.fetchedResultsController = [manager fetchedResultsControllerWithEntityName:kClubFetchEntityName
                                                                          predicate:nil
                                                                        sortingKeys:@[kClubFetchSortingKey]
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
    if ([segue.identifier isEqualToString:kPresentSquadSegueIdentifier]) {
        SquadViewController *squadViewController = (SquadViewController *)segue.destinationViewController;
        squadViewController.presentedClub = [self.fetchedResultsController objectAtIndexPath:self.tableView.indexPathForSelectedRow];
    }
}


@end
