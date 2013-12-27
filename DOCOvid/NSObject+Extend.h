//
//  NSObject+Extend.h
//  DOCOvid
//
//  Created by 91aiche on 13-12-26.
//  Copyright (c) 2013年 amor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Extend)
static inline double radians (double degrees);
UIImage* rotate(UIImage* src, UIImageOrientation orientation);
+ (float)iOSVersion;
+(NSString*)translate:(CGFloat)lat1 :(CGFloat)lon1 :(CGFloat)lat2 :(CGFloat)lon2;
@end
