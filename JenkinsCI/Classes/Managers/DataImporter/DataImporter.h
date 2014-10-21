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

- (void)importDataFromDictionary:(NSDictionary *)dictionary;

@end
