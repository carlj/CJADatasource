//
//  CJAPageViewController.m
//  CJADataSource
//
//  Created by Carl Jahn on 14.08.14.
//  Copyright (c) 2014 Carl Jahn. All rights reserved.
//

#import "CJAPageViewController.h"
#import "CJAPageViewControllerDatasource.h"
#import "CJAPagedIndexViewController.h"

@interface CJAPageViewController ()

@property (nonatomic, strong) CJAPageViewControllerDatasource *pageViewDatasource;

@end

@implementation CJAPageViewController

- (instancetype)initWithTransitionStyle:(UIPageViewControllerTransitionStyle)style
                  navigationOrientation:(UIPageViewControllerNavigationOrientation)navigationOrientation
                                options:(NSDictionary *)options {

    self = [super initWithTransitionStyle:style navigationOrientation:navigationOrientation options:options];
    if (self) {
        
        self.title = NSLocalizedString(@"Page View", nil);
        self.automaticallyAdjustsScrollViewInsets = NO;

        
        self.pageViewDatasource = [[CJAPageViewControllerDatasource alloc] initWithPageViewController: self];
        
        
        
        self.pageViewDatasource.viewControllerBlock = ^(UIPageViewController *pageViewController, NSUInteger index){
            
            return [CJAPagedIndexViewController new];
            
        };
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Next", nil)
                                                                                  style:UIBarButtonItemStylePlain
                                                                                 target:self
                                                                                 action:@selector(nextOne:)];
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Back", nil)
                                                                                 style:UIBarButtonItemStylePlain
                                                                                target:self
                                                                                action:@selector(previousOne:)];
        
    }
    
    return self;
}

- (void)nextOne:(id)sender {

    [self.pageViewDatasource showNextViewControllerAnimated:YES completed:nil];
}

- (void)previousOne:(id)sender {

    [self.pageViewDatasource showPreviousViewControllerAnimated:YES completed:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.pageViewDatasource showControllerAtIndex:0 animated:NO completed:nil];
}


@end
