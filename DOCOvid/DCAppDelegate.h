//
//  DCAppDelegate.h
//  DOCOvid
//
//  Created by amor on 13-12-22.
//  Copyright (c) 2013年 amor. All rights reserved.
//

#import <UIKit/UIKit.h>
//@class DCTabController;
@class DCTabBarController;
@interface DCAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) DCTabBarController *rootviewController;

@end
