//
//  DCCollectionCell.m
//  DOCOVedio
//
//  Created by 91aiche on 13-11-14.
//  Copyright (c) 2013年 amor. All rights reserved.
//

#import "DCCollectionCell.h"
@interface DCCollectionCell ()
{
    UIImageView *_bgImge;
}
@end
@implementation DCCollectionCell
  - (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView setFrame:CGRectMake(0, 0, cellSizeWidth, cellSizeHight)];
    }
    return self;
}
- (void)awakeFromNib
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED <= __IPHONE_6_0
    self.titleLal.textAlignment = UITextAlignmentCenter;
#else
    self.titleLal.textAlignment = NSTextAlignmentCenter;
#endif
    self.titleLal.font = EuphBold_font(16);
    self.titleLal.textColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sepeorcolor"]];
    self.titleLal.text = @"那些年我们逝去的风光";
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED <= __IPHONE_6_0
    self.deslal.textAlignment = UITextAlignmentCenter;
#else
    self.deslal.textAlignment = NSTextAlignmentCenter;
#endif
    self.deslal.font = EuphBold_font(14);
    self.deslal.textColor = [UIColor whiteColor];
    self.deslal.text = @"150.8M/218.1M";
}

-(void)prepareForReuse
{
    [super prepareForReuse];
    [self setImage:nil];
}

-(void)setImage:(UIImage *)image
{
    self.imageView.image = image;
}

- (void)setHiddenBgImge:(BOOL)hiddenBgImge
{
    if (hiddenBgImge) {
        _bgImge.hidden = YES;
    }else{
        _bgImge.hidden = NO;
    }
}

- (void)layoutSubviews
{
    if (!_bgImge) {
        _bgImge = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"clip_boders"]] DD_AUTORELEASE];
        _bgImge.origin = CGPointMake(0, 0);
        _bgImge.hidden = YES;
        [self addSubview:_bgImge];
    }
    
    if (!self.imageView) {
        self.imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(27, 34, 194, 130)] DD_AUTORELEASE];
        self.imageView.image = [UIImage imageNamed:@"placehold_hs_bg"];
        [self addSubview:self.imageView];
    }
    
    if (!self.delete_tag) {
        self.delete_tag = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"select_icon"]] DD_AUTORELEASE];
        self.delete_tag.origin = CGPointMake(192, 135);
        self.delete_tag.alpha = cellAHidden;
        [self addSubview:self.delete_tag];
    }
    
    if (!self.titleLal) {
        self.titleLal = [[[UILabel alloc] initWithFrame:CGRectMake(20, 179, self.width-40, 21)] DD_AUTORELEASE];
        self.titleLal.textColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sepeorcolor"]];
        self.titleLal.font = Euph_font(16);
        self.titleLal.backgroundColor = [UIColor clearColor];
#if __IPHONE_OS_VERSION_MAX_ALLOWED <= __IPHONE_6_0
        self.titleLal.textAlignment = UITextAlignmentCenter;
#else
        self.titleLal.textAlignment = NSTextAlignmentCenter;
#endif
        [self addSubview: self.titleLal];
    }
    
    if (!self.deslal) {
        self.deslal = [[[UILabel alloc] initWithFrame:CGRectMake(20, 201, self.width-40, 21)] DD_AUTORELEASE];
        self.deslal.textColor = [UIColor whiteColor];
        self.deslal.font = Euph_font(16);
        self.deslal.backgroundColor = [UIColor clearColor];
#if __IPHONE_OS_VERSION_MAX_ALLOWED <= __IPHONE_6_0
        self.deslal.textAlignment = UITextAlignmentCenter;
#else
        self.deslal.textAlignment = NSTextAlignmentCenter;
#endif
        [self addSubview: self.deslal];
    }
    
    //defalut value
    self.titleLal.text = @"测试影片";
    self.deslal.text = @"片长：10小时45分23秒";
    
}
@end
