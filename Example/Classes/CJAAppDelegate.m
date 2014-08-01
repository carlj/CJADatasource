//
//  CJAAppDelegate.m
//  CJADataSource
//
//  Created by Carl Jahn on 29.06.14.
//  Copyright (c) 2014 Carl Jahn. All rights reserved.
//

#import "CJAAppDelegate.h"
#import "CJATabBarController.h"

#import "CJACoreDataStarter.h"
#import "CJACoreDataInitializer.h"

@implementation CJAAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [self runStarters];

    self.window = [[UIWindow alloc] initWithFrame: [UIScreen mainScreen].bounds];
    self.window.rootViewController = [CJATabBarController new];
    [self.window makeKeyAndVisible];

    return YES;
}
							
- (void)runStarters {

    CJAStarterFactory *factory = [CJAStarterFactory new];
    [factory addStarterClass:[CJACoreDataStarter class]];
    [factory addStarterClass:[CJACoreDataInitializer class]];
    
    [factory run];
}

@end
