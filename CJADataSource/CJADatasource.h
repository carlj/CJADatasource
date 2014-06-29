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

@interface CJADatasource : NSObject<UITableViewDataSource, UITableViewDelegate>

- (instancetype)initWithTableView:(UITableView *)tableView
        tableViewIdentifiersAndCellClasses:(NSDictionary *)dictionary;

- (instancetype)initWithTableViewIdentifiersAndCellClasses:(NSDictionary *)dictionary;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) CJADataSourceConfigureCellBlock configureCellBlock;
@property (nonatomic, copy) CJADataSourceCellIdentifierBlock cellIdentifierBlock;
@property (nonatomic, copy) CJADataSourceObjectBlock objectBlock;

@property (nonatomic, copy) CJADataCellHightBlock cellHightBlock;
@property (nonatomic, copy) CJADataObjectClickedBlock cellClickedBlock;


@end
