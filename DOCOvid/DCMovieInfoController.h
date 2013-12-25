//
//  DCMovieInfoController.h
//  DOCOVedio
//
//  Created by amor on 13-12-16.
//  Copyright (c) 2013年 amor. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MovieInfoControllerType) {
    MovieInfoControllerTypeLast = 0,
    MovieInfoControllerTypeNews
};

@protocol MovieInfoActionDelegate<NSObject>
@optional
- (void)share:(id)sender;
- (void)play:(id)sender;
- (void)download:(id)sender;
- (void)incommit:(id)sender;
@end
@interface DCMovieInfoController : UIViewController
@property (nonatomic,strong) NSDictionary *dataDic;
@property (nonatomic,strong) UIImage *img;
@property (DD_WEAK,nonatomic)id<MovieInfoActionDelegate> actionDelegate;
@property (nonatomic, assign) MovieInfoControllerType controllerStyle; // default is MovieInfoControllerTypeLast
@end
