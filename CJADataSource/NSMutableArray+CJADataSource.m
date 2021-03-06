//
//  NSMutableArray+CJADataSource.m
//  CJADataSource
//
//  Created by Bogdan Iusco on 7/1/14.
//  Copyright (c) 2014 Carl Jahn. All rights reserved.
//

#import "NSMutableArray+CJADataSource.h"

@implementation NSMutableArray (CJADataSource)

- (void)insertObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
    NSParameterAssert(object);
    NSParameterAssert(indexPath);
    
    NSAssert(indexPath.section < self.count, @"Invalid section number");

    id sectionObj = self[indexPath.section];
    NSAssert([[sectionObj class] isSubclassOfClass:[NSMutableArray class]], @"Should be an NSMutableArray type object");

    NSMutableArray *sectionItems = (NSMutableArray *)sectionObj;
    NSAssert(indexPath.row <= sectionItems.count, @"Invalid row number");
    [sectionItems insertObject:object atIndex:indexPath.row];
}

- (NSArray *)indexPathsForObject:(id)object {
    NSParameterAssert(object);
    
    NSMutableArray *indexPaths = [NSMutableArray array];
    NSUInteger countSections = self.count;
    for (NSUInteger sectionIndex = 0; sectionIndex < countSections; sectionIndex++) {
        id sectionObj = self[sectionIndex];
        NSAssert([[sectionObj class] isSubclassOfClass:[NSMutableArray class]], @"Should be an NSMutableArray type object");
        NSMutableArray *sectionItems = (NSMutableArray *)sectionObj;

        NSUInteger countItems = sectionItems.count;
        for (NSUInteger itemIndex = 0; itemIndex < countItems; itemIndex++) {
            id itemObj = sectionItems[itemIndex];
            if (itemObj == object) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:itemIndex inSection:sectionIndex];
                [indexPaths addObject:indexPath];
            }
        }
    }

    return indexPaths;
}

- (void)removeObjectsAtIndexPaths:(NSArray *)indexPaths {
    NSParameterAssert(indexPaths);
    
    for (NSIndexPath *indexPath in indexPaths) {
        id sectionObj = self[indexPath.section];
        NSAssert([[sectionObj class] isSubclassOfClass:[NSMutableArray class]], @"Should be an NSMutableArray type object");
        NSMutableArray *sectionItems = (NSMutableArray *)sectionObj;

        NSAssert(indexPath.row < sectionItems.count, @"Invalid row number");
        sectionItems[indexPath.row] = [NSNull null];
    }

    [self removeNullObjects];
}

- (void)removeNullObjects {
    NSUInteger countSections = self.count;
    for (NSUInteger sectionIndex = 0; sectionIndex < countSections; sectionIndex++) {
        id sectionObj = self[sectionIndex];
        NSAssert([[sectionObj class] isSubclassOfClass:[NSMutableArray class]], @"Should be an NSMutableArray type object");
        NSMutableArray *sectionItems = (NSMutableArray *)sectionObj;
        [sectionItems removeObjectIdenticalTo:[NSNull null]];
    }
}

- (void)removeEmptySections {
    NSMutableArray *toBeRemoved = [NSMutableArray array];
    NSUInteger countSections = self.count;
    for (NSUInteger sectionIndex = 0; sectionIndex < countSections; sectionIndex++) {
        id sectionObj = self[sectionIndex];
        NSAssert([[sectionObj class] isSubclassOfClass:[NSMutableArray class]], @"Should be an NSMutableArray type object");
        NSMutableArray *sectionItems = (NSMutableArray *)sectionObj;
        
        if (!sectionItems.count) {
            [toBeRemoved addObject:sectionItems];
        }
    }
    
    [self removeObjectsInArray:toBeRemoved];
}

@end
