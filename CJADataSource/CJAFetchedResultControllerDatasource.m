//
//  CJAFetchedResultControllerDatasource.m
//  CJADataSource
//
//  Created by Carl Jahn on 26.06.14.
//  Copyright (c) 2014 Carl Jahn. All rights reserved.
//

#import "CJAFetchedResultControllerDatasource.h"

@interface CJAFetchedResultControllerDatasource () <NSFetchedResultsControllerDelegate>

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
        self.tableView = tableView;
        self.fetchedResultController = controller;
        self.fetchedResultController.delegate = self;
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

#pragma mark - NSFetchedResultsControllerDelegate methods

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    
    [self.tableView beginUpdates];
}
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    
    [self.tableView endUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex
     forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeMove:
        case NSFetchedResultsChangeUpdate:
        default:
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    switch(type) {
            // Data was inserted -- insert the data into the table view
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            // Data was deleted -- delete the data from the table view
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            // Data was updated (changed) -- reconfigure the cell for the data
        case NSFetchedResultsChangeUpdate:
            [self.tableView cellForRowAtIndexPath:indexPath];
            break;
            // Data was moved -- delete the data from the old location and insert the data into the new location
        case NSFetchedResultsChangeMove:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                                  withRowAnimation:UITableViewRowAnimationFade];
            
            NSArray *insertPaths = [NSArray arrayWithObject: newIndexPath];
            
            [self.tableView insertRowsAtIndexPaths: insertPaths withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

@end
