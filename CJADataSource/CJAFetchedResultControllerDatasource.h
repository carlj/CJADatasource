//
//  CJAFetchedResultControllerDatasource.h
//  CJADataSource
//
//  Created by Carl Jahn on 26.06.14.
//  Copyright (c) 2014 Carl Jahn. All rights reserved.
//

#import "CJADatasource.h"
#import <CoreData/CoreData.h>

@interface CJAFetchedResultControllerDatasource : CJADatasource

- (instancetype)initWithFetchedResultController:(NSFetchedResultsController *)controller
             tableViewIdentifiersAndCellClasses:(NSDictionary *)dictionary;

@end
