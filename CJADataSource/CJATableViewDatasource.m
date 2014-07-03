//
//  CJADatasource.m
//  CJADataSource
//
//  Created by Carl Jahn on 26.06.14.
//  Copyright (c) 2014 Carl Jahn. All rights reserved.
//

#import "CJATableViewDatasource.h"

@interface CJATableViewDatasource ()

@property (nonatomic, strong) NSDictionary *cellIdentifiersAndClassesDictionary;

@end

@implementation CJATableViewDatasource

- (instancetype)initWithTableViewIdentifiersAndCellClasses:(NSDictionary *)dictionary {
    NSParameterAssert(dictionary.allKeys.count);
    
    self = [super init];
    if (self) {
        self.cellIdentifiersAndClassesDictionary = dictionary;
    }
    
    return self;
}

- (instancetype)initWithTableView:(UITableView *)tableView
tableViewIdentifiersAndCellClasses:(NSDictionary *)dictionary {
    NSParameterAssert(tableView);
    NSParameterAssert(dictionary.allKeys.count);
    
    self = [self initWithTableViewIdentifiersAndCellClasses: dictionary];
    if (self) {

        self.tableView = tableView;
    }
    
    return self;
}

- (void)setTableView:(UITableView *)tableView {
    if (tableView == _tableView) {
        return;
    }
    
    _tableView = tableView;
    
    if (!tableView) {
        return;
    }

    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.class registerCellClasses:self.cellIdentifiersAndClassesDictionary inTableView:self.tableView];
    [self.class registerHeaderFooterClasses:self.headerFooterIdentifiersAndClasses inTableView:self.tableView];
}

- (void)setHeaderFooterIdentifiersAndClasses:(NSDictionary *)headerFooterIdentifiersAndClasses {
    NSParameterAssert(headerFooterIdentifiersAndClasses);
    NSParameterAssert([headerFooterIdentifiersAndClasses.allKeys count]);

    if ([_headerFooterIdentifiersAndClasses isEqualToDictionary:headerFooterIdentifiersAndClasses]) {
        return;
    }

    _headerFooterIdentifiersAndClasses = headerFooterIdentifiersAndClasses;
    if (!self.tableView) {
        return;
    }
    [self.class registerHeaderFooterClasses:self.headerFooterIdentifiersAndClasses inTableView:self.tableView];
}

#pragma mark - UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = nil;
    if (1 == self.cellIdentifiersAndClassesDictionary.allKeys.count) {
        cellIdentifier = self.cellIdentifiersAndClassesDictionary.allKeys.firstObject;
        
    } else {
        
        NSAssert(self.cellIdentifierBlock, @"cell identifier block isnt defined");
        cellIdentifier = self.cellIdentifierBlock(tableView, indexPath);
    }
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier ];

    id object = [self objectForTableView:tableView indexPath:indexPath];
    
    NSAssert(self.configureCellBlock, @"configure block isnt configured");
    self.configureCellBlock(tableView, indexPath, cell, object);
    
    return cell;
}

#pragma mark - UITableViewDelegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    id object = [self objectForTableView:tableView indexPath:indexPath];

    if (!self.cellHightBlock) {
        return 44.0f;
    }
    
    return self.cellHightBlock(tableView, object);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (0 == [self.headerFooterIdentifiersAndClasses.allKeys count] ||
        !self.sectionHeaderHeightBlock) {
        return 0.0f;
    }
    return self.sectionHeaderHeightBlock(tableView, section);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (0 == [self.headerFooterIdentifiersAndClasses.allKeys count] ||
        !self.sectionFooterHeightBlock) {
        return 0.0f;
    }
    return self.sectionFooterHeightBlock(tableView, section);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (!self.cellClickedBlock) {
        return;
    }
    
    id object = [self objectForTableView:tableView indexPath:indexPath];
    self.cellClickedBlock(tableView, indexPath, object);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString *identifier = nil;
    if (0 == [self.headerFooterIdentifiersAndClasses.allKeys count]) {
        return nil;
    }
    else if (1 == [self.headerFooterIdentifiersAndClasses.allKeys count]) {
        identifier = self.headerFooterIdentifiersAndClasses.allKeys.firstObject;
    }
    else {
        NSAssert(self.headerFooterIdentifierBlock, @"header footer identifier block isn't defined");
        identifier = self.headerFooterIdentifierBlock(tableView, section);
    }

    UIView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if (self.configureSectionHeaderViewBlock) {
        self.configureSectionHeaderViewBlock(self.tableView, section, header);
    }
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    NSString *identifier = nil;
    if (0 == [self.headerFooterIdentifiersAndClasses.allKeys count]) {
        return nil;
    }
    else if (1 == [self.headerFooterIdentifiersAndClasses.allKeys count]) {
        identifier = self.headerFooterIdentifiersAndClasses.allKeys.firstObject;
    }
    else {
        NSAssert(self.headerFooterIdentifierBlock, @"header footer identifier block isn't defined");
        identifier = self.headerFooterIdentifierBlock(tableView, section);
    }
    
    UIView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if (self.configureSectionFooterViewBlock) {
        self.configureSectionFooterViewBlock(self.tableView, section, footer);
    }
    return footer;
}

#pragma mark - Helper Methods
- (id)objectForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {

    NSAssert(self.objectBlock, @"object block isnt configured");
    id object = self.objectBlock(tableView, indexPath);

    return object;
}

+ (void)registerCellClasses:(NSDictionary *)dictionary inTableView:(UITableView *)tableView {
    NSParameterAssert(tableView);
    NSParameterAssert([dictionary.allKeys count]);

    for (NSString *identifier in dictionary.allKeys) {

        Class class = dictionary[identifier];
        if (![class isSubclassOfClass: [UITableViewCell class]]) {
            continue;
        }
        
        [tableView registerClass:class forCellReuseIdentifier:identifier];
    }
    
}

+ (void)registerHeaderFooterClasses:(NSDictionary *)dictionary inTableView:(UITableView *)tableView {

    for (NSString *identifier in dictionary.allKeys) {
        
        Class class = dictionary[identifier];
        if (![class isSubclassOfClass: [UIView class]]) {
            continue;
        }

        [tableView registerClass:class forHeaderFooterViewReuseIdentifier:identifier];
    }
}

@end
