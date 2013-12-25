//
//  DCTabBarController.m
//  DOCOvid
//
//  Created by amor on 13-12-25.
//  Copyright (c) 2013年 amor. All rights reserved.
//

#import "DCTabBarController.h"
#import "RKTabView.h"
#import "DCLastViewController.h"
#import "DCNewViewController.h"
#import "DCCollectViewController.h"
#import "DCDownloadViewController.h"

#define kTabBarHeight 50.0f

static DCTabBarController *leveyTabBarController;

@interface NavigationHiddenController : UINavigationController {
    
}

@end

@implementation NavigationHiddenController

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return [self.topViewController shouldAutorotateToInterfaceOrientation:interfaceOrientation];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count==1)
        [leveyTabBarController hidesTabBar:YES animated:YES];
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    if (self.viewControllers.count==2)
        [leveyTabBarController hidesTabBar:NO animated:YES];
    return [super popViewControllerAnimated:animated];
}

@end


@implementation UIViewController (LeveyTabBarControllerSupport)

- (DCTabBarController *)dcTabBarController
{
	return leveyTabBarController;
}

- (RKTabItem*)dcTabbatitem
{
    for (int i=0;i<leveyTabBarController.viewControllers.count;i++) {
        UIViewController *obj = [leveyTabBarController.viewControllers objectAtIndex:i];
        if ([self isEqual:obj]) {
            return [leveyTabBarController.tabBar.tabItems objectAtIndex:i];
        }
    }
    return nil;
}

@end

@interface DCTabBarController (private)
- (void)displayViewAtIndex:(NSUInteger)index;
@end

@interface DCTabBarController ()<RKTabViewDelegate>
{
    UIView      *_containerView;
	UIView		*_transitionView;
}
@end

@implementation DCTabBarController
@synthesize delegate = _delegate;
@synthesize selectedViewController = _selectedViewController;
@synthesize viewControllers = _viewControllers;
@synthesize selectedIndex = _selectedIndex;
@synthesize tabBarHidden = _tabBarHidden;
@synthesize animateDriect;
@synthesize tabBar=_tabBar;
@synthesize tabBarTransparent=_tabBarTransparent;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
#ifdef __IPHONE_7
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
#else
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 748)];
#endif
		_transitionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _containerView.frame.size.width, _containerView.frame.size.height)];
		_transitionView.backgroundColor =  [UIColor groupTableViewBackgroundColor];
        _tabBar = [[RKTabView alloc] initWithFrame:CGRectMake(0, _containerView.frame.size.height - kTabBarHeight, _containerView.frame.size.width, kTabBarHeight)];
        _tabBar.delegate = self;
        _tabBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bottomBar"]];
        leveyTabBarController = self;
        animateDriect = 0;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NavigationHiddenController *)createNavControllerWrappingViewControllerOfClass:(DCViewController*)viewController withTitle:(NSString*)title order:(NSInteger)index
{
    NavigationHiddenController *theNavigationController;
	theNavigationController = [[NavigationHiddenController alloc] initWithRootViewController:viewController];
#ifndef __IPHONE_7
    theNavigationController.wantsFullScreenLayout = YES;
#endif
//    theNavigationController.view.frame = [[UIScreen mainScreen] applicationFrame];
//    viewController.title = title;
    viewController.dcTabbatItem = [_tabBar.tabItems objectAtIndex:index];
	[viewController DD_RELEASE];
	return [theNavigationController DD_AUTORELEASE];
}

#pragma mark -
- (void)buildUI
{
    RKTabItem *filtersTabItem = [RKTabItem createUsualItemWithImageEnabled:[UIImage imageNamed:@"zuixin_btn_h"] imageDisabled:[UIImage imageNamed:@"zuixin_btn_n"]];
    filtersTabItem.tabState = TabStateEnabled;
    
    RKTabItem *frameTabItem = [RKTabItem createUsualItemWithImageEnabled:[UIImage imageNamed:@"yugao_btn_h"] imageDisabled:[UIImage imageNamed:@"yugao_btn_n"]];
    RKTabItem *rotateTabItem = [RKTabItem createUsualItemWithImageEnabled:[UIImage imageNamed:@"shoucang_btn_h"] imageDisabled:[UIImage imageNamed:@"shoucang_btn_n"]];
    RKTabItem *contrastTabItem = [RKTabItem createUsualItemWithImageEnabled:[UIImage imageNamed:@"lixian_btn_h"] imageDisabled:[UIImage imageNamed:@"lixian_btn_n"]];
    
    self.tabBar.horizontalInsets = HorizontalEdgeInsetsMake(200, 200);
    
    self.tabBar.darkensBackgroundForEnabledTabs = NO;
    self.tabBar.drawSeparators = YES;
    self.tabBar.tabItems = @[filtersTabItem, frameTabItem, rotateTabItem, contrastTabItem];
}
- (void)loadView
{
	[super loadView];
	
	[_containerView addSubview:_transitionView];
	[_containerView addSubview:_tabBar];
	self.view = _containerView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self buildUI];
    /**/
    if (!_viewControllers) {
        _viewControllers =  [NSMutableArray arrayWithObjects:
                                [self createNavControllerWrappingViewControllerOfClass:
                                 [[DCLastViewController alloc] initWithNibName:nil bundle:nil]
                                                                             withTitle:@"最 新" order:0],
                                [self createNavControllerWrappingViewControllerOfClass:
                                 [[DCNewViewController alloc] initWithNibName:nil bundle:nil]
                                                                             withTitle:@"预 告" order:1],
                                [self createNavControllerWrappingViewControllerOfClass:
                                 [[DCCollectViewController alloc] initWithNibName:nil bundle:nil]
                                                                             withTitle:@"收 藏" order:2],
                                [self createNavControllerWrappingViewControllerOfClass:
                                 [[DCDownloadViewController alloc] initWithNibName:nil bundle:nil]
                                                                             withTitle:@"缓 存" order:3],
                                
                                nil];
    }
    
    self.selectedIndex = 0;
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	
	_tabBar = nil;
	_viewControllers = nil;
}

