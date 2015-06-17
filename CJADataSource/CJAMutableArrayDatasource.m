//
//  CJAMutableArrayDatasource.m
//  CJADataSource
//
//  Created by Bogdan Iusco on 7/1/14.
//  Copyright (c) 2014 Carl Jahn. All rights reserved.
//

#import "CJAMutableArrayDatasource.h"
#import "NSMutableArray+CJADataSource.h"

@interface CJAMutableArrayDatasource ()

@property (nonatomic, strong) NSMutableArray *mutableItems;

@end

@implementation CJAMutableArrayDatasource

- (void)addObject:(id)object {
    NSParameterAssert(object);
    
    NSUInteger countSections = [self.mutableItems count];
    [self addObject:object inSection:(countSections - 1)];
}

- (void)addObject:(id)object inSection:(NSUInteger)section {
    NSParameterAssert(object);
    

    NSAssert(section < [self.mutableItems count], @"Invalid section number");
    id sectionObj = self.mutableItems[section];
    NSAssert([[sectionObj class] isSubclassOfClass:[NSMutableArray class]], @"Should be an NSMutableArray type object");
    NSMutableArray *sectionObjects = (NSMutableArray *)sectionObj;
    NSUInteger countObjects = [sectionObjects count];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:countObjects inSection:section];
    [self insertObject:object atIndexPath:indexPath];
}

- (void)insertObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
    NSParameterAssert(object);
    NSParameterAssert(indexPath);
    
    [self.mutableItems insertObject:object atIndexPath:indexPath];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:self.rowAnimation];
    self.items = [NSArray arrayWithArray:self.mutableItems];
}

- (void)removeObjects:(id)object {
    NSParameterAssert(object);
    
    NSArray *indexPaths = [self.mutableItems indexPathsForObject:object];
    [self removeObjectsAtIndexPaths:indexPaths];
}

- (void)removeObjectAtIndexPath:(NSIndexPath *)indexPath {
    NSParameterAssert(indexPath);
    
    [self removeObjectsAtIndexPaths:@[indexPath]];
}

- (void)removeObjectsAtIndexPaths:(NSArray *)indexPaths {
    [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:self.rowAnimation];
    [self.mutableItems removeObjectsAtIndexPaths:indexPaths];
    self.items = [NSArray arrayWithArray:self.mutableItems];
}

#pragma mark - Property methods

- (NSMutableArray *)mutableItems {
    if (!_mutableItems) {
        _mutableItems = [NSMutableArray array];
        if (![[self.items.firstObject class] isSubclassOfClass:[NSArray class]]) {
            NSMutableArray *firstSectionItems = [NSMutableArray arrayWithArray:self.items];
            [_mutableItems addObject:firstSectionItems];
        } else {
            [self.items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                if ([[obj class] isSubclassOfClass:[NSArray class]]) {
                    NSMutableArray *sectionItems = [NSMutableArray arrayWithArray:obj];
                    [_mutableItems addObject:sectionItems];
                }
            }];
        }
    }
    return _mutableItems;
}

@end
