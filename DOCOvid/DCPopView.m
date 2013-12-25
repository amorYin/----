//
//  DCPopView.m
//  DOCOVedio
//
//  Created by amor on 13-12-17.
//  Copyright (c) 2013年 amor. All rights reserved.
//

#import "DCPopView.h"
#import <QuartzCore/QuartzCore.h>
#define  CONTAINER_WIDTH 380
#define  TITLE_HEIGHT  50
#define  CONTENT_PADDING_TOP 0
#define  CONTENT_PADDING_LEFT 10
#define  GAP 10
NSString *const DCPopViewWillShowNotification = @"DCPopViewWillShowNotification";
NSString *const DCPopViewDidShowNotification = @"DCPopViewDidShowNotification";
NSString *const DCPopViewWillDismissNotification = @"DCPopViewWillDismissNotification";
NSString *const DCPopViewDidDismissNotification = @"DCPopViewDidDismissNotification";


const UIWindowLevel UIWindowLevelDCPopView = 1999.0;  // don't overlap system's alert
const UIWindowLevel UIWindowLevelDCPopViewBackground = 1998.0; // below the alert window

@class DCPopViewBackgroundWindow;
static NSMutableArray *__si_alert_queue;
static BOOL __si_alert_animating;
static DCPopViewBackgroundWindow *__si_alert_background_window;
static DCPopView *__si_alert_current_view;

@interface DCPopView ()

@property (nonatomic, assign ,getter = getSize) CGSize dcSize;
@property (nonatomic, strong) UIWindow *alertWindow;
@property (nonatomic, assign, getter = isVisible) BOOL visible;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIButton *cancleBtn;
@property (nonatomic, strong) UIImageView *containerView;

@property (nonatomic, assign, getter = isLayoutDirty) BOOL layoutDirty;

+ (NSMutableArray *)sharedQueue;
+ (DCPopView *)currentDCPopView;

+ (BOOL)isAnimating;
+ (void)setAnimating:(BOOL)animating;

+ (void)showBackground;
+ (void)hideBackgroundAnimated:(BOOL)animated;

- (void)setup;
- (void)invaliadateLayout;
- (void)resetTransition;

- (void) cancleAction:(id)sender;

@end

#pragma mark - DCPopViewBackgroundWindow

@interface DCPopViewBackgroundWindow : UIWindow

@end

@interface DCPopViewBackgroundWindow ()

@property (nonatomic, assign) DCPopViewBackgroundStyle style;

@end

@implementation DCPopViewBackgroundWindow

- (id)initWithFrame:(CGRect)frame andStyle:(DCPopViewBackgroundStyle)style
{
    self = [super initWithFrame:frame];
    if (self) {
        self.style = style;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.opaque = NO;
        self.windowLevel = UIWindowLevelDCPopViewBackground;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    switch (self.style) {
        case DCPopViewBackgroundStyleGradient:
        {
            size_t locationsCount = 2;
            CGFloat locations[2] = {0.0f, 1.0f};
            CGFloat colors[8] = {0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.75f};
            CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
            CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, colors, locations, locationsCount);
            CGColorSpaceRelease(colorSpace);
            
            CGPoint center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
            CGFloat radius = MIN(self.bounds.size.width, self.bounds.size.height) ;
            CGContextDrawRadialGradient (context, gradient, center, 0, center, radius, kCGGradientDrawsAfterEndLocation);
            CGGradientRelease(gradient);
            break;
        }
        case DCPopViewBackgroundStyleSolid:
        {
            [[UIColor colorWithWhite:0 alpha:0.5] set];
            CGContextFillRect(context, self.bounds);
            break;
        }
    }
}

@end


#pragma mark - SIAlertViewController

@interface DCPopViewController : UIViewController

@property (nonatomic, strong) DCPopView *popView;

@end

@implementation DCPopViewController

#pragma mark - View life cycle

- (void)loadView
{
    self.view = self.popView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.popView setup];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self.popView resetTransition];
    [self.popView invaliadateLayout];
}

@end

#pragma mark - DCPopView
@implementation DCPopView
#pragma mark - default
- (void)setDefault
{
    self.viewBackgroundColor = [UIColor clearColor];
    self.titleColor = [UIColor whiteColor];
    self.messageColor = [UIColor whiteColor];
    self.titleFont = [UIFont boldSystemFontOfSize:20];
    self.messageFont = [UIFont systemFontOfSize:16];
    self.buttonFont = [UIFont systemFontOfSize:[UIFont buttonFontSize]];
    self.cornerRadius = 2;
    self.shadowRadius = 8;
}

