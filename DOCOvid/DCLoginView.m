//
//  DCLoginView.m
//  DOCOvid
//
//  Created by amor on 13-12-27.
//  Copyright (c) 2013年 amor. All rights reserved.
//

#import "DCLoginView.h"
#import "DCPopView.h"

@interface DCLoginView()
{
    DCPopView *_popView;
}
@end
@implementation DCLoginView

- (void)loginWithQQ:(id)sender
{
    [_popView dismissAnimated:YES];
}

- (void)loginWithSina:(id)sender
{
    [_popView dismissAnimated:YES];
}

- (void) show
{
    
    if (!_popView) {
        _popView = [[DCPopView alloc] initWithTitle:@"登录" size:CGSizeMake(308, 208)];
        [_popView handleContentView:^(UIView *popView) {
            @autoreleasepool {
                UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(60, 42, 77, 98)];
                [btn1 setImage:[UIImage imageNamed:@"qq_login_btn_n"] forState:UIControlStateNormal];
                [btn1 setImage:[UIImage imageNamed:@"qq_login_btn_h"] forState:UIControlStateHighlighted];
                [btn1 addTarget:self action:@selector(loginWithQQ:) forControlEvents:UIControlEventTouchUpInside];
                [popView addSubview:btn1];
                
                UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(60+77+26, 42, 77, 98)];
                [btn2 setImage:[UIImage imageNamed:@"sina_login_btn_n"] forState:UIControlStateNormal];
                [btn2 setImage:[UIImage imageNamed:@"sina_login_btn_h"] forState:UIControlStateHighlighted];
                [btn2 addTarget:self action:@selector(loginWithSina:) forControlEvents:UIControlEventTouchUpInside];
                [popView addSubview:btn2];
            }
        }];
    }
    [_popView show];
}
@end
