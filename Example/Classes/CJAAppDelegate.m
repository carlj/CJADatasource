//
//  CJAAppDelegate.m
//  CJADataSource
//
//  Created by Carl Jahn on 29.06.14.
//  Copyright (c) 2014 Carl Jahn. All rights reserved.
//

#import "CJAAppDelegate.h"
#import "CJABaseTableViewController.h"

@implementation CJAAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame: [UIScreen mainScreen].bounds];

    // Using a navigation controller in order to position the table view below the status bar and not under it.
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[CJABaseTableViewController new]];
    navigationController.navigationBarHidden = YES;
    self.window.rootViewController = navigationController;

    [self.window makeKeyAndVisible];
    
    return YES;
}
							

@end
