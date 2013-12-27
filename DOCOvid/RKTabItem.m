//  Created by Rafael Kayumov (RealPoc).
//  Copyright (c) 2013 Rafael Kayumov. License: MIT.

#import "RKTabItem.h"
@interface RKTabItem ()

@property (readwrite) SEL selector;
@property (nonatomic, assign) id target;

@property (nonatomic, strong) UIImage *imageEnabled;
@property (nonatomic, strong) UIImage *imageDisabled;
@property (readwrite) TabType tabType;
@property (nonatomic, strong) UIImageView *badgeBg;
@property (nonatomic, strong) UILabel *badgeLal;
@end

@implementation RKTabItem
@synthesize badgeValue=_badgeValue;

+ (RKTabItem *)createUsualItemWithImageEnabled:(UIImage *)imageEnabled
                      imageDisabled:(UIImage *)imageDisabled {
    RKTabItem *tabItem = [[RKTabItem alloc] init];
    if (tabItem) {
        tabItem.imageEnabled = imageEnabled;
        tabItem.imageDisabled = imageDisabled;
        tabItem.tabState = TabStateDisabled;
        tabItem.tabType = TabTypeUsual;
    }
    return tabItem;
}

+ (RKTabItem *)createUnexcludableItemWithImageEnabled:(UIImage *)imageEnabled
                             imageDisabled:(UIImage *)imageDisabled {
    RKTabItem *tabItem = [[RKTabItem alloc] init];
    if (tabItem) {
        tabItem.imageEnabled = imageEnabled;
        tabItem.imageDisabled = imageDisabled;
        tabItem.tabState = TabStateDisabled;
        tabItem.tabType = TabTypeUnexcludable;
    }
    return tabItem;
}

+ (RKTabItem *)createButtonItemWithImage:(UIImage *)image
                       target:(id)target
                     selector:(SEL)selector {
    RKTabItem *tabItem = [[RKTabItem alloc] init];
    if (tabItem) {
        tabItem.imageEnabled = image;
        tabItem.tabType = TabTypeButton;
        tabItem.target = target;
        tabItem.selector = selector;
    }
    return tabItem;
}

- (UIImage *)imageEnabled {
    if (!_imageEnabled) {
        _imageEnabled = self.imageDisabled;
    }
    return _imageEnabled;
}

- (UIImage *)imageForCurrentState {
    switch (self.tabState) {
        case TabStateEnabled:
            return self.imageEnabled;
            break;
        case TabStateDisabled:
            return self.imageDisabled;
            break;
        default:
            return nil;
            break;
    }
}

- (void)switchState {
    switch (self.tabState) {
        case TabStateEnabled:
            self.tabState = TabStateDisabled;
            break;
        case TabStateDisabled:
            self.tabState = TabStateEnabled;
            break;
        default:
            return;
            break;
    }
}

- (void)setBadgeValue:(NSInteger)badgeValue
{
    _badgeValue = badgeValue;
    if (!_badgeBg) {
        _badgeBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        _badgeBg.backgroundColor = [UIColor redColor];
        _badgeBg.layer.cornerRadius = 10;
    }
    [self.contentView addSubview:_badgeBg];
    
    if (!_badgeLal) {
         _badgeLal = [[UILabel alloc] initWithFrame:_badgeBg.bounds];
        _badgeLal.font = EuphBold_font(14);
        _badgeLal.backgroundColor = [UIColor clearColor];
        _badgeLal.clipsToBounds = YES;
        _badgeLal.textColor = [UIColor whiteColor];
#if __IPHONE_OS_VERSION_MAX_ALLOWED <= __IPHONE_6_0
        _badgeLal.textAlignment = UITextAlignmentCenter;
#else
        _badgeLal.textAlignment = NSTextAlignmentCenter;
#endif
        [_badgeBg addSubview:_badgeLal];
    }
    
    if (badgeValue==0) {
        _badgeBg.hidden = YES;
    }else{
        _badgeBg.hidden = NO;
        _badgeLal.text = [NSString stringWithFormat:@"%d",badgeValue];
        CGFloat width = badgeValue>99? 32.:(badgeValue>9? 24.: 20.);
        _badgeBg.size = CGSizeMake( width, 20);
        _badgeLal.size = CGSizeMake( width, 20);
        _badgeBg.center = CGPointMake(self.contentView.width-width/2-5, self.contentView.height/2);
    }
}

- (void)updateBadge
{
    [self setBadgeValue:_badgeValue];
}

@end
