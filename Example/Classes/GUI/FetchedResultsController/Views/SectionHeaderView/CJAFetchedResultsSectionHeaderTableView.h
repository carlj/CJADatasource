//
//  CJAFetchedResultsSectionHeaderTableView.h
//  CJADataSource
//
//  Created by Bogdan Iusco on 8/1/14.
//  Copyright (c) 2014 Carl Jahn. All rights reserved.
//

#import "CJABaseTableHeaderFooterView.h"

@class CJADriver;

@interface CJAFetchedResultsSectionHeaderTableView : CJABaseTableHeaderFooterView

@property (nonatomic, strong) CJADriver *driver;
@property (nonatomic, assign) NSUInteger sectionIndex;

@end
