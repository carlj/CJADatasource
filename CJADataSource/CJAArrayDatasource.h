//
//  CJAArrayDatasource.h
//  CJADataSource
//
//  Created by Carl Jahn on 27.06.14.
//  Copyright (c) 2014 Carl Jahn. All rights reserved.
//

#import "CJADatasource.h"

@interface CJAArrayDatasource : CJADatasource

- (instancetype)initWithItems:(NSArray *)items
             tableViewIdentifiersAndCellClasses:(NSDictionary *)dictionary;


@end