#pragma mark - instant methods

- (RKTabView *)tabBar
{
	return _tabBar;
}

- (BOOL)tabBarTransparent
{
	return _tabBarTransparent;
}

- (void)setTabBarTransparent:(BOOL)yesOrNo
{
	if (yesOrNo == YES)
	{
		_transitionView.frame = _containerView.bounds;
	}
	else
	{
		_transitionView.frame = CGRectMake(0, 0, _containerView.frame.size.width, _containerView.frame.size.height - kTabBarHeight);
	}
}


#pragma mark -
- (void)hidesTabBar:(BOOL)yesOrNO animated:(BOOL)animated
{
	if (yesOrNO == YES)
	{
		if (self.tabBar.frame.origin.y == self.view.frame.size.height)
		{
			return;
		}
	}
	else
	{
		if (self.tabBar.frame.origin.y == self.view.frame.size.height - kTabBarHeight)
		{
			return;
		}
	}
	
	if (animated == YES)
	{
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.3f];
		if (yesOrNO == YES)
		{
			self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y + kTabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
		}
		else
		{
			self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y - kTabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
		}
		[UIView commitAnimations];
	}
	else
	{
		if (yesOrNO == YES)
		{
			self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y + kTabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
		}
		else
		{
			self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y - kTabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
		}
	}
}

- (void)hidesTabBar:(BOOL)yesOrNO animated:(BOOL)animated driect:(NSInteger)driect
{
    /**/
}
#pragma mark - 
- (NSUInteger)selectedIndex
{
	return _selectedIndex;
}
- (UIViewController *)selectedViewController
{
    return [_viewControllers objectAtIndex:_selectedIndex];
}

-(void)setSelectedIndex:(NSUInteger)index
{
    [self displayViewAtIndex:index];
    //set
   /* [_tabBar selectTabAtIndex:index];*/
}

- (void)removeViewControllerAtIndex:(NSUInteger)index
{
    if (index >= [_viewControllers count])
    {
        return;
    }
    // Remove view from superview.
    [[(UIViewController *)[_viewControllers objectAtIndex:index] view] removeFromSuperview];
    // Remove viewcontroller in array.
    [_viewControllers removeObjectAtIndex:index];
    // Remove tab from tabbar.
/*    [_tabBar removeTabAtIndex:index];*/
}

- (void)insertViewController:(UIViewController *)vc withImageDic:(NSDictionary *)dict atIndex:(NSUInteger)index
{
    [_viewControllers insertObject:vc atIndex:index];
/*    [_tabBar insertTabWithImageDic:dict atIndex:index];*/
}


#pragma mark - Private methods
- (void)displayViewAtIndex:(NSUInteger)index
{
    // Before change index, ask the delegate should change the index.
    if ([_delegate respondsToSelector:@selector(tabBarController:shouldSelectViewController:)])
    {
        if (![_delegate tabBarController:self shouldSelectViewController:[self.viewControllers objectAtIndex:index]])
        {
            return;
        }
    }
    // If target index if equal to current index, do nothing.
    if (_selectedIndex == index && [[_transitionView subviews] count] != 0)
    {
        return;
    }
    _selectedIndex = index;
    
	UINavigationController *selectedVC = [self.viewControllers objectAtIndex:index];
	selectedVC.hidesBottomBarWhenPushed = YES;
	selectedVC.view.frame = _transitionView.frame;
	if ([selectedVC.view isDescendantOfView:_transitionView])
	{
		[_transitionView bringSubviewToFront:selectedVC.view];
	}
	else
	{
		[_transitionView addSubview:selectedVC.view];
	}
    
    // Notify the delegate, the viewcontroller has been changed.
    if ([_delegate respondsToSelector:@selector(tabBarController:didSelectViewController:)])
    {
        [_delegate tabBarController:self didSelectViewController:selectedVC];
    }
    
}

#pragma mark -
#pragma mark tabBar delegates
//Called for all types except TabTypeButton
- (void)tabView:(RKTabView *)tabView tabBecameEnabledAtIndex:(int)index tab:(RKTabItem *)tabItem
{
    if (self.selectedIndex == index) {
        UINavigationController *nav = [self.viewControllers objectAtIndex:index];
        [nav popToRootViewControllerAnimated:YES];
    }else {
        [self displayViewAtIndex:index];
    }
}
//Called Only for unexcludable items. (TabTypeUnexcludable)
- (void)tabView:(RKTabView *)tabView tabBecameDisabledAtIndex:(int)index tab:(RKTabItem *)tabItem
{
    
}
@end
