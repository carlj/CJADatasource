//
//  CJAFetchedResultControllerDatasource.m
//  CJADataSource
//
//  Created by Carl Jahn on 26.06.14.
//  Copyright (c) 2014 Carl Jahn. All rights reserved.
//

#import "CJAFetchedResultControllerDatasource.h"

@interface CJAFetchedResultControllerDatasource ()

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultController;

@end

@implementation CJAFetchedResultControllerDatasource

- (instancetype)initWithTableView:(UITableView *)tableView
          fetchedResultController:(NSFetchedResultsController *)controller;
{
    NSParameterAssert(tableView);
    NSParameterAssert(controller);
    
    self = [super initWithTableView:tableView];
    if (self) {
        
        self.fetchedResultController = controller;
        
        __weak typeof(self) weakSelf = self;
        self.objectBlock = ^id(UITableView *tableView, NSIndexPath *indexPath){
            
            return [weakSelf.fetchedResultController objectAtIndexPath:indexPath];
        };
    }
    
    return self;
}

#pragma mark - UITableViewDataSource Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    NSArray *sections = [self.fetchedResultController sections];

    return [sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    id<NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultController sections] objectAtIndex: section];
    
    return [sectionInfo numberOfObjects];
}


@end
