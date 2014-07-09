//
//  CJATestCaseThatNeedsATableView.m
//  CJADataSource
//
//  Created by Carl Jahn on 03.07.14.
//  Copyright (c) 2014 Carl Jahn. All rights reserved.
//

#import "CJATestCaseThatNeedsATableView.h"

@interface CJATestCaseThatNeedsATableView ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CJATestCaseThatNeedsATableView

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
    
    self.tableView = [[UITableView alloc] initWithFrame: mainWindow.bounds];
    self.tableView.backgroundColor = [UIColor greenColor];
    [mainWindow addSubview: self.tableView];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    
    self.tableView.dataSource = nil;
    self.tableView.delegate = nil;
    [self.tableView removeFromSuperview];
    self.tableView = nil;
    
    [super tearDown];
}

@end
