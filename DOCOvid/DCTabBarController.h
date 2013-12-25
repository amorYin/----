//
//  DCTabBarController.h
//  DOCOvid
//
//  Created by amor on 13-12-25.
//  Copyright (c) 2013年 amor. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RKTabView;
@class RKTabItem;
@protocol DCTabBarControllerDelegate;

@interface DCTabBarController : UIViewController
@property(nonatomic, copy) NSMutableArray *viewControllers;
@property(nonatomic, readonly) UIViewController *selectedViewController;
@property(nonatomic) NSUInteger selectedIndex;

// Apple is readonly
@property (nonatomic, readonly) RKTabView *tabBar;
@property(nonatomic,assign) id<DCTabBarControllerDelegate> delegate;
@property (nonatomic) BOOL tabBarTransparent;
@property (nonatomic) BOOL tabBarHidden;

@property(nonatomic,assign) NSInteger animateDriect;

- (void)hidesTabBar:(BOOL)yesOrNO animated:(BOOL)animated;

// Remove the viewcontroller at index of viewControllers.
- (void)removeViewControllerAtIndex:(NSUInteger)index;

// Insert an viewcontroller at index of viewControllers.
- (void)insertViewController:(UIViewController *)vc withImageDic:(NSDictionary *)dict atIndex:(NSUInteger)index;


@end


@protocol DCTabBarControllerDelegate <NSObject>
@optional
- (BOOL)tabBarController:(DCTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController;
- (void)tabBarController:(DCTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController;
@end

@interface UIViewController (LeveyTabBarControllerSupport)
@property(nonatomic, readonly) DCTabBarController *dcTabBarController;
@property(nonatomic, readonly) RKTabItem *dcTabbatitem;
@end