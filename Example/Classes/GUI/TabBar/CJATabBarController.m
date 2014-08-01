//
//  CJATabBarController.m
//  CJADataSource
//
//  Created by Bogdan Iusco on 7/1/14.
//  Copyright (c) 2014 Carl Jahn. All rights reserved.
//

#import "CJATabBarController.h"
#import "CJABaseTableViewController.h"
#import "CJAMutableArrayTableViewController.h"
#import "CJAFetchedResultsTableViewController.h"


@interface CJATabBarController ()

@property (nonatomic, strong) UIViewController *baseTableViewController;
@property (nonatomic, strong) UIViewController *mutableArrayTableViewController;
@property (nonatomic, strong) UIViewController *fetchedResultsTableViewController;

@end

@implementation CJATabBarController

#pragma mark - UIViewController methods

- (instancetype)init {
    self = [super init];
    if (self) {
        
        self.viewControllers = @[self.baseTableViewController,
                                 self.mutableArrayTableViewController,
                                 self.fetchedResultsTableViewController];
    }
    return self;
}

#pragma mark - Property methods

- (UIViewController *)baseTableViewController {
    if (!_baseTableViewController) {
        CJABaseTableViewController *baseVC = [CJABaseTableViewController new];
        _baseTableViewController = [[UINavigationController alloc] initWithRootViewController:baseVC];
    }
    return _baseTableViewController;
}

- (UIViewController *)mutableArrayTableViewController {
    if (!_mutableArrayTableViewController) {
        CJAMutableArrayTableViewController *mutableArrayVC = [CJAMutableArrayTableViewController new];
        _mutableArrayTableViewController = [[UINavigationController alloc] initWithRootViewController:mutableArrayVC];
    }
    return _mutableArrayTableViewController;
}

- (UIViewController *)fetchedResultsTableViewController {
    if (!_fetchedResultsTableViewController) {
        CJAFetchedResultsTableViewController *fetchedResultsVC = [CJAFetchedResultsTableViewController new];
        _fetchedResultsTableViewController = [[UINavigationController alloc] initWithRootViewController:fetchedResultsVC];
    }
    return _fetchedResultsTableViewController;
}

@end
