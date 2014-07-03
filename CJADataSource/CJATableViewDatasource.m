//
//  CJADatasource.m
//  CJADataSource
//
//  Created by Carl Jahn on 26.06.14.
//  Copyright (c) 2014 Carl Jahn. All rights reserved.
//

#import "CJATableViewDatasource.h"

@interface CJATableViewDatasource ()


@end

@implementation CJATableViewDatasource

- (instancetype)initWithTableView:(UITableView *)tableView
{
    NSParameterAssert(tableView);

    self = [super init];
    if (self) {
        
        self.tableView = tableView;
        self.cellIdentifiersAndClassesDictionary =  @{ @"UITableViewCell" : [UITableViewCell class] };
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
    [self.class registerHeaderFooterClasses:self.headerFooterIdentifiersAndClassesDictionary inTableView:self.tableView];
}

- (void)setCellIdentifiersAndClassesDictionary:(NSDictionary *)cellIdentifiersAndClassesDictionary {
    NSParameterAssert(cellIdentifiersAndClassesDictionary);
    NSParameterAssert([cellIdentifiersAndClassesDictionary.allKeys count]);
    
    if ([_cellIdentifiersAndClassesDictionary isEqualToDictionary:cellIdentifiersAndClassesDictionary]) {
        return;
    }
    
    _cellIdentifiersAndClassesDictionary = cellIdentifiersAndClassesDictionary;
    if (!self.tableView) {
        return;
    }
    [self.class registerCellClasses:self.cellIdentifiersAndClassesDictionary inTableView:self.tableView];
}

- (void)setHeaderFooterIdentifiersAndClassesDictionary:(NSDictionary *)headerFooterIdentifiersAndClasses {
    NSParameterAssert(headerFooterIdentifiersAndClasses);
    NSParameterAssert([headerFooterIdentifiersAndClasses.allKeys count]);

    if ([_headerFooterIdentifiersAndClassesDictionary isEqualToDictionary:headerFooterIdentifiersAndClasses]) {
        return;
    }

    _headerFooterIdentifiersAndClassesDictionary = headerFooterIdentifiersAndClasses;
    if (!self.tableView) {
        return;
    }
    [self.class registerHeaderFooterClasses:self.headerFooterIdentifiersAndClassesDictionary inTableView:self.tableView];
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
    if (![self.headerFooterIdentifiersAndClassesDictionary.allKeys count] ||
        !self.sectionHeaderHeightBlock) {
        return 0.0f;
    }
    return self.sectionHeaderHeightBlock(tableView, section);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (![self.headerFooterIdentifiersAndClassesDictionary.allKeys count] ||
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
    if (![self.headerFooterIdentifiersAndClassesDictionary.allKeys count]) {
        return nil;
    }
    else if (1 == [self.headerFooterIdentifiersAndClassesDictionary.allKeys count]) {
        identifier = self.headerFooterIdentifiersAndClassesDictionary.allKeys.firstObject;
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
    if (![self.headerFooterIdentifiersAndClassesDictionary.allKeys count]) {
        return nil;
    }
    else if (1 == [self.headerFooterIdentifiersAndClassesDictionary.allKeys count]) {
        identifier = self.headerFooterIdentifiersAndClassesDictionary.allKeys.firstObject;
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

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
+ (void)registerClasses:(NSDictionary *)dictionary
            inTableView:(UITableView *)tableView
            forSelector:(SEL)selector
         neededSubClass:(Class)neededSubClass
{
    
    for (NSString *identifier in dictionary.allKeys) {
        
        Class class = dictionary[identifier];
        if (![class isSubclassOfClass: neededSubClass]) {
            continue;
        }

        [tableView performSelector:selector withObject:class withObject:identifier];
    }
    
}
#pragma clang diagnostic pop

+ (void)registerCellClasses:(NSDictionary *)dictionary inTableView:(UITableView *)tableView {

    [self registerClasses:dictionary
              inTableView:tableView
              forSelector:@selector(registerClass:forCellReuseIdentifier:)
           neededSubClass:[UITableViewCell class]];
}

+ (void)registerHeaderFooterClasses:(NSDictionary *)dictionary inTableView:(UITableView *)tableView {
    
    [self registerClasses:dictionary
              inTableView:tableView
              forSelector:@selector(registerClass:forHeaderFooterViewReuseIdentifier:)
           neededSubClass:[UIView class]];
}

@end