+ (void)initialize
{
    if (self != [DCPopView class])
        return;
    
    DCPopView *appearance = [self appearance];
    appearance.viewBackgroundColor = [UIColor clearColor];
    appearance.titleColor = [UIColor whiteColor];
    appearance.messageColor = [UIColor whiteColor];
    appearance.titleFont = [UIFont boldSystemFontOfSize:20];
    appearance.messageFont = [UIFont systemFontOfSize:16];
    appearance.buttonFont = [UIFont systemFontOfSize:[UIFont buttonFontSize]];
    appearance.cornerRadius = 2;
    appearance.shadowRadius = 8;
}

- (id)init
{
	return [self initWithTitle:nil];
}

- (id)initWithTitle:(NSString *)title{
    self = [super init];
	if (self) {
		_title = title;
        _dcSize = CGSizeZero;
        [self setDefault];
	}
	return self;
}

- (id)initWithTitle:(NSString *)title size:(CGSize)size
{
    self = [super init];
	if (self) {
		_title = title;
        _dcSize = size;
        [self setDefault];
	}
	return self;
}

#pragma mark - Class methods

+ (NSMutableArray *)sharedQueue
{
    if (!__si_alert_queue) {
        __si_alert_queue = [NSMutableArray array];
    }
    return __si_alert_queue;
}

+ (DCPopView *)currentDCPopView
{
    return __si_alert_current_view;
}

+ (void)setCurrentDCPopView:(DCPopView *)popView
{
    __si_alert_current_view = popView;
}

+ (BOOL)isAnimating
{
    return __si_alert_animating;
}

+ (void)setAnimating:(BOOL)animating
{
    __si_alert_animating = animating;
}

+ (void)showBackground
{
    if (!__si_alert_background_window) {
        __si_alert_background_window = [[DCPopViewBackgroundWindow alloc] initWithFrame:[UIScreen mainScreen].bounds
                                                                             andStyle:[DCPopView currentDCPopView].backgroundStyle];
        [__si_alert_background_window makeKeyAndVisible];
        __si_alert_background_window.alpha = 0;
        [UIView animateWithDuration:0.3
                         animations:^{
                             __si_alert_background_window.alpha = 1;
                         }];
    }
}

+ (void)hideBackgroundAnimated:(BOOL)animated
{
    if (!animated) {
        [__si_alert_background_window removeFromSuperview];
        __si_alert_background_window = nil;
        return;
    }
    [UIView animateWithDuration:0.3
                     animations:^{
                         __si_alert_background_window.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         [__si_alert_background_window removeFromSuperview];
                         __si_alert_background_window = nil;
                     }];
}

#pragma mark - Setters

- (void)setTitle:(NSString *)title
{
    _title = title;
	[self invaliadateLayout];
}

- (void)handleContentView:(DCPopViewContentViewHandler)action
{
    self.setupContentView = action;
}

#pragma mark - Annimation
- (void)show
{
    if (![[DCPopView sharedQueue] containsObject:self]) {
        [[DCPopView sharedQueue] addObject:self];
    }
    
    if ([DCPopView isAnimating]) {
        return; // wait for next turn
    }
    
    if (self.isVisible) {
        return;
    }
    
    if ([DCPopView currentDCPopView].isVisible) {
        DCPopView *alert = [DCPopView currentDCPopView];
        [alert dismissAnimated:YES cleanup:NO];
        return;
    }
    
    if (self.willShowHandler) {
        self.willShowHandler(self);
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:DCPopViewWillShowNotification object:self userInfo:nil];
    
    self.visible = YES;
    
    [DCPopView setAnimating:YES];
    [DCPopView setCurrentDCPopView:self];
    
    // transition background
    [DCPopView showBackground];
    
    DCPopViewController *viewController = [[DCPopViewController alloc] initWithNibName:nil bundle:nil];
    viewController.popView = self;
    
    if (!self.alertWindow) {
        UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        window.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        window.opaque = NO;
        window.windowLevel = UIWindowLevelDCPopView;
        window.rootViewController = viewController;
        self.alertWindow = window;
    }
    [self.alertWindow makeKeyAndVisible];
    
    [self validateLayout];
    
    [self transitionInCompletion:^{
        if (self.didShowHandler) {
            self.didShowHandler(self);
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:DCPopViewDidShowNotification object:self userInfo:nil];
        
        [DCPopView setAnimating:NO];
        
        NSInteger index = [[DCPopView sharedQueue] indexOfObject:self];
        if (index < [DCPopView sharedQueue].count - 1) {
            [self dismissAnimated:YES cleanup:NO]; // dismiss to show next alert view
        }
    }];
}

