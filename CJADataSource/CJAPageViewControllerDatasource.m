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

@property (nonatomic, strong) NSMutableDictionary *cachedIndexes;

@end

@implementation CJAPageViewControllerDatasource

- (instancetype)initWithPageViewController:(UIPageViewController *)pageViewController {
    NSParameterAssert(pageViewController);
    
    self = [super init];
    if (self) {
        self.pageViewController = pageViewController;
        self.currentIndex = 0;
        self.cachedIndexes = [@{} mutableCopy];
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
    if (!newIndex) {
        return nil;
    }
    
    newIndex -= 1;
    
    UIViewController *newViewController = [self viewControllerForIndex:newIndex];
    NSString *hashKey = [[self class] hashKeyForObject:newViewController];
    
    self.cachedIndexes[hashKey] = @(newIndex);
    
    return newViewController;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger newIndex = self.currentIndex;
    
    newIndex += 1;
    
    UIViewController *newViewController = [self viewControllerForIndex:newIndex];
    NSString *hashKey = [[self class] hashKeyForObject:newViewController];
    
    self.cachedIndexes[hashKey] = @(newIndex);
    
    return newViewController;

}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {

    NSString *hashKey = [[self class] hashKeyForObject:pageViewController];
    return [self.cachedIndexes[hashKey] integerValue];
}

#pragma mark - UIPageViewController Delegate Methods
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers {

    NSString *hashKey = [[self class] hashKeyForObject:pendingViewControllers.firstObject];
    NSNumber *newIndex = self.cachedIndexes[hashKey];
    
    if (newIndex) {
        self.currentIndex = newIndex.integerValue;
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
    NSArray *viewControllers = @[newViewController];
    [self.pageViewController setViewControllers:viewControllers
                                      direction:direction
                                       animated:animated
                                     completion:^(BOOL finished){

                                         if (finished &&
                                             animated &&
                                             UIPageViewControllerTransitionStyleScroll == weakSelf.pageViewController.transitionStyle) {
                                             
                                             //there is a caching problem with the UIPageViewController and
                                             //the UIPageViewControllerTransitionStyleScroll transition
                                             //http://stackoverflow.com/questions/12939280/uipageviewcontroller-navigates-to-wrong-page-with-scroll-transition-style/12939384#12939384
                                             [weakSelf resetThePageViewControllerViewControllerStackWithViewControllers:viewControllers];
                                         }
                                         
                                         weakSelf.inTransition = NO;
                                         if (blockCompleted) {
                                             blockCompleted(finished);
                                             blockCompleted = nil;
                                         }
                                         
                                     }];
    
    self.currentIndex = index;
    
    return YES;
}

- (void)resetThePageViewControllerViewControllerStackWithViewControllers:(NSArray *)viewControllers {
    
    dispatch_async(dispatch_get_main_queue(), ^(void){

        //and there is a memory issue witht UIPageViewController, if you dont set the 'viewControllers' twice
        //the viewController's dont get a dealloc call.
        //thats why we set at first a empty viewcontroller and than the right given viewControllers
        //to fix the caching bug and also to fix the memory issue
        [self.pageViewController setViewControllers:@[[UIViewController new]]
                                          direction:UIPageViewControllerNavigationDirectionForward
                                           animated:NO
                                         completion:nil];

        [self.pageViewController setViewControllers:viewControllers
                                          direction:UIPageViewControllerNavigationDirectionForward
                                           animated:NO
                                         completion:nil];
    });
    
}

- (UIViewController *)viewControllerForIndex:(NSUInteger)index {
    NSParameterAssert(index >= 0);
    
    UIViewController *newViewController = nil;
    if (self.viewControllerBlock) {
        
        newViewController = self.viewControllerBlock(self.pageViewController, index);
        
    }
    
    if ([newViewController conformsToProtocol:@protocol(CJAPageViewControllerIndexedProtocol) ]) {
        
        id<CJAPageViewControllerIndexedProtocol> pageViewController = (id<CJAPageViewControllerIndexedProtocol>)newViewController;
        pageViewController.index = index;
    }
    
    return newViewController;
}

#pragma mark - Helper
+ (NSString *)hashKeyForObject:(NSObject *)object {
    
    if (!object) {
        return @"";
    }
    
    return [NSString stringWithFormat:@"%@", @(object.hash)];
}

@end
