//
//  DCMPMoviePlayerView.h
//  DOCOVedio
//
//  Created by amor on 13-11-24.
//  Copyright (c) 2013年 amor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
@interface DCMPMoviePlayerView : UIViewController
@property (nonatomic,strong) NSDictionary *dataDic;
@property (nonatomic,strong) UIImage *img;
- (void)stopMovie;
- (void)playMovie;
- (void)playURLString:(NSString*)url;
@end
