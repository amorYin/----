//
//  DCMessageView.m
//  DOCOVedio
//
//  Created by amor on 13-12-18.
//  Copyright (c) 2013年 amor. All rights reserved.
//

#import "DCMessageView.h"
#import "DCPopView.h"

@interface DCMessageView()
{
    DCPopView *_popView;
    UITextField *_feild;
    NSString  *_title;
    NSString  *_mesg;
}
@end
@implementation DCMessageView
- (id)initWithTitle:(NSString*)title message:(NSString*)msg
{
    self = [super init];
    if (self) {
        _title = title;
        _mesg = msg;
    }
    return self;
}

- (void) show
{
    if (!_popView) {
        CGSize size = [_mesg sizeWithFont:Euph_font(18.) forWidth:370 lineBreakMode:NSLineBreakByCharWrapping];
        _popView = [[DCPopView alloc] initWithTitle:_title size:CGSizeMake(390, 220)];
        [_popView handleContentView:^(UIView *popView) {
            UILabel *lal = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 370, size.height)];
            lal.text = _mesg;
            lal.backgroundColor = [UIColor clearColor];
            lal.textColor = [UIColor lightTextColor];
            lal.numberOfLines = (int)size.width/360.+1;
#if __IPHONE_OS_VERSION_MAX_ALLOWED <= __IPHONE_6_0
            lal.textAlignment = UITextAlignmentCenter;
#else
            lal.textAlignment = NSTextAlignmentCenter;
#endif
            lal.font = Euph_font(18.);
            [popView addSubview:lal];
        }];
    }
    [_popView show];
}

@end
