//
//  DCPopView.h
//  DOCOVedio
//
//  Created by amor on 13-12-17.
//  Copyright (c) 2013年 amor. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const DCPopViewWillShowNotification;
extern NSString *const DCPopViewDidShowNotification;
extern NSString *const DCPopViewWillDismissNotification;
extern NSString *const DCPopViewDidDismissNotification;

typedef NS_ENUM(NSInteger, DCPopViewButtonType) {
    DCPopViewButtonTypeDefault = 0,
    DCPopViewButtonTypeDestructive,
    DCPopViewButtonTypeCancel
};

typedef NS_ENUM(NSInteger, DCPopViewBackgroundStyle) {
    DCPopViewBackgroundStyleGradient = 0,
    DCPopViewBackgroundStyleSolid,
};

typedef NS_ENUM(NSInteger, DCPopViewTransitionStyle) {
    DCPopViewTransitionStyleSlideFromBottom = 0,
    DCPopViewTransitionStyleSlideFromTop,
    DCPopViewTransitionStyleFade,
    DCPopViewTransitionStyleBounce,
    DCPopViewTransitionStyleDropDown
};

@class DCPopView;
typedef void(^DCPopViewViewHandler)(DCPopView *popView);
typedef void(^DCPopViewContentViewHandler)(UIView *contentView);
@interface DCPopView : UIView
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;

@property (nonatomic, assign) DCPopViewTransitionStyle transitionStyle; // default is SIAlertViewTransitionStyleSlideFromBottom
@property (nonatomic, assign) DCPopViewBackgroundStyle backgroundStyle; // default is SIAlertViewButtonTypeGradient

@property (nonatomic, copy) DCPopViewViewHandler willShowHandler;
@property (nonatomic, copy) DCPopViewViewHandler didShowHandler;
@property (nonatomic, copy) DCPopViewViewHandler willDismissHandler;
@property (nonatomic, copy) DCPopViewViewHandler didDismissHandler;
@property (nonatomic, copy) DCPopViewContentViewHandler setupContentView;

@property (nonatomic, readonly, getter = isVisible) BOOL visible;

@property (nonatomic, strong) UIColor *viewBackgroundColor NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *titleColor NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *messageColor NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *titleFont NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *messageFont NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *buttonFont NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat cornerRadius NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR; // default is 2.0
@property (nonatomic, assign) CGFloat shadowRadius NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR; // default is 8.0

- (id)initWithTitle:(NSString *)title;
- (id)initWithTitle:(NSString *)title size:(CGSize)size;
- (void)handleContentView:(DCPopViewContentViewHandler)action;
- (void)show;
- (void)dismissAnimated:(BOOL)animated;
@end
