//
//  NSObject+Extend.m
//  DOCOvid
//
//  Created by 91aiche on 13-12-26.
//  Copyright (c) 2013年 amor. All rights reserved.
//

#import "NSObject+Extend.h"

@implementation NSObject (Extend)
+ (float)iOSVersion {
    static float version = 0.f;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        version = [[[UIDevice currentDevice] systemVersion] floatValue];
    });
    return version;
}

+(NSString*)translate:(CGFloat)lat1 :(CGFloat)lon1 :(CGFloat)lat2 :(CGFloat)lon2
{
    CGFloat rg1 = (lat1-lat2)*M_PI/180;
    CGFloat rg2 = (lon1-lon2)*M_PI/180;
    
    CGFloat s = 2 * asin(sqrt(powf(sin(rg1 / 2), 2) +
                              cos(lat1*M_PI/180) * cos(lat2*M_PI/180) *
                              powf(sin(rg2 / 2), 2)));
    
    s        = s * 6378.137;
    s        = round(s * 100000) / 100000;
    //    s        = s * 1000;
    NSString *sl = [NSString stringWithFormat:@"%f",s];
    return sl;
}

static inline double radians (double degrees) {return degrees * M_PI/180;}

UIImage* rotate(UIImage* src, UIImageOrientation orientation)
{
    UIGraphicsBeginImageContext(src.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orientation == UIImageOrientationRight) {
        CGContextRotateCTM (context, radians(90));
    } else if (orientation == UIImageOrientationLeft) {
        CGContextRotateCTM (context, radians(-90));
    } else if (orientation == UIImageOrientationDown) {
        // NOTHING
    } else if (orientation == UIImageOrientationUp) {
        CGContextRotateCTM (context, radians(90));
    }
    
    [src drawAtPoint:CGPointMake(0, 0)];
    
    return UIGraphicsGetImageFromCurrentImageContext();
}
@end
