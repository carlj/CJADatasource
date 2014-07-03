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

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Simple array", nil);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];


    self.tableView = [[UITableView alloc] initWithFrame: CGRectMake(0, 0, 1, 1)];
    
    [self.view addSubview: self.tableView];
        
    NSArray *items = @[@"Item 1", @"Item 2", @"Item 3", @"Item 4"];
    CJAArrayDatasource *datasource = [[CJAArrayDatasource alloc] initWithTableView:self.tableView
                                                                             items:items];
    
    
    datasource.configureCellBlock = ^(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell, NSString *text){
        cell.textLabel.text = text;
    };
    
    datasource.cellClickedBlock = ^(UITableView *tableView, NSIndexPath *indexPath, NSString *text){
        NSLog(@"%@", text);
    };

    
    self.test = datasource;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
}

@end
