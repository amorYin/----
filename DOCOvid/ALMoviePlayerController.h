//
//  ALMoviePlayerController.h
//  ALMoviePlayerController
//
//  Created by Anthony Lobianco on 10/8/13.
//  Copyright (c) 2013 Anthony Lobianco. All rights reserved.
//

#import <MediaPlayer/MPMoviePlayerController.h>
#import "ALMoviePlayerControls.h"

static NSString * const ALMoviePlayerContentURLDidChangeNotification = @"ALMoviePlayerContentURLDidChangeNotification";

@protocol ALMoviePlayerControllerDelegate <NSObject>
@optional
- (void)movieTimedOut;
- (void)moviePrepareToPlay;
- (void)shareVedio;
- (void)downloadVedio;
- (void)collectVedio;
@required
- (void)moviePlayerWillMoveFromWindow;
@end

@interface ALMoviePlayerController : MPMoviePlayerController

- (void)setFrame:(CGRect)frame;
- (id)initWithFrame:(CGRect)frame;
- (void)playHighVedio;
- (void)playLowVedio;
- (void)setTitle:(NSString*)title;
@property (nonatomic, DD_WEAK) id<ALMoviePlayerControllerDelegate> delegate;
@property (nonatomic, strong) ALMoviePlayerControls *controls;
@property (nonatomic, strong) NSString *urlString;

@end
