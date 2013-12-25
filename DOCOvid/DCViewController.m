//
//  DCViewController.m
//  DOCOVedio
//
//  Created by amor on 13-11-24.
//  Copyright (c) 2013年 amor. All rights reserved.
//

#import "DCViewController.h"

@interface DCViewController ()<UIScrollViewDelegate>

@end

@implementation DCViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
