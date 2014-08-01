//
//  CJABaseTableHeaderFooterView.h
//  CJADataSource
//
//  Created by Bogdan Iusco on 8/1/14.
//  Copyright (c) 2014 Carl Jahn. All rights reserved.
//

@import UIKit;

@interface CJABaseTableHeaderFooterView : UITableViewHeaderFooterView

@property (nonatomic, strong, readonly) UIButton *addCellButton;
@property (nonatomic, strong, readonly) UIButton *deleteCellButton;
@property (nonatomic, strong, readonly) UILabel  *sectionLabel;

@end
