//
//  DCDropAnimation.h
//  DOCOVedio
//
//  Created by amor on 13-12-18.
//  Copyright (c) 2013年 amor. All rights reserved.
//

#import <Foundation/Foundation.h>
extern NSString *const DCDropAnimationDownloadFinishNotification;
extern NSString *const DCDropAnimationDownloadReDropNotification;
extern NSString *const DCDropAnimationCellectFinishNotification;
extern NSString *const DCDropAnimationCellectReDropNotification;
@class RKTabItem;
typedef NS_ENUM(NSInteger, DCDropAnimationType) {
    DCDropAnimationDownload = 0,
    DCDropAnimationCollect
};

@interface DCDropAnimation : NSObject
+ (void)animationDeDropWith:(UIButton*)obj type:(DCDropAnimationType)type;
+ (void)animationDropWith:(UIButton*)obj type:(DCDropAnimationType)type;
+ (void)animationFinishWith:(RKTabItem*)obj badge:(NSInteger)newvalue;
@end