- (void)dismissAnimated:(BOOL)animated
{
    [self dismissAnimated:animated cleanup:YES];
}

- (void)dismissAnimated:(BOOL)animated cleanup:(BOOL)cleanup
{
    BOOL isVisible = self.isVisible;
    
    if (isVisible) {
        if (self.willDismissHandler) {
            self.willDismissHandler(self);
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:DCPopViewWillDismissNotification object:self userInfo:nil];
    }
    
    void (^dismissComplete)(void) = ^{
        self.visible = NO;
        
        [self teardown];
        
        [DCPopView setCurrentDCPopView:nil];
        
        DCPopView *nextAlertView;
        NSInteger index = [[DCPopView sharedQueue] indexOfObject:self];
        if (index != NSNotFound && index < [DCPopView sharedQueue].count - 1) {
            nextAlertView = [DCPopView sharedQueue][index + 1];
        }
        
        if (cleanup) {
            [[DCPopView sharedQueue] removeObject:self];
        }
        
        [DCPopView setAnimating:NO];
        
        if (isVisible) {
            if (self.didDismissHandler) {
                self.didDismissHandler(self);
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:DCPopViewDidDismissNotification object:self userInfo:nil];
        }
        
        // check if we should show next alert
        if (!isVisible) {
            return;
        }
        
        if (nextAlertView) {
            [nextAlertView show];
        } else {
            // show last alert view
            if ([DCPopView sharedQueue].count > 0) {
                DCPopView *alert = [[DCPopView sharedQueue] lastObject];
                [alert show];
            }
        }
    };
    
    if (animated && isVisible) {
        [DCPopView setAnimating:YES];
        [self transitionOutCompletion:dismissComplete];
        
        if ([DCPopView sharedQueue].count == 1) {
            [DCPopView hideBackgroundAnimated:YES];
        }
        
    } else {
        dismissComplete();
        
        if ([DCPopView sharedQueue].count == 0) {
            [DCPopView hideBackgroundAnimated:YES];
        }
    }
}

#pragma mark - Transitions

- (void)transitionInCompletion:(void(^)(void))completion
{
    switch (self.transitionStyle) {
        case DCPopViewTransitionStyleSlideFromBottom:
        {
            CGRect rect = self.containerView.frame;
            CGRect originalRect = rect;
            rect.origin.y = self.bounds.size.height;
            self.containerView.frame = rect;
            [UIView animateWithDuration:0.3
                             animations:^{
                                 self.containerView.frame = originalRect;
                             }
                             completion:^(BOOL finished) {
                                 if (completion) {
                                     completion();
                                 }
                             }];
        }
            break;
        case DCPopViewTransitionStyleSlideFromTop:
        {
            CGRect rect = self.containerView.frame;
            CGRect originalRect = rect;
            rect.origin.y = -rect.size.height;
            self.containerView.frame = rect;
            [UIView animateWithDuration:0.3
                             animations:^{
                                 self.containerView.frame = originalRect;
                             }
                             completion:^(BOOL finished) {
                                 if (completion) {
                                     completion();
                                 }
                             }];
        }
            break;
        case DCPopViewTransitionStyleFade:
        {
            self.containerView.alpha = 0;
            [UIView animateWithDuration:0.3
                             animations:^{
                                 self.containerView.alpha = 1;
                             }
                             completion:^(BOOL finished) {
                                 if (completion) {
                                     completion();
                                 }
                             }];
        }
            break;
        case DCPopViewTransitionStyleBounce:
        {
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
            animation.values = @[@(0.01), @(1.2), @(0.9), @(1)];
            animation.keyTimes = @[@(0), @(0.4), @(0.6), @(1)];
            animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
            animation.duration = 0.5;
            animation.delegate = self;
            [animation setValue:completion forKey:@"handler"];
            [self.containerView.layer addAnimation:animation forKey:@"bouce"];
        }
            break;
        case DCPopViewTransitionStyleDropDown:
        {
            CGFloat y = self.containerView.center.y;
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
            animation.values = @[@(y - self.bounds.size.height), @(y + 20), @(y - 10), @(y)];
            animation.keyTimes = @[@(0), @(0.5), @(0.75), @(1)];
            animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
            animation.duration = 0.4;
            animation.delegate = self;
            [animation setValue:completion forKey:@"handler"];
            [self.containerView.layer addAnimation:animation forKey:@"dropdown"];
        }
            break;
        default:
            break;
    }
}

