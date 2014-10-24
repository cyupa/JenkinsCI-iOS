//
//  FetchedResultsTableViewController.h
//  JenkinsCI
//
//  Created by Ciprian Redinciuc on 24/10/14.
//  Copyright (c) 2014 Ciprian Redinciuc. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreData;

@protocol UITableViewCellConfigurer <NSObject>

- (void)configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface FetchedResultsTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

/**
 *  Cell configurerDelegate object.
 */
@property (nonatomic, assign) id<UITableViewCellConfigurer> cellConfigurer;

@end
