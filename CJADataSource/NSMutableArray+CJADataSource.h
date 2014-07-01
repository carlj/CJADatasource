//
//  NSMutableArray+CJADataSource.h
//  CJADataSource
//
//  Created by Bogdan Iusco on 7/1/14.
//  Copyright (c) 2014 Carl Jahn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (CJADataSource)

- (void)insertObject:(id)object atIndexPath:(NSIndexPath *)indexPath;

- (NSArray *)indexPathsForObject:(id)object;

- (void)removeObjectsAtIndexPaths:(NSArray *)indexPaths;
- (void)removeEmptySections;


@end
