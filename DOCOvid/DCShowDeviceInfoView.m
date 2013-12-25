//
//  DCShowDeviceInfoView.m
//  DOCOVedio
//
//  Created by amor on 13-11-24.
//  Copyright (c) 2013年 amor. All rights reserved.
//

#import "DCShowDeviceInfoView.h"
#include "BaseTools.h"

@interface DCShowDeviceInfoView()
{
    UILabel *contentBg;
    UILabel *otherSize;
    UILabel *usedSize;
    UILabel *freeSize;
    
    UILabel *des1;
    UILabel *des2;
    UILabel *des3;
    
    UILabel *col1;
    UILabel *col2;
    UILabel *col3;
//
    CGFloat  maxWidth;
    CGFloat  orginx;
    CGFloat  orginy;
    CGFloat  padding;
}
@end

@implementation DCShowDeviceInfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initlized];
        //reset
        [self refresh];
    }
    return self;
}

- (void)initlized
{
    //
    maxWidth = self.width*0.8;
    orginx = self.width*0.1;
    orginy = (self.height-20-14)*0.3;
    
    contentBg = [[UILabel alloc] initWithFrame:CGRectMake(orginx, orginy, maxWidth, 30)];
    contentBg.backgroundColor = [UIColor clearColor];
    
    padding = 0;
    otherSize = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, maxWidth*0.3, 16)];
    otherSize.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cache_use_str"]];
    otherSize.textColor = [UIColor whiteColor];
    otherSize.font = [UIFont systemFontOfSize:14.];
    [contentBg addSubview:otherSize];
    
    padding = maxWidth*0.3;
    usedSize = [[UILabel alloc] initWithFrame:CGRectMake(padding, 0, maxWidth*0.3, 16)];
    usedSize.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cache_other_str"]];
    usedSize.textColor = [UIColor whiteColor];
    usedSize.font = [UIFont systemFontOfSize:14.];
    [contentBg addSubview:usedSize];
    
    padding = maxWidth*0.6;
    freeSize = [[UILabel alloc] initWithFrame:CGRectMake(padding, 0, maxWidth*0.4, 16)];
    freeSize.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cache_remain_str"]];
    freeSize.textColor = [UIColor whiteColor];
    freeSize.font = [UIFont systemFontOfSize:14.];
    [contentBg addSubview:freeSize];
    
    [self addSubview:contentBg];

    CGFloat margin = (self.width-(90*3+20*3+20*2))*0.5;
    
    
    col1 = [[UILabel alloc] initWithFrame:CGRectMake(margin, orginy*2+30-3, 14, 14)];
    col1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cache_remain_bg"]];
    [self addSubview:col1];
    
    margin = margin+20;
    des1 = [[UILabel alloc] initWithFrame:CGRectMake(margin, orginy*2+30-3, 90, 14)];
    des1.text = @"其他程序";
    des1.font = [UIFont systemFontOfSize:12.];
    des1.backgroundColor = [UIColor clearColor];
    des1.textColor = [UIColor whiteColor];
    [self addSubview:des1];
    
    
    margin = margin+90+20;
    col2 = [[UILabel alloc] initWithFrame:CGRectMake(margin, orginy*2+30-3, 14, 14)];
    col2.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cache_other_bg"]];
    [self addSubview:col2];
    
    margin = margin+20;
    des2 = [[UILabel alloc] initWithFrame:CGRectMake(margin, orginy*2+30-3, 90, 14)];
    des2.text = @"DOCO";
    des2.font = [UIFont systemFontOfSize:12.];
    des2.backgroundColor = [UIColor clearColor];
    des2.textColor = [UIColor whiteColor];
    [self addSubview:des2];
    
    margin = margin+90+20;
    col3 = [[UILabel alloc] initWithFrame:CGRectMake(margin, orginy*2+30-3, 14, 14)];
    col3.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cache_use_bg"]];
    [self addSubview:col3];
    
    margin = margin+20;
    des3 = [[UILabel alloc] initWithFrame:CGRectMake(margin, orginy*2+30-3, 90, 14)];
    des3.text = @"剩余";
    des3.font = [UIFont systemFontOfSize:12.];
    des3.textColor = [UIColor whiteColor];
    des3.backgroundColor = [UIColor clearColor];
    [self addSubview:des3];
}

- (void)refresh
{
    double  toltal = systemDiskInBytes();
    double  free = freeDiskSpaceInBytes();
    double  other = fileDiskInBytes();

    [UIView animateWithDuration:0.25  animations:^{
        des1.text = [NSString stringWithFormat:@"其他程序%.2fG",(toltal-free-other)/1024];
        otherSize.size = CGSizeMake((toltal-free-other)/toltal*maxWidth-60, 16);
        padding = (toltal-free-other)/toltal*maxWidth-60;
        
        des2.text = [NSString stringWithFormat:@"DOCO%.2fG",other/1024];
        usedSize.origin = CGPointMake(padding, 0);
        usedSize.size = CGSizeMake(other/toltal*maxWidth+60, 16);
        padding = padding + other/toltal*maxWidth+60;
        
        des3.text = [NSString stringWithFormat:@"剩余%.2fG",free/1024];
        freeSize.origin = CGPointMake(padding, 0);
        freeSize.size = CGSizeMake(free/toltal*maxWidth, 16);
    } completion:^(BOOL finished) {
        
    }];
    

    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
