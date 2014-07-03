//
//  CJAMutableArraySectionHeaderTableView.h
//  CJADataSource
//
//  Created by Bogdan Iusco on 7/2/14.
//  Copyright (c) 2014 Carl Jahn. All rights reserved.
//

@import UIKit;

@interface CJAMutableArraySectionHeaderTableView : UITableViewHeaderFooterView

@property (nonatomic, strong, readonly) UIButton *addCellButton;
@property (nonatomic, strong, readonly) UIButton *deleteCellButton;
@property (nonatomic, strong, readonly) UILabel  *sectionLabel;


@property (nonatomic, assign) NSUInteger sectionIndex;

@end
