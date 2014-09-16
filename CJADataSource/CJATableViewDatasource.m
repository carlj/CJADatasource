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
    NSParameterAssert([tableView isKindOfClass:[UITableView class]]);

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

+ (void)registerClasses:(NSDictionary *)dictionary
            inTableView:(UITableView *)tableView
         isHeaderFooter:(BOOL)isHeaderFooter
         neededSubClass:(Class)neededSubClass
{
    
    for (NSString *identifier in dictionary.allKeys) {
        
        Class class = dictionary[identifier];
        NSAssert([class isSubclassOfClass: neededSubClass], @"class '%@' isnt kind of subclass '%@'", class, neededSubClass);
        NSString* classNameAsString = NSStringFromClass(class);
        UINib* tableCellAsNib;
        
        NSString* cellNameWithXibExtension = [NSString stringWithFormat:@"%@.xib",classNameAsString];
        BOOL xibExistsForCell = [[NSFileManager defaultManager] fileExistsAtPath:cellNameWithXibExtension];
        if (xibExistsForCell) {
            //unfortunately, I have to do this hack, because it seems, that nibWithNibName return a nib that isn't null
            //for UITableViewCell & UITableViewHeaderFooterView
            tableCellAsNib = [UINib nibWithNibName:classNameAsString bundle:nil];
        }
        
        if (tableCellAsNib != nil) {
            if (isHeaderFooter) {
                [tableView registerNib:tableCellAsNib forHeaderFooterViewReuseIdentifier:identifier];
            } else {
                [tableView registerNib:tableCellAsNib forCellReuseIdentifier:identifier];
            }
            
        } else {
            if (isHeaderFooter) {
                [tableView registerClass:class forHeaderFooterViewReuseIdentifier:identifier];
            } else {
                [tableView registerClass:class forCellReuseIdentifier:identifier];
            }
        }
        
    }
    
}

+ (void)registerCellClasses:(NSDictionary *)dictionary inTableView:(UITableView *)tableView {
    
    [self registerClasses:dictionary
              inTableView:tableView
           isHeaderFooter:NO
           neededSubClass:[UITableViewCell class]];
}

+ (void)registerHeaderFooterClasses:(NSDictionary *)dictionary inTableView:(UITableView *)tableView {
    
    [self registerClasses:dictionary
              inTableView:tableView
           isHeaderFooter:YES
           neededSubClass:[UIView class]];
}

@end