- (void)transitionOutCompletion:(void(^)(void))completion
{
    switch (self.transitionStyle) {
        case DCPopViewTransitionStyleSlideFromBottom:
        {
            CGRect rect = self.containerView.frame;
            rect.origin.y = self.bounds.size.height;
            [UIView animateWithDuration:0.3
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 self.containerView.frame = rect;
                             }
                             completion:^(BOOL finished) {
                                 if (completion) {
                                     completion();
                                 }
                             }];
        }
            break;
        case DCPopViewTransitionStyleSlideFromTop:
        {
            CGRect rect = self.containerView.frame;
            rect.origin.y = -rect.size.height;
            [UIView animateWithDuration:0.3
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 self.containerView.frame = rect;
                             }
                             completion:^(BOOL finished) {
                                 if (completion) {
                                     completion();
                                 }
                             }];
        }
            break;
        case DCPopViewTransitionStyleFade:
        {
            [UIView animateWithDuration:0.25
                             animations:^{
                                 self.containerView.alpha = 0;
                             }
                             completion:^(BOOL finished) {
                                 if (completion) {
                                     completion();
                                 }
                             }];
        }
            break;
        case DCPopViewTransitionStyleBounce:
        {
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
            animation.values = @[@(1), @(1.2), @(0.01)];
            animation.keyTimes = @[@(0), @(0.4), @(1)];
            animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
            animation.duration = 0.35;
            animation.delegate = self;
            [animation setValue:completion forKey:@"handler"];
            [self.containerView.layer addAnimation:animation forKey:@"bounce"];
            
            self.containerView.transform = CGAffineTransformMakeScale(0.01, 0.01);
        }
            break;
        case DCPopViewTransitionStyleDropDown:
        {
            CGPoint point = self.containerView.center;
            point.y += self.bounds.size.height;
            [UIView animateWithDuration:0.3
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 self.containerView.center = point;
                                 CGFloat angle = ((CGFloat)arc4random_uniform(100) - 50.f) / 100.f;
                                 self.containerView.transform = CGAffineTransformMakeRotation(angle);
                             }
                             completion:^(BOOL finished) {
                                 if (completion) {
                                     completion();
                                 }
                             }];
        }
            break;
        default:
            break;
    }
}

- (void)resetTransition
{
    [self.containerView.layer removeAllAnimations];
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self validateLayout];
}

- (void)invaliadateLayout
{
    self.layoutDirty = YES;
    [self setNeedsLayout];
}

- (void)validateLayout
{
    if (!self.isLayoutDirty) {
        return;
    }
    self.layoutDirty = NO;
    CGFloat height = TITLE_HEIGHT;
    CGFloat width = CONTAINER_WIDTH;
    CGFloat left = (self.bounds.size.width - width) * 0.5;
    CGFloat top = (self.bounds.size.height - height) * 0.5;
    CGFloat contentHeight = 0;
    if (!CGSizeEqualToSize(CGSizeZero,_dcSize)) {
        width = _dcSize.width;
        height = _dcSize.height+TITLE_HEIGHT;
        left = (self.bounds.size.width - width) * 0.5;
        top = (self.bounds.size.height - height) * 0.5;
        contentHeight = _dcSize.height;
    }
    
    self.containerView.transform = CGAffineTransformIdentity;
    self.containerView.frame = CGRectMake(left, top, width, height);
//    self.containerView.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.containerView.bounds cornerRadius:self.containerView.layer.cornerRadius].CGPath;
    
    CGFloat y = CONTENT_PADDING_TOP;
	if (self.titleLabel) {
        self.titleLabel.text = self.title;
        self.titleLabel.frame = CGRectMake(CONTENT_PADDING_LEFT, y, self.containerView.bounds.size.width - CONTENT_PADDING_LEFT * 2 , TITLE_HEIGHT);
	}
    
    if (self.cancleBtn) {
        //close btn
        self.cancleBtn.frame = CGRectMake(self.containerView.bounds.size.width - CONTENT_PADDING_LEFT - TITLE_HEIGHT, y, TITLE_HEIGHT, TITLE_HEIGHT);
    }
    
    if (self.contentView) {
        self.contentView.frame = CGRectMake(CONTENT_PADDING_LEFT, TITLE_HEIGHT, self.containerView.bounds.size.width - CONTENT_PADDING_LEFT * 2, contentHeight);
        self.contentView.userInteractionEnabled = YES;
        y += contentHeight;
    }
    
    if (self.setupContentView) {
        self.setupContentView(self.contentView);
    }
}

