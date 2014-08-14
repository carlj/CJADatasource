//
//  CJAPagedIndexViewController.h
//  CJADataSource
//
//  Created by Carl Jahn on 14.08.14.
//  Copyright (c) 2014 Carl Jahn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJAPageViewControllerDatasource.h"

@interface CJAPagedIndexViewController : UIViewController<CJAPageViewControllerIndexedProtocol>

@property (nonatomic, assign) NSUInteger index;

@end
