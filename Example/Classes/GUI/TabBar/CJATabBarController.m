//
//  CJATabBarController.m
//  CJADataSource
//
//  Created by Bogdan Iusco on 7/1/14.
//  Copyright (c) 2014 Carl Jahn. All rights reserved.
//

#import "CJATabBarController.h"
#import "CJABaseTableViewController.h"

@interface CJATabBarController ()

@property (nonatomic, strong) UIViewController *baseTableViewController;

@end

@implementation CJATabBarController

#pragma mark - UIViewController methods

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.viewControllers = @[self.baseTableViewController];
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

@end
