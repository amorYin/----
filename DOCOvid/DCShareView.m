//
//  DCShareView.m
//  DOCOVedio
//
//  Created by amor on 13-12-18.
//  Copyright (c) 2013年 amor. All rights reserved.
//

#import "DCShareView.h"
#import "DCPopView.h"

@interface DCShareView()
{
    DCPopView *_popView;
}
@end
@implementation DCShareView

- (void)shareToWeixin:(id)sender
{
    [_popView dismissAnimated:YES];
}

- (void)shareToPy:(id)sender
{
    [_popView dismissAnimated:YES];
}

- (void)shareToSina:(id)sender
{
    [_popView dismissAnimated:YES];
}

- (void)shareToQQ:(id)sender
{
    [_popView dismissAnimated:YES];
}

- (void) show
{
    if (!_popView) {
        _popView = [[DCPopView alloc] initWithTitle:@"分享" size:CGSizeMake(390, 208)];
        [_popView handleContentView:^(UIView *popView) {
            @autoreleasepool {
                UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(36, 42, 77, 98)];
                [btn1 setImage:[UIImage imageNamed:@"weixin_btn_n"] forState:UIControlStateNormal];
                [btn1 setImage:[UIImage imageNamed:@"weixin_btn_h"] forState:UIControlStateHighlighted];
                [btn1 addTarget:self action:@selector(shareToWeixin:) forControlEvents:UIControlEventTouchUpInside];
                [popView addSubview:btn1];
                
                UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(36+77, 42, 77, 98)];
                [btn2 setImage:[UIImage imageNamed:@"py_btn_n"] forState:UIControlStateNormal];
                [btn2 setImage:[UIImage imageNamed:@"py_btn_h"] forState:UIControlStateHighlighted];
                [btn2 addTarget:self action:@selector(shareToPy:) forControlEvents:UIControlEventTouchUpInside];
                [popView addSubview:btn2];
                
                UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(36+77*2, 42, 77, 98)];
                [btn3 setImage:[UIImage imageNamed:@"sina_btn_n"] forState:UIControlStateNormal];
                [btn3 setImage:[UIImage imageNamed:@"sina_btn_h"] forState:UIControlStateHighlighted];
                [btn3 addTarget:self action:@selector(shareToSina:) forControlEvents:UIControlEventTouchUpInside];
                [popView addSubview:btn3];
                
                UIButton *btn4 = [[UIButton alloc] initWithFrame:CGRectMake(36+77*3, 42, 77, 98)];
                [btn4 setImage:[UIImage imageNamed:@"q_btn_n"] forState:UIControlStateNormal];
                [btn4 setImage:[UIImage imageNamed:@"q_btn_h"] forState:UIControlStateHighlighted];
                [btn4 addTarget:self action:@selector(shareToQQ:) forControlEvents:UIControlEventTouchUpInside];
                [popView addSubview:btn4];
            }
        }];
    }
    [_popView show];
}
@end
