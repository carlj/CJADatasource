//
//  CJAArrayDataSourceTestCase.m
//  CJADataSource
//
//  Created by Carl Jahn on 09.07.14.
//  Copyright (c) 2014 Carl Jahn. All rights reserved.
//
#import "CJATestCaseThatNeedsATableView.h"


@interface CJAArrayDataSourceTestCase : CJATestCaseThatNeedsATableView

@end

@implementation CJAArrayDataSourceTestCase

- (void)testSimpleArrayDataSource
{
    NSArray *items = @[@"1", @"2", @"3", @"3"];
    CJAArrayDatasource *datasource = [[CJAArrayDatasource alloc] initWithTableView: self.tableView
                                                                             items: items];
    
    XCTAssertEqualObjects(self.tableView.dataSource, datasource, @"datasource wasnt setted");
    XCTAssertEqualObjects(self.tableView.delegate, datasource, @"delegate wasnt setted");
    
    datasource.configureCellBlock = ^(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell, NSString *text){
        XCTAssertNotNil(tableView, @"tableView is nil");
        XCTAssertNotNil(indexPath, @"indexPath is nil");
        XCTAssertNotNil(cell, @"tableView is nil");
        XCTAssertNotNil(text, @"text is nil");
        
        XCTAssertTrue([text isKindOfClass:[NSString class]], @"we need the correct object");
        
        XCTAssertEqualObjects(items[indexPath.row], text, @"items arent the same");
        
        cell.textLabel.text = text;
    };
    
    [self.tableView reloadData];
    XCTAssertEqual(items.count, self.tableView.visibleCells.count, @"there arent the same items");
    
    NSArray *cells = self.tableView.visibleCells;
    NSMutableArray *textFromCells = [NSMutableArray array];
    for (UITableViewCell *cell in cells) {
        
        [textFromCells addObject: cell.textLabel.text];
    }
    
    XCTAssertEqualObjects(textFromCells, items, @"no the same items");
}

@end
