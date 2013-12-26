//
//  DCViewController.m
//  DOCOVedio
//
//  Created by amor on 13-11-24.
//  Copyright (c) 2013年 amor. All rights reserved.
//

#import "DCViewController.h"
NSString *const UserLoadStautsNotifacation = @"UserLoadedNotifacation";

@interface DCViewController ()<UIScrollViewDelegate>

@end

@implementation DCViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _userStatus = [[ACUser instanseUser] userStatus];
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(haddleUserStatus:) name:UserLoadStautsNotifacation object:nil];
    }
    return self;
}

- (void)userStautsDidChanged:(UserLoadStauts)status
{
    switch (status) {
        case UserLoadStautsNone:
            
            break;
        case UserLoadStautsWillLoadQQ:
            
            break;
        case UserLoadStautsWillLoadSina:
            
            break;
        case UserLoadStautsLoadingQQ:
            
            break;
        case UserLoadStautsLoadingSina:
            
            break;
        case UserLoadStautsLoadedSina:
            
            break;
        case UserLoadStautsErrorQQ:
            
            break;
        case UserLoadStautsErrorSina:
            
            break;
            
        default:
            break;
    }
}

- (void)haddeduserStauts:(NSValue*)statuv
{
    UserLoadStauts status;
    [(NSValue*)statuv getValue:&status];
    _userStatus = status;
    statuv = nil;
    if ([self respondsToSelector:@selector(userStautsDidChanged:)]) {
        [self userStautsDidChanged:status];
    }else{
    }
}

- (void)haddleUserStatus:(NSNotification*)noti
{
    [self performSelector:@selector(haddeduserStauts:)
               withObject:[noti object]
               afterDelay:0.];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if (!self.scrollerView) {
        self.scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0, self.view.height, self.view.width)];
        self.scrollerView.delegate = self;
        self.scrollerView.pagingEnabled = YES;
        self.scrollerView.backgroundColor = [UIColor colorWithRed:15/255. green:15/255. blue:15/255. alpha:1.];
        [self.view addSubview:self.scrollerView];
        
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.scrollerView = nil;
    self.dcTabbatItem = nil;
    self.segment = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
