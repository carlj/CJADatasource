//
//  CJAArrayDatasource.m
//  CJADataSource
//
//  Created by Carl Jahn on 27.06.14.
//  Copyright (c) 2014 Carl Jahn. All rights reserved.
//

#import "CJAArrayDatasource.h"

@interface CJAArrayDatasource ()



@end

@implementation CJAArrayDatasource

- (instancetype)initWithTableView:(UITableView *)tableView
                            items:(NSArray *)items
{

    NSParameterAssert(tableView);
    NSParameterAssert(items);

    self = [super initWithTableView:tableView];
    if (self) {
        self.items = items;
        
        __weak typeof(self) weakSelf = self;
        self.objectBlock = ^id(UITableView *tableView, NSIndexPath *indexPath){
            
            if (weakSelf.items.count >= indexPath.section ) {
                
                id item = weakSelf.items[indexPath.section];
                if ([item isKindOfClass: [NSArray class]]) {
                    
                    NSArray *subItem = (NSArray *)item;
                    if (subItem.count >= indexPath.row ) {
                        return subItem[indexPath.row];
                    }
                }
                
            }
            
            
            return weakSelf.items[indexPath.row];
        };
        
    }
    
    return self;
}

#pragma mark - UITableViewDataSource Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (!self.items.count) {
        return 0;
    }
    
    if ([[self.items.firstObject class] isSubclassOfClass:[NSArray class]]) {
        return self.items.count;
    }
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if ([self.items[section] isKindOfClass: [NSArray class]]) {
    
        NSArray *item = self.items[section];
        return item.count;
    }
    
    return self.items.count;
    
}

@end
