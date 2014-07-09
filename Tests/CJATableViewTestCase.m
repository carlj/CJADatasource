//
//  CJATableViewTestCase.m
//  CJADataSource
//
//  Created by Carl Jahn on 04.07.14.
//  Copyright (c) 2014 Carl Jahn. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CJATestCaseThatNeedsATableView.h"

@interface CJATableViewTestCase : CJATestCaseThatNeedsATableView

@end

@implementation CJATableViewTestCase


- (void)testInitialization
{
    CJATableViewDatasource *dataSource;
    XCTAssertNoThrow(dataSource = [[CJATableViewDatasource alloc] initWithTableView: self.tableView], @"init method shouldnt throw a exception");
}

- (void)testInitializationWithWrongParameters
{
    CJATableViewDatasource *dataSource;
    XCTAssertThrows(dataSource = [[CJATableViewDatasource alloc] initWithTableView: nil], @"init method without a tableview should throw an exception");

    UITableView *t = (UITableView *)[NSObject new];
    XCTAssertThrows(dataSource = [[CJATableViewDatasource alloc] initWithTableView: t], @"init method without a UITableView instance should throw an exception");
}

- (void)testPropertiesAfterInitialization
{
    CJATableViewDatasource *dataSource;
    XCTAssertNoThrow(dataSource = [[CJATableViewDatasource alloc] initWithTableView: self.tableView], @"init method shouldnt throw a exception");
    
    XCTAssertNotNil(dataSource, @"data source is nil");
    XCTAssertEqualObjects(self.tableView, dataSource.tableView, @"tableView isnt the same");
    XCTAssertNil(dataSource.headerFooterIdentifiersAndClassesDictionary, @"header footer block wasnt setted");
    
    XCTAssertNotNil(dataSource.cellIdentifiersAndClassesDictionary, @"cell identifiers wasnt setted");
    XCTAssertEqual(dataSource.cellIdentifiersAndClassesDictionary.allKeys.count, 1, @"ther isnt a default object in the cellIdentifiers Dictionary");
    XCTAssertEqualObjects(dataSource.cellIdentifiersAndClassesDictionary[@"UITableViewCell"], [UITableViewCell class], @"ther isnt the UITableViewCell object in the cellIdentifiers Dictionary");
    
    
    XCTAssertNil(dataSource.configureCellBlock, @"configureCellBlock isnt nil");
    XCTAssertNil(dataSource.cellIdentifierBlock, @"cellIdentifierBlock isnt nil");
    XCTAssertNil(dataSource.objectBlock, @"objectBlock isnt nil");
    XCTAssertNil(dataSource.cellHightBlock, @"cellHightBlock isnt nil");
    XCTAssertNil(dataSource.cellClickedBlock, @"cellClickedBlock isnt nil");
    XCTAssertNil(dataSource.configureSectionHeaderViewBlock, @"configureSectionHeaderViewBlock isnt nil");
    XCTAssertNil(dataSource.configureSectionFooterViewBlock, @"configureSectionFooterViewBlock isnt nil");
    XCTAssertNil(dataSource.headerFooterIdentifierBlock, @"headerFooterIdentifierBlock isnt nil");
    XCTAssertNil(dataSource.sectionHeaderHeightBlock, @"sectionHeaderHeightBlock isnt nil");
    XCTAssertNil(dataSource.sectionFooterHeightBlock, @"sectionFooterHeightBlock isnt nil");
}

- (void)testSettingCellIdentifierProperties
{
    CJATableViewDatasource *dataSource;
    XCTAssertNoThrow(dataSource = [[CJATableViewDatasource alloc] initWithTableView: self.tableView], @"init method shouldnt throw a exception");

    NSDictionary *cellIdentifiers = @{
                                      @"Test" : [UITableViewCell class],
                                      @"Test2" : [UITableViewCell class]
                                      };
    
    dataSource.cellIdentifiersAndClassesDictionary = cellIdentifiers;
    
    XCTAssertEqualObjects(dataSource.cellIdentifiersAndClassesDictionary, cellIdentifiers, @"cellIdentifiers objects arent the same");
    
    for (NSString *key in cellIdentifiers.allKeys) {
        
        id cell = [self.tableView dequeueReusableCellWithIdentifier:key];
        XCTAssertNotNil(cell, @"cell for '%@' identifier is nil", key);
        XCTAssertEqualObjects([cell class], cellIdentifiers[key], @"classes are not the same for the '%@', identifier", key);
        
    }
}

- (void)testSettingWrongCellIdentifierProperties
{
    CJATableViewDatasource *dataSource;
    XCTAssertNoThrow(dataSource = [[CJATableViewDatasource alloc] initWithTableView: self.tableView], @"init method shouldnt throw a exception");
    
    NSDictionary *cellIdentifiers = @{
                                      @"Test" : [UIView class],
                                      @"Test2" : [UIView class]
                                      };
    
    XCTAssertThrows(dataSource.cellIdentifiersAndClassesDictionary = cellIdentifiers, @"setting with the wrong classes doenst throw an exception");
}

