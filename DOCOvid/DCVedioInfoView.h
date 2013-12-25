//
//  DCVedioInfoView.h
//  DOCOVedio
//
//  Created by amor on 13-12-12.
//  Copyright (c) 2013年 amor. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, VedioInfoViewType) {
    VedioInfoViewTypeLast = 0,
    VedioInfoViewTypeNews
};

@interface DCVedioInfoView : UIView
@property (nonatomic,strong)NSDictionary *dictory;
@property (nonatomic, assign) VedioInfoViewType infoViewStyle; // default is MovieInfoControllerTypeLast
- (void)revalInfo;
@end
