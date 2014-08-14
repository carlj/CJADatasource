//
//  CJAPageViewControllerDatasource.m
//  CJADataSource
//
//  Created by Carl Jahn on 14.08.14.
//  Copyright (c) 2014 Carl Jahn. All rights reserved.
//

#import "CJAPageViewControllerDatasource.h"


@interface CJAPageViewControllerDatasource ()

@property (nonatomic, assign, readwrite) UIPageViewController *pageViewController;
@property (nonatomic, assign, readwrite) NSUInteger currentIndex;

@property (nonatomic, assign, getter = isinTransition) BOOL inTransition;

@end

@implementation CJAPageViewControllerDatasource

- (instancetype)initWithPageViewController:(UIPageViewController *)pageViewController {
    NSParameterAssert(pageViewController);
    
    self = [super init];
    if (self) {
        self.pageViewController = pageViewController;
        self.currentIndex = 0;
    }
    
    return self;
}

- (void)setPageViewController:(UIPageViewController *)pageViewController {
    if (_pageViewController == pageViewController) {
        return;
    }
    
    _pageViewController = pageViewController;
    _pageViewController.delegate = self;
    _pageViewController.dataSource = self;
}

- (void)setCurrentIndex:(NSUInteger)currentIndex {
    if (_currentIndex == currentIndex) {
        return;
    }
    _currentIndex = currentIndex;
    
    if (self.currentIndexChangedBlock) {
        self.currentIndexChangedBlock(_currentIndex);
    }
    
}

#pragma mark - UIPageViewController DataSource Methods
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger newIndex = self.currentIndex;
    if ([viewController conformsToProtocol:@protocol(CJAPageViewControllerIndexedProtocol)]) {
        
        id<CJAPageViewControllerIndexedProtocol> indexedViewController = (id<CJAPageViewControllerIndexedProtocol>)viewController;
        newIndex = indexedViewController.index - 1;
    }
    
    return [self viewControllerForIndex:newIndex];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger newIndex = self.currentIndex;
    if ([viewController conformsToProtocol:@protocol(CJAPageViewControllerIndexedProtocol)]) {
        
        id<CJAPageViewControllerIndexedProtocol> indexedViewController = (id<CJAPageViewControllerIndexedProtocol>)viewController;
        newIndex = indexedViewController.index + 1;
    }
    
    return [self viewControllerForIndex: newIndex];
}

#pragma mark - UIPageViewController Delegate Methods
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers {
    
    if ([pendingViewControllers.firstObject conformsToProtocol:@protocol(CJAPageViewControllerIndexedProtocol)]) {
        
        id<CJAPageViewControllerIndexedProtocol> indexedViewController = (id<CJAPageViewControllerIndexedProtocol>)pendingViewControllers.firstObject;
        self.currentIndex = [indexedViewController index];
        
    }
    
}

- (BOOL)showNextViewControllerAnimated:(BOOL)animated completed:(CJAPageViewControllerDatasourceAnimationCompletionBlock)completed {
    
    return [self showControllerAtIndex:self.currentIndex + 1 animated:animated completed:completed];
}

- (BOOL)showPreviousViewControllerAnimated:(BOOL)animated completed:(CJAPageViewControllerDatasourceAnimationCompletionBlock)completed; {
    
    if (!self.currentIndex) {
        return NO;
    }
    
    return [self showControllerAtIndex:self.currentIndex - 1 animated:animated completed: completed];
}

- (BOOL)showControllerAtIndex:(NSUInteger)index animated:(BOOL)animated completed:(CJAPageViewControllerDatasourceAnimationCompletionBlock)completed {
    NSParameterAssert(index >= 0);
    
    if (self.isinTransition) {
        return NO;
    }
    
    UIViewController *newViewController = [self viewControllerForIndex:index];
    
    if (!newViewController) {
        return NO;
    }
    
    UIPageViewControllerNavigationDirection direction = UIPageViewControllerNavigationDirectionForward;
    if (self.pageAnimationBlock) {
        
        direction = self.pageAnimationBlock(index);
        
    } else {
        
        if (index < self.currentIndex) {
            direction = UIPageViewControllerNavigationDirectionReverse;
        }
        
    }
    
    self.inTransition = YES;
    
    __block typeof(CJAPageViewControllerDatasourceAnimationCompletionBlock) blockCompleted = completed;
    __weak typeof(self) weakSelf = self;
    [self.pageViewController setViewControllers:@[newViewController]
                                      direction:direction
                                       animated:animated
                                     completion:^(BOOL finished){
                                         
                                         weakSelf.inTransition = NO;
                                         if (blockCompleted) {
                                             blockCompleted(finished);
                                             blockCompleted = nil;
                                         }
                                         
                                     }];
    
    self.currentIndex = index;
    
    return YES;
}

- (UIViewController<CJAPageViewControllerIndexedProtocol> *)viewControllerForIndex:(NSUInteger)index {
    NSParameterAssert(index >= 0);
    
    UIViewController<CJAPageViewControllerIndexedProtocol> *newViewController = nil;
    if (self.viewControllerBlock) {
        
        newViewController = self.viewControllerBlock(self.pageViewController, index);
        
    }
    
    if ([newViewController conformsToProtocol:@protocol(CJAPageViewControllerIndexedProtocol) ]) {
        newViewController.index = index;
    }
    
    return newViewController;
}

@end
