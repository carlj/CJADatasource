//
//  CJADataSource.h
//  CJADataSource
//
//  Created by Carl Jahn on 26.06.14.
//  Copyright (c) 2014 Carl Jahn. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CJADataSourceConfigureCellBlock)(UITableView *tableView, NSIndexPath *indexPath, id cell, id object);
typedef NSString *(^CJADataSourceCellIdentifierBlock)(UITableView *tableView, NSIndexPath *indexPath);
typedef id(^CJADataSourceObjectBlock)(UITableView *tableView, NSIndexPath *indexPath);

typedef CGFloat(^CJADataCellHightBlock)(UITableView *tableView, id object);
typedef void(^CJADataObjectClickedBlock)(UITableView *tableView, NSIndexPath *indexPath, id object);

// Header footer blocks
typedef void(^CJADataSourceConfigureSectionHeaderFooterBlock)(UITableView *tableView, NSUInteger section, id view);
typedef NSString *(^CJADataSourceHeaderFooterIdentifierBlock)(UITableView *tableView, NSUInteger section);
typedef CGFloat(^CJADataSourceHeaderFooterHeight)(UITableView *tableView, NSUInteger section);

@interface CJATableViewDatasource : NSObject<UITableViewDataSource, UITableViewDelegate>

- (instancetype)initWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSDictionary *headerFooterIdentifiersAndClassesDictionary;
@property (nonatomic, strong) NSDictionary *cellIdentifiersAndClassesDictionary;


@property (nonatomic, copy) CJADataSourceConfigureCellBlock configureCellBlock;
@property (nonatomic, copy) CJADataSourceCellIdentifierBlock cellIdentifierBlock;
@property (nonatomic, copy) CJADataSourceObjectBlock objectBlock;

@property (nonatomic, copy) CJADataCellHightBlock cellHightBlock;
@property (nonatomic, copy) CJADataObjectClickedBlock cellClickedBlock;

// Header footer blocks
@property (nonatomic, copy) CJADataSourceConfigureSectionHeaderFooterBlock configureSectionHeaderViewBlock;
@property (nonatomic, copy) CJADataSourceConfigureSectionHeaderFooterBlock configureSectionFooterViewBlock;
@property (nonatomic, copy) CJADataSourceHeaderFooterIdentifierBlock headerFooterIdentifierBlock;
@property (nonatomic, copy) CJADataSourceHeaderFooterHeight sectionHeaderHeightBlock;
@property (nonatomic, copy) CJADataSourceHeaderFooterHeight sectionFooterHeightBlock;

@end
