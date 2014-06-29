//
//  CJADatasource.m
//  CJADataSource
//
//  Created by Carl Jahn on 26.06.14.
//  Copyright (c) 2014 Carl Jahn. All rights reserved.
//

#import "CJADatasource.h"

@interface CJADatasource ()

@property (nonatomic, strong) NSDictionary *cellIdentifiersAndClassesDictionary;

@end

@implementation CJADatasource

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
    [self.class registerAllClassesForDictionary:self.cellIdentifiersAndClassesDictionary inTableView:self.tableView];
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
    
    NSAssert(self.configureCellBlock, @"cell block isnt configured");
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    id object = [self objectForTableView:tableView indexPath:indexPath];
    
    NSAssert(self.cellClickedBlock, @"cellClicked block isnt configured");
    self.cellClickedBlock(tableView, indexPath, object);
}


#pragma mark - Helper Methods
- (id)objectForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {

    NSAssert(self.objectBlock, @"object block isnt configured");
    id object = self.objectBlock(tableView, indexPath);

    return object;
}

+ (void)registerAllClassesForDictionary:(NSDictionary *)dictionary inTableView:(UITableView *)tableView {
    NSParameterAssert(tableView);
    NSParameterAssert(dictionary.allKeys.count);

    for (NSString *identifier in dictionary.allKeys) {
        
        Class class = dictionary[identifier];
        if (![class isSubclassOfClass: [UITableViewCell class]]) {
            continue;
        }
        
        [tableView registerClass:class forCellReuseIdentifier:identifier];
    }
    
}

@end
