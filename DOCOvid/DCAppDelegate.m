//
//  DCAppDelegate.m
//  DOCOvid
//
//  Created by amor on 13-12-22.
//  Copyright (c) 2013年 amor. All rights reserved.
//

#import "DCAppDelegate.h"
//#import "DCTabController.h"
#import "DCTabBarController.h"

@implementation DCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.rootviewController = [[DCTabBarController alloc] initWithNibName:nil bundle:nil];
    self.window.rootViewController = self.rootviewController;
    self.window.backgroundColor = [UIColor whiteColor];
    if ([UIView iOSVersion]<7.0) {
    [application setStatusBarStyle:UIStatusBarStyleBlackOpaque];
        [[UINavigationBar appearance] setBackgroundImage:[[UIImage imageNamed:@"navigationbars"] stretchableImageWithLeftCapWidth:1 topCapHeight:1] forBarMetrics:UIBarMetricsDefault];
    }else{
        [application setStatusBarStyle:UIStatusBarStyleLightContent];
        [[UINavigationBar appearance] setBackgroundImage:[[UIImage imageNamed:@"navigationbar"] stretchableImageWithLeftCapWidth:1 topCapHeight:1] forBarMetrics:UIBarMetricsDefault];
    }
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                                  [UIColor whiteColor],UITextAttributeTextColor,
                                                                                  [UIColor grayColor],UITextAttributeTextShadowColor,
                                                                                  [NSValue valueWithUIOffset:UIOffsetMake(1, 0)],UITextAttributeTextShadowOffset,
                                                                                  [UIFont systemFontOfSize:16],UITextAttributeFont,nil]];
//    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"bottomBar"]];
//    [[UITabBar appearance] setTintColor:TINTCOLOR];
    [[UISegmentedControl appearance] setTintColor:TINTCOLOR];
    [[UIBarButtonItem appearance] setTintColor:TINTCOLOR];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)m duration:(NSTimeInterval)t
{
    return YES;
}

@end
