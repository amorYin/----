//
//  DCTabController.m
//  DOCOvid
//
//  Created by amor on 13-12-22.
//  Copyright (c) 2013年 amor. All rights reserved.
//

#import "DCTabController.h"
#import "DCLastViewController.h"
#import "DCNewViewController.h"
#import "DCCollectViewController.h"
#import "DCDownloadViewController.h"

@interface NavigationRotateController : UINavigationController {
    
}

@end

@implementation NavigationRotateController

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return [self.topViewController shouldAutorotateToInterfaceOrientation:interfaceOrientation];
}

@end

@interface DCTabController(NavigationRotateController)
- (NavigationRotateController*)createNavControllerWrappingViewControllerOfClass:(UIViewController*)viewController
                                                                        nibName:(NSString*)nibName
                                                                    tabIconName:(NSString*)iconName
                                                                       tabTitle:(NSString*)tabTitle
                                                                          color:(UIColor*)color;
@end

#pragma mark - NavigationRotateController
@interface DCTabController(NavigationRController)
- (NavigationRotateController*)createNavControllerWrappingViewControllerOfClass:(UIViewController*)viewController
                                                                        nibName:(NSString*)nibName
                                                                    tabIconName:(NSString*)iconName
                                                                       tabTitle:(NSString*)tabTitle
                                                                          color:(UIColor*)color;
@end
@implementation DCTabController(NavigationRController)
//自定义子视图初始化
- (NavigationRotateController *)createNavControllerWrappingViewControllerOfClass:(UIViewController*)viewController
                                                                         nibName:(NSString*)nibName
                                                                     tabIconName:(NSString*)iconName
                                                                        tabTitle:(NSString*)tabTitle
                                                                           color:(UIColor*)color
{
	NavigationRotateController *theNavigationController;
	theNavigationController = [[NavigationRotateController alloc] initWithRootViewController:viewController];
	theNavigationController.navigationBar.tintColor = color;
    theNavigationController.view.frame = [[UIScreen mainScreen] applicationFrame];
	viewController.tabBarItem.image = [UIImage imageNamed:iconName];
    viewController.tabBarItem.title = tabTitle;
	[viewController DD_RELEASE];
	return [theNavigationController DD_AUTORELEASE];
}
@end

@interface DCTabController ()<UITabBarControllerDelegate>
{
    /*
    DCLastViewController *lastViewController;
    DCNewViewController *newViewController;
    DCCollectViewController *collectViewController;
    DCDownloadViewController *downloadViewController;
     */
}

@end

@implementation DCTabController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //servral  views
    
    self.viewControllers = [NSArray arrayWithObjects:
                            [self createNavControllerWrappingViewControllerOfClass:
                             [[DCLastViewController alloc] initWithNibName:nil bundle:nil]
                                                                           nibName:nil
                                                                       tabIconName:@"zuixin_btn_n"
                                                                          tabTitle:@"最 新"
                                                                             color:NULL],
                            [self createNavControllerWrappingViewControllerOfClass:
                             [[DCNewViewController alloc] initWithNibName:nil bundle:nil]
                                                                           nibName:nil
                                                                       tabIconName:@"yugao_btn_n"
                                                                          tabTitle:@"预 告"
                                                                             color:NULL],
                            [self createNavControllerWrappingViewControllerOfClass:
                             [[DCCollectViewController alloc] initWithNibName:nil bundle:nil]
                                                                           nibName:nil
                                                                       tabIconName:@"shoucang_btn_n"
                                                                          tabTitle:@"收 藏"
                                                                             color:NULL],
                            [self createNavControllerWrappingViewControllerOfClass:
                             [[DCDownloadViewController alloc] initWithNibName:nil bundle:nil]
                                                                           nibName:nil
                                                                       tabIconName:@"lixian_btn_n"
                                                                          tabTitle:@"缓 存"
                                                                             color:NULL],
                            
                            nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
