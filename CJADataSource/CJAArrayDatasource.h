//
//  CJAArrayDatasource.h
//  CJADataSource
//
//  Created by Carl Jahn on 27.06.14.
//  Copyright (c) 2014 Carl Jahn. All rights reserved.
//

#import "CJATableViewDatasource.h"

@interface CJAArrayDatasource : CJATableViewDatasource

- (instancetype)initWithTableView:(UITableView *)tableView
                            items:(NSArray *)items;

@property (nonatomic, strong) NSArray *items;

@end
