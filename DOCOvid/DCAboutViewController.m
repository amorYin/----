//
//  DCAboutViewController.m
//  DOCOVedio
//
//  Created by amor on 13-12-17.
//  Copyright (c) 2013年 amor. All rights reserved.
//

#import "DCAboutViewController.h"
#import "DCShareView.h"

@interface DCAboutViewController ()
{
    UIImageView *imgaev;
    UILabel  *versionLal;
    UIButton  *versionBtn;
    UILabel  *descriplal;
    
    
    UIButton  *loginBtn;
    UILabel  *loginDesLal;
    UIButton  *adviceBtn;
    UILabel  *adviceDesLal;
    UIButton  *voteBtn;
    UILabel  *voteDesLal;
    
    UILabel  *copyright;
    UILabel  *copyright2;
}

@end

@implementation DCAboutViewController
#pragma mark - back
- (void)backforLast
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - user action
- (void) userLogin:(id)sender
{
    DCShareView *aler = [[[DCShareView alloc] init] DD_AUTORELEASE];
    [aler show];
}

- (void) userAdvice:(id)sender
{

}

- (void) userVote:(id)sender
{
    
}

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
    // left navigationBar
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 48, 48)];
    [btn setImage:[UIImage imageNamed:@"back_btn_n"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"back_btn_h"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(backforLast) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [btn DD_AUTORELEASE];
    if (!imgaev) {
        imgaev = [[UIImageView alloc] initWithFrame:CGRectMake(409, 50, 206, 76)];
        [imgaev setImage:[UIImage imageNamed:@"logo_p"]];
        [self.view addSubview:imgaev];
    }
    
    if (!versionLal) {
        versionLal = [[UILabel alloc] initWithFrame:CGRectMake(409, 130, 206, 30)];
        #if __IPHONE_OS_VERSION_MAX_ALLOWED <= __IPHONE_6_0
        versionLal.textAlignment = UITextAlignmentCenter;
        #else
        versionLal.textAlignment = NSTextAlignmentCenter;
        #endif
        versionLal.text = @"iPad V1.0";
        versionLal.font = Euph_font(26);
        versionLal.textColor = [UIColor lightGrayColor];
        versionLal.backgroundColor = [UIColor clearColor];
        [self.view addSubview:versionLal];
    }

    if (!versionBtn) {
        versionBtn = [[UIButton alloc] initWithFrame:CGRectMake(334, 180, 356, 40)];
        [versionBtn setBackgroundImage:[UIImage imageNamed:@"version_btn_n"] forState:UIControlStateNormal];
        [versionBtn setBackgroundImage:[UIImage imageNamed:@"version_btn_h"] forState:UIControlStateNormal];
        [versionBtn setTitle:@"已经是最新版本" forState:UIControlStateNormal];
        [versionBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [versionBtn.titleLabel setFont:Bold_font(20.)];
        [self.view addSubview:versionBtn];
    }
    
    if (!descriplal) {
        descriplal = [[UILabel alloc] initWithFrame:CGRectMake(300, 230, 424, 100)];
        descriplal.numberOfLines = 4;
        descriplal.text = @"      一段介绍文字一段介绍文字一段介绍文字一段介绍文字一段介绍文字一段介绍文字一段介绍文字一段介绍文字一段介绍文字一段介绍文字一段介绍文字一段介绍文字一段介绍文字一段介绍文字一段介绍文字一段介绍文字一段介绍文字一段介绍文字一段介绍文字一段介绍文字一段介绍文字一段介绍文字一段介绍文字一段介绍文字一段介绍文字一段介绍文字一段介绍文字一段介绍文字";
        descriplal.textColor = [UIColor lightGrayColor];
        descriplal.backgroundColor = [UIColor clearColor];
        descriplal.font = Euph_font(14.);
        [self.view addSubview:descriplal];
    }
    
    if (!loginBtn) {
        loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(334, 340, 84, 32)];
        [loginBtn setBackgroundImage:[UIImage imageNamed:@"login_btn_n"] forState:UIControlStateNormal];
        [loginBtn setBackgroundImage:[UIImage imageNamed:@"login_btn_h"] forState:UIControlStateHighlighted];
        [loginBtn setTitle:@"登  录" forState:UIControlStateNormal];
        [loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [loginBtn.titleLabel setFont:Euph_font(14.)];
        [loginBtn addTarget:self action:@selector(userLogin:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:loginBtn];
    }
    
    if (!loginDesLal) {
        loginDesLal = [[UILabel alloc] initWithFrame:CGRectMake(456, 346, 424, 20)];
        loginDesLal.text = @"登录我们收藏使用更方便";
        loginDesLal.textColor = [UIColor lightGrayColor];
        loginDesLal.backgroundColor = [UIColor clearColor];
        loginDesLal.font = Euph_font(14.);
        [self.view addSubview:loginDesLal];
    }
    
    if (!adviceBtn) {
        adviceBtn = [[UIButton alloc] initWithFrame:CGRectMake(334, 402, 84, 32)];
        [adviceBtn setBackgroundImage:[UIImage imageNamed:@"login_btn_n"] forState:UIControlStateNormal];
        [adviceBtn setBackgroundImage:[UIImage imageNamed:@"login_btn_h"] forState:UIControlStateHighlighted];
        [adviceBtn setTitle:@"意见反馈" forState:UIControlStateNormal];
        [adviceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [adviceBtn.titleLabel setFont:Euph_font(14.)];
        [loginBtn addTarget:self action:@selector(userAdvice:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:adviceBtn];
    }
    
    if (!adviceDesLal) {
        adviceDesLal = [[UILabel alloc] initWithFrame:CGRectMake(456, 408, 424, 20)];
        adviceDesLal.text = @"您的宝贵意见对我们很有帮助";
        adviceDesLal.textColor = [UIColor lightGrayColor];
        adviceDesLal.backgroundColor = [UIColor clearColor];
        adviceDesLal.font = Euph_font(14.);
        [self.view addSubview:adviceDesLal];
    }
    
    
    if (!voteBtn) {
        voteBtn = [[UIButton alloc] initWithFrame:CGRectMake(334, 464, 84, 32)];
        [voteBtn setBackgroundImage:[UIImage imageNamed:@"login_btn_n"] forState:UIControlStateNormal];
        [voteBtn setBackgroundImage:[UIImage imageNamed:@"login_btn_h"] forState:UIControlStateHighlighted];
        [voteBtn setTitle:@"评  分" forState:UIControlStateNormal];
        [voteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [voteBtn.titleLabel setFont:Euph_font(14.)];
        [loginBtn addTarget:self action:@selector(userVote:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:voteBtn];
    }
    
    if (!voteDesLal) {
        voteDesLal = [[UILabel alloc] initWithFrame:CGRectMake(456, 470, 424, 20)];
        voteDesLal.text = @"给我们打个分吧";
        voteDesLal.textColor = [UIColor lightGrayColor];
        voteDesLal.backgroundColor = [UIColor clearColor];
        voteDesLal.font = Euph_font(14.);
        [self.view addSubview:voteDesLal];
    }
    
    if (!copyright) {
        copyright = [[UILabel alloc] initWithFrame:CGRectMake(328, 614, 368, 20)];
        copyright.text = @"视袭影视公司版权所有";
#if __IPHONE_OS_VERSION_MAX_ALLOWED <= __IPHONE_6_0
        copyright.textAlignment = UITextAlignmentCenter;
#else
        copyright.textAlignment = NSTextAlignmentCenter;
#endif
        copyright.textColor = [UIColor lightGrayColor];
        copyright.backgroundColor = [UIColor clearColor];
        copyright.font = Euph_font(14.);
        [self.view addSubview:copyright];
    }
    
    if (!copyright2) {
        copyright2 = [[UILabel alloc] initWithFrame:CGRectMake(328, 644, 368, 20)];
        copyright2.text = @"Copyright © 2014 DOCO.china.com Inc All Right Reserved";
#if __IPHONE_OS_VERSION_MAX_ALLOWED <= __IPHONE_6_0
        copyright2.textAlignment = UITextAlignmentCenter;
#else
        copyright2.textAlignment = NSTextAlignmentCenter;
#endif
        copyright2.textColor = [UIColor lightGrayColor];
        copyright2.backgroundColor = [UIColor clearColor];
        copyright2.font = Euph_font(14.);
        [self.view addSubview:copyright2];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
