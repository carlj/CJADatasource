//
//  CJAPageViewControllerDatasource.h
//  CJADataSource
//
//  Created by Carl Jahn on 14.08.14.
//  Copyright (c) 2014 Carl Jahn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol CJAPageViewControllerIndexedProtocol <NSObject>

@required
@property (nonatomic, assign) NSUInteger index;

@end


typedef void(^CJAPageViewControllerDatasourceAnimationCompletionBlock)(BOOL completed);
typedef void(^CJAPageViewControllerDatasourceChangedCurrentIndexBlock)(NSUInteger newIndex);
typedef UIPageViewControllerNavigationDirection(^CJAPageViewControllerDatasourcePageAnimationBlock)(NSUInteger newIndex);

typedef UIViewController<CJAPageViewControllerIndexedProtocol> *(^CJAPageViewControllerDatasourceControllerBlock)(UIPageViewController *pageViewController, NSUInteger index );

@interface CJAPageViewControllerDatasource : NSObject<UIPageViewControllerDataSource, UIPageViewControllerDelegate>

- (instancetype)initWithPageViewController:(UIPageViewController *)pageViewController;

@property (nonatomic, assign, readonly) UIPageViewController *pageViewController;
@property (nonatomic, assign, readonly) NSUInteger currentIndex;

@property (nonatomic, copy) CJAPageViewControllerDatasourceControllerBlock viewControllerBlock;
@property (nonatomic, copy) CJAPageViewControllerDatasourceChangedCurrentIndexBlock currentIndexChangedBlock;
@property (nonatomic, copy) CJAPageViewControllerDatasourcePageAnimationBlock pageAnimationBlock;

- (BOOL)showControllerAtIndex:(NSUInteger)index animated:(BOOL)animated completed:(CJAPageViewControllerDatasourceAnimationCompletionBlock)completed;

- (BOOL)showNextViewControllerAnimated:(BOOL)animated completed:(CJAPageViewControllerDatasourceAnimationCompletionBlock)completed;
- (BOOL)showPreviousViewControllerAnimated:(BOOL)animated completed:(CJAPageViewControllerDatasourceAnimationCompletionBlock)completed;

@end

