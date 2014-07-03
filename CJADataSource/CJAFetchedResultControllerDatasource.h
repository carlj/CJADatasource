//
//  CJAFetchedResultControllerDatasource.h
//  CJADataSource
//
//  Created by Carl Jahn on 26.06.14.
//  Copyright (c) 2014 Carl Jahn. All rights reserved.
//

#import "CJATableViewDatasource.h"
#import <CoreData/CoreData.h>

@interface CJAFetchedResultControllerDatasource : CJATableViewDatasource

- (instancetype)initWithTableView:(UITableView *)tableView
          fetchedResultController:(NSFetchedResultsController *)controller;


@end
