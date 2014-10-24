//
//  DataImporter.h
//  JenkinsCI
//
//  Created by Ciprian Redinciuc on 20/10/14.
//  Copyright (c) 2014 Ciprian Redinciuc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataImporter : NSObject
/**
 *  Method to check if the import was already done or not.
 *
 *  @return <#return value description#>
 */
- (BOOL)didImportData;

/**
 *  Method that will import the players and club infos from an NSDictionary.
 *
 *  @param dictionary NSDictionary containing players and clubs keys.
 */
- (void)importDataFromDictionary:(NSDictionary *)dictionary;

@end