- (void)updateTitleLabel
{
	if (self.title) {
		if (!self.titleLabel) {
			self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
			self.titleLabel.textAlignment = NSTextAlignmentCenter;
            self.titleLabel.backgroundColor = [UIColor clearColor];
			self.titleLabel.font = self.titleFont;
            self.titleLabel.textColor = self.titleColor;
            self.titleLabel.adjustsFontSizeToFitWidth = YES;
#ifndef __IPHONE_6_0
            self.titleLabel.minimumScaleFactor = 0.75;
#else
            self.titleLabel.minimumFontSize = self.titleLabel.font.pointSize * 0.75;
#endif
			[self.containerView addSubview:self.titleLabel];
		}
		self.titleLabel.text = self.title;
	} else {
		[self.titleLabel removeFromSuperview];
		self.titleLabel = nil;
	}
    [self invaliadateLayout];
}

- (void)updateCancleButton
{
    if (self.title) {
        if (!self.cancleBtn) {
            self.cancleBtn = [[UIButton alloc] initWithFrame:CGRectZero];
            [self.cancleBtn setImage:[UIImage imageNamed:@"pop_cancle_btn_n"] forState:UIControlStateNormal];
            [self.cancleBtn setImage:[UIImage imageNamed:@"pop_cancle_btn_h"] forState:UIControlStateNormal];
            [self.cancleBtn addTarget:self action:@selector(cancleAction:)
                     forControlEvents:UIControlEventTouchUpInside];
            [self.containerView addSubview:self.cancleBtn];
        }
    }
    [self invaliadateLayout];
}

- (void)updateContentView
{
    if (!self.contentView) {
        self.contentView = [[UILabel alloc] initWithFrame:CGRectZero];
        self.contentView.backgroundColor = [UIColor clearColor];
        [self.containerView addSubview:self.contentView];
#if DEBUG_LAYOUT
        self.messageLabel.backgroundColor = [UIColor redColor];
#endif
    }
    [self invaliadateLayout];
}
#pragma mark - Setup

- (void)setup
{
    [self setupContainerView];
    [self updateTitleLabel];
    [self updateContentView];
    [self updateCancleButton];
    [self invaliadateLayout];
}

- (void)teardown
{
    [self.containerView removeFromSuperview];
    self.containerView = nil;
    self.titleLabel = nil;
    [self.alertWindow removeFromSuperview];
    self.alertWindow = nil;
}

- (void)setupContainerView
{
    self.containerView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.containerView.backgroundColor = [UIColor clearColor];
    self.containerView.image = [[UIImage imageNamed:@"pop_bg"] stretchableImageWithLeftCapWidth:200 topCapHeight:140];
    self.containerView.userInteractionEnabled = YES;
    self.containerView.layer.cornerRadius = self.cornerRadius;
    self.containerView.layer.shadowOffset = CGSizeZero;
    self.containerView.layer.shadowRadius = self.shadowRadius;
    self.containerView.layer.shadowOpacity = 0.5;
    [self addSubview:self.containerView];
}
#pragma mark - Action
- (void) cancleAction:(id)sender
{
    [self dismissAnimated:YES];
}
#pragma mark - CAAnimation delegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    void(^completion)(void) = [anim valueForKey:@"handler"];
    if (completion) {
        completion();
    }
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
