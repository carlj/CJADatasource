//
//  CJAMutableArrayTableViewController.m
//  CJADataSource
//
//  Created by Bogdan Iusco on 7/1/14.
//  Copyright (c) 2014 Carl Jahn. All rights reserved.
//

#import "CJAMutableArrayTableViewController.h"
#import "CJADataSource.h"
#import "CJAMutableArrayDatasource.h"
#import "CJAMutableArraySectionHeaderTableView.h"

@interface CJAMutableArrayTableViewController ()

@property (nonatomic, strong) CJAMutableArrayDatasource *tableDatasource;

@end

@implementation CJAMutableArrayTableViewController

#pragma mark - UIViewController methods

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Mutable array", nil);
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

- (CJAMutableArrayDatasource *)tableDatasource {
    if (!_tableDatasource) {
        NSDictionary *identifiers = @{ @"UITableViewCell" : [UITableViewCell class] };
        NSArray *items = [[self class] tableViewItems];
        _tableDatasource = [[CJAMutableArrayDatasource alloc] initWithItems:items
                                         tableViewIdentifiersAndCellClasses:identifiers];

        _tableDatasource.configureCellBlock = ^(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell, NSString *text){
            cell.textLabel.text = text;
        };

        _tableDatasource.cellClickedBlock = ^(UITableView *tableView, NSIndexPath *indexPath, NSString *text){
            NSLog(@"%@", text);
        };

        Class headerFooterClass = [CJAMutableArraySectionHeaderTableView class];
        NSString *sectionHeaderFooterID = NSStringFromClass(headerFooterClass);
        _tableDatasource.headerFooterIdentifiersAndClasses = @{sectionHeaderFooterID : headerFooterClass};
        _tableDatasource.sectionHeaderHeightBlock = ^(UITableView *tableView, NSUInteger section) {
            return 30.0f;
        };
        __weak  typeof (self) weakself = self;
        _tableDatasource.configureSectionHeaderViewBlock = ^(UITableView *tableView, NSUInteger section, CJAMutableArraySectionHeaderTableView *headerView) {
            headerView.sectionIndex = section;
            [headerView.addCellButton addTarget:weakself action:@selector(addNewCellButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            [headerView.deleteCellButton addTarget:weakself action:@selector(deleteCellButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        };
    }
    return _tableDatasource;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.tableDatasource.tableView = _tableView;
    }
    return _tableView;
}

#pragma mark - Helper methods

- (void)addNewCellButtonTapped:(UIButton *)sender {
    UIView *senderSuperview = sender.superview.superview;
    NSAssert([[senderSuperview class] isSubclassOfClass:[CJAMutableArraySectionHeaderTableView class]], @"Parent is not CJAMutableArraySectionHeaderTableView");
    CJAMutableArraySectionHeaderTableView *headerView = (CJAMutableArraySectionHeaderTableView *)senderSuperview;
    NSUInteger sectionIndex = headerView.sectionIndex;
    NSUInteger countItemsInSection = [self.tableView numberOfRowsInSection:sectionIndex];
    NSString *text = [NSString stringWithFormat:@"New item row %d", countItemsInSection];
    
    [self.tableView beginUpdates];
    [self.tableDatasource addObject:text inSection:sectionIndex];
    [self.tableView endUpdates];
}

- (void)deleteCellButtonTapped:(UIButton *)sender {
    UIView *senderSuperview = sender.superview.superview;
    NSAssert([[senderSuperview class] isSubclassOfClass:[CJAMutableArraySectionHeaderTableView class]], @"Parent is not CJAMutableArraySectionHeaderTableView");
    CJAMutableArraySectionHeaderTableView *headerView = (CJAMutableArraySectionHeaderTableView *)senderSuperview;
    NSUInteger sectionIndex = headerView.sectionIndex;
    NSUInteger countItemsInSection = [self.tableView numberOfRowsInSection:sectionIndex];
    if (!countItemsInSection) {
        return;
    }

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:sectionIndex];
    [self.tableView beginUpdates];
    [self.tableDatasource removeObjectAtIndexPath:indexPath];
    [self.tableView endUpdates];
}


+ (NSArray *)tableViewItems {
    const NSUInteger countSections = 2;
    const NSUInteger countItemsInSection = 3;
    NSMutableArray *allSections = [NSMutableArray arrayWithCapacity:countSections];
    for (NSUInteger sectionIndex = 0; sectionIndex < countSections; sectionIndex++) {
        NSMutableArray *sectionItems = [NSMutableArray arrayWithCapacity:countItemsInSection];
        [allSections addObject:sectionItems];
        for (NSUInteger itemIndex = 0; itemIndex < countItemsInSection; itemIndex++) {
            NSString *text = [NSString stringWithFormat:@"Default item row %d", itemIndex];
            [sectionItems addObject:text];
        }
    }
    return allSections;
}

@end