- (void)testSettingHeaderFooterIdentifierProperties
{
    CJATableViewDatasource *dataSource;
    XCTAssertNoThrow(dataSource = [[CJATableViewDatasource alloc] initWithTableView: self.tableView], @"init method shouldnt throw a exception");
    
    NSDictionary *headerFooterIdentifiers = @{
                                      @"HeaderFooterTest" : [UITableViewHeaderFooterView class],
                                      @"HeaderFooterTest2" : [UITableViewHeaderFooterView class]
                                      };
    
    dataSource.headerFooterIdentifiersAndClassesDictionary = headerFooterIdentifiers;
    
    XCTAssertEqualObjects(dataSource.headerFooterIdentifiersAndClassesDictionary, headerFooterIdentifiers, @"headerFooterIdentifiers objects arent the same");
    
    for (NSString *key in headerFooterIdentifiers.allKeys) {
        
        id view = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:key];
        XCTAssertNotNil(view, @"view for '%@' identifier is nil", key);
        XCTAssertEqualObjects([view class], headerFooterIdentifiers[key], @"classes are not the same for the '%@', identifier", key);
        
    }
}

- (void)testSettingWrongHeaderFooterIdentifierProperties
{
    CJATableViewDatasource *dataSource;
    XCTAssertNoThrow(dataSource = [[CJATableViewDatasource alloc] initWithTableView: self.tableView], @"init method shouldnt throw a exception");
    
    NSDictionary *headerFooterIdentifiers = @{
                                              @"HeaderFooterTest" : [UIView class],
                                              @"HeaderFooterTest2" : [UIView class]
                                              };
    
    XCTAssertThrows(dataSource.headerFooterIdentifiersAndClassesDictionary = headerFooterIdentifiers, @"setting with the wrong classes doenst throw an exception");
}

- (void)testSettingBlockProperties
{
    CJATableViewDatasource *dataSource;
    XCTAssertNoThrow(dataSource = [[CJATableViewDatasource alloc] initWithTableView: self.tableView], @"init method shouldnt throw a exception");
    
    CJADataSourceConfigureCellBlock configureCell = ^(UITableView *tableView, NSIndexPath *indexPath, id cell, id object){};
    dataSource.configureCellBlock = configureCell;
    XCTAssertEqualObjects(dataSource.configureCellBlock, configureCell, @"configureCell blocks arent the same");

    CJADataSourceCellIdentifierBlock cellIdentifier = ^(UITableView *tableView, NSIndexPath *indexPath){ return @""; };
    dataSource.cellIdentifierBlock = cellIdentifier;
    XCTAssertEqualObjects(dataSource.cellIdentifierBlock, cellIdentifier, @"cellIdentifier blocks arent the same");

    CJADataSourceObjectBlock objectBlock = ^(UITableView *tableView, NSIndexPath *indexPath){ return [NSObject new]; };
    dataSource.objectBlock = objectBlock;
    XCTAssertEqualObjects(dataSource.objectBlock, objectBlock, @"objectBlock blocks arent the same");
    
    
    CJADataCellHightBlock cellHightBlock = ^(UITableView *tableView, id object){ return 0.0f; };
    dataSource.cellHightBlock = cellHightBlock;
    XCTAssertEqualObjects(dataSource.cellHightBlock, cellHightBlock, @"cellHightBlock blocks arent the same");

    CJADataObjectClickedBlock cellClickedBlock = ^(UITableView *tableView, NSIndexPath *indexPath, id object){ };
    dataSource.cellClickedBlock = cellClickedBlock;
    XCTAssertEqualObjects(dataSource.cellClickedBlock, cellClickedBlock, @"cellClickedBlock blocks arent the same");

    CJADataSourceConfigureSectionHeaderFooterBlock configureSectionHeaderViewBlock = ^(UITableView *tableView, NSUInteger section, id view){ };
    dataSource.configureSectionHeaderViewBlock = configureSectionHeaderViewBlock;
    XCTAssertEqualObjects(dataSource.configureSectionHeaderViewBlock, configureSectionHeaderViewBlock, @"configureSectionHeaderViewBlock blocks arent the same");

    CJADataSourceConfigureSectionHeaderFooterBlock configureSectionFooterViewBlock = ^(UITableView *tableView, NSUInteger section, id view){ };
    dataSource.configureSectionFooterViewBlock = configureSectionFooterViewBlock;
    XCTAssertEqualObjects(dataSource.configureSectionFooterViewBlock, configureSectionFooterViewBlock, @"configureSectionFooterViewBlock blocks arent the same");

    CJADataSourceHeaderFooterIdentifierBlock headerFooterIdentifierBlock = ^(UITableView *tableView, NSUInteger section){ return @""; };
    dataSource.headerFooterIdentifierBlock = headerFooterIdentifierBlock;
    XCTAssertEqualObjects(dataSource.headerFooterIdentifierBlock, headerFooterIdentifierBlock, @"headerFooterIdentifierBlock blocks arent the same");

    CJADataSourceHeaderFooterHeight sectionHeaderHeightBlock = ^(UITableView *tableView, NSUInteger section){ return 0.0f; };
    dataSource.sectionHeaderHeightBlock = sectionHeaderHeightBlock;
    XCTAssertEqualObjects(dataSource.sectionHeaderHeightBlock, sectionHeaderHeightBlock, @"sectionHeaderHeightBlock blocks arent the same");

    CJADataSourceHeaderFooterHeight sectionFooterHeightBlock = ^(UITableView *tableView, NSUInteger section){ return 0.0f; };
    dataSource.sectionFooterHeightBlock = sectionFooterHeightBlock;
    XCTAssertEqualObjects(dataSource.sectionFooterHeightBlock, sectionFooterHeightBlock, @"sectionHeaderHeightBlock blocks arent the same");

}

@end
