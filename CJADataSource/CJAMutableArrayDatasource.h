//
//  CJAMutableArrayDatasource.h
//  CJADataSource
//
//  Created by Bogdan Iusco on 7/1/14.
//  Copyright (c) 2014 Carl Jahn. All rights reserved.
//

#import "CJAArrayDatasource.h"

@interface CJAMutableArrayDatasource : CJAArrayDatasource

@property (nonatomic, assign) UITableViewRowAnimation rowAnimation;

/**
 * Add an object at the end of the last section.
 * @param object Object to be added.
 */
- (void)addObject:(id)object;

/**
 * Add an object at the end of a given section.
 * @param object Object to be added.
 * @param section Section index that will containt the object.
 */
- (void)addObject:(id)object inSection:(NSUInteger)section;

/**
 * Add an object at a given position.
 * @param object Object to be added.
 * @param indexPath Index path where to add the object.
 */
- (void)insertObject:(id)object atIndexPath:(NSIndexPath *)indexPath;

/**
 * Delete all objects that are equal to a given one.
 * @param object Object to compare.
 */
- (void)removeObjects:(id)object;

/**
 * Delete an object at given index paths.
 * @param indexPaths Position of the object to delete.
 */
- (void)removeObjectAtIndexPath:(NSIndexPath *)indexPath;

/**
 * Delete objects at given index paths.
 * @param indexPaths Array of NSIndexPath type objects.
 */
- (void)removeObjectsAtIndexPaths:(NSArray *)indexPaths;

@end
