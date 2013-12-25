//
//  slender_button.h
//  aiche
//
//  Created by 91aiche on 13-6-26.
//  Copyright (c) 2013年 droudrou. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - slender_button
@protocol slender_button_delegate<NSObject>
- (void)slender_button_select:(int)index;
@optional
- (UIImage*)slender_button_bgimageAt:(int)index;
@end
@interface slender_button : UIView
@property (nonatomic)id<slender_button_delegate> delegate;
@property (DD_STRONG,nonatomic)NSArray *titles;
@property (nonatomic)CGColorRef hilightColor;
@property (nonatomic)CGColorRef nomalColor;
@property (weak,nonatomic)UIImage *bgImg;
@property (weak,nonatomic)UIImage *nomalBgImg;
@property (weak,nonatomic)UIImage *selectBgImg;
@property (nonatomic)NSInteger nomalSelectIndex;
- (void)scrollToIndex:(NSInteger)index;
- (id)initWithFrame:(CGRect)frame action:(id<slender_button_delegate>)dele;
@end