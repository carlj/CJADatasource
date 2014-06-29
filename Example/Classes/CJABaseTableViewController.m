//
//  CJAViewController.m
//  CJADataSource
//
//  Created by Carl Jahn on 29.06.14.
//  Copyright (c) 2014 Carl Jahn. All rights reserved.
//

#import "CJABaseTableViewController.h"
#import "CJADataSource.h"

@interface CJABaseTableViewController ()

@property (nonatomic, strong) id test;

@end

@implementation CJABaseTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView = [[UITableView alloc] initWithFrame: CGRectMake(0, 0, 1, 1)];
    
    [self.view addSubview: self.tableView];
    
    NSDictionary *identifiers = @{ @"UITableViewCell" : [UITableViewCell class] };
    
    NSArray *items = @[@"Item 1", @"Item 2", @"Item 3", @"Item 4"];
    CJAArrayDatasource *datasource = [[CJAArrayDatasource alloc] initWithItems:items
                                            tableViewIdentifiersAndCellClasses:identifiers];
    
    
    datasource.configureCellBlock = ^(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell, NSString *text){
        cell.textLabel.text = text;
    };
    
    datasource.cellClickedBlock = ^(UITableView *tableView, NSIndexPath *indexPath, NSString *text){
        NSLog(@"%@", text);
    };
    
    datasource.tableView = self.tableView;
    
    self.test = datasource;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
}

@end
