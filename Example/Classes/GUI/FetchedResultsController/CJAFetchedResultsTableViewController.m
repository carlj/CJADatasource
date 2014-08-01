//
//  CJAFetchedResultsTableViewController.m
//  CJADataSource
//
//  Created by Bogdan Iusco on 8/1/14.
//  Copyright (c) 2014 Carl Jahn. All rights reserved.
//

#import "CJAFetchedResultsTableViewController.h"
#import "CJADataSource.h"
#import "CJAFetchedResultControllerDatasource.h"
#import "CJAFetchedResultsSectionHeaderTableView.h"

#import "CJADriver.h"
#import "CJACar.h"


@interface CJAFetchedResultsTableViewController ()

@property (nonatomic, strong) CJAFetchedResultControllerDatasource *tableDatasource;

@end

@implementation CJAFetchedResultsTableViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Core Data", nil);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview: self.tableView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

#pragma mark - Property methods

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.tableDatasource.tableView = _tableView;
    }
    return _tableView;
}

- (CJAFetchedResultControllerDatasource *)tableDatasource {
    if (!_tableDatasource) {
        __block NSFetchedResultsController *fetchedResultsController = [CJACar MR_fetchAllGroupedBy:@"driver.name"
                                                                              withPredicate:nil
                                                                                   sortedBy:@"manufacturer"
                                                                                  ascending:YES];
        _tableDatasource = [[CJAFetchedResultControllerDatasource alloc] initWithTableView:self.tableView
                                                                   fetchedResultController:fetchedResultsController];
        
        _tableDatasource.configureCellBlock = ^(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell, CJACar *car){
            cell.textLabel.text = car.manufacturer;
        };

        _tableDatasource.cellClickedBlock = ^(UITableView *tableView, NSIndexPath *indexPath, CJACar *car){
            CJALogInfo(@"%@", car.manufacturer);
        };

        Class headerFooterClass = [CJAFetchedResultsSectionHeaderTableView class];
        NSString *sectionHeaderFooterID = NSStringFromClass(headerFooterClass);
        _tableDatasource.headerFooterIdentifiersAndClassesDictionary = @{sectionHeaderFooterID : headerFooterClass};
        _tableDatasource.sectionHeaderHeightBlock = ^(UITableView *tableView, NSUInteger section) {
            
            return 30.0f;
        };

        CJAWeakSelf;
        _tableDatasource.configureSectionHeaderViewBlock = ^(UITableView *tableView, NSUInteger section, CJAFetchedResultsSectionHeaderTableView *headerView) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
            CJACar *car = [fetchedResultsController objectAtIndexPath:indexPath];
            headerView.driver = car.driver;
            headerView.sectionIndex = section;
            [headerView.addCellButton addTarget:weakself action:@selector(addNewCellButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            [headerView.deleteCellButton addTarget:weakself action:@selector(deleteCellButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        };
    }
    return _tableDatasource;
}

#pragma mark - Helper methods

- (void)addNewCellButtonTapped:(UIButton *)sender {
    UIView *senderSuperview = sender.superview.superview;
    NSAssert([[senderSuperview class] isSubclassOfClass:[CJAFetchedResultsSectionHeaderTableView class]], @"Parent is not CJAFetchedResultsSectionHeaderTableView");
    CJAFetchedResultsSectionHeaderTableView *headerView = (CJAFetchedResultsSectionHeaderTableView *)senderSuperview;
    CJADriver *driver = headerView.driver;
    NSUInteger sectionIndex = headerView.sectionIndex;
    NSUInteger countItemsInSection = [self.tableView numberOfRowsInSection:sectionIndex];
    NSString *manufacturer = [NSString stringWithFormat:@"New car %lu", countItemsInSection];
    
    NSManagedObjectContext *defaultContext = [NSManagedObjectContext MR_defaultContext];
    [driver newCarWithManufacturerName:manufacturer];
    [defaultContext MR_saveToPersistentStoreAndWait];
}

- (void)deleteCellButtonTapped:(UIButton *)sender {
    UIView *senderSuperview = sender.superview.superview;
    NSAssert([[senderSuperview class] isSubclassOfClass:[CJAFetchedResultsSectionHeaderTableView class]], @"Parent is not CJAFetchedResultsSectionHeaderTableView");
    CJAFetchedResultsSectionHeaderTableView *headerView = (CJAFetchedResultsSectionHeaderTableView *)senderSuperview;
    CJADriver *driver = headerView.driver;
    NSUInteger sectionIndex = headerView.sectionIndex;
    NSUInteger countItemsInSection = [self.tableView numberOfRowsInSection:sectionIndex];
    if (!countItemsInSection) {
        return;
    }

    CJACar *car = driver.cars[0];
    NSManagedObjectContext *defaultContext = [NSManagedObjectContext MR_defaultContext];
    [defaultContext deleteObject:car];
    [defaultContext MR_saveToPersistentStoreAndWait];
}

@end
