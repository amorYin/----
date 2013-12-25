//
//  DCMovieInfoController.m
//  DOCOVedio
//
//  Created by amor on 13-12-16.
//  Copyright (c) 2013年 amor. All rights reserved.
//

#import "DCMovieInfoController.h"

@interface DCMovieInfoController ()
{
    UIImageView *_imageView;
}
@end

@implementation DCMovieInfoController

#pragma mark -
- (void)loadAction
{
    switch (self.controllerStyle) {
        case MovieInfoControllerTypeLast:
        {
            //uibutton
            UIButton *play = [[UIButton alloc] initWithFrame:CGRectMake(506, 275, 115, 115)];
            [play setImage:[UIImage imageNamed:@"play_action_btn_n"] forState:UIControlStateNormal];
            [play setImage:[UIImage imageNamed:@"play_action_btn_h"] forState:UIControlStateSelected];
            [play setImage:[UIImage imageNamed:@"play_action_btn_h"] forState:UIControlStateHighlighted];
            [play addTarget:_actionDelegate action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:play];
            
            //uibutton
            UIButton *download = [[UIButton alloc] initWithFrame:CGRectMake(730, 275, 115, 115)];
            [download setImage:[UIImage imageNamed:@"sy_download_btn_n"] forState:UIControlStateNormal];
            [download setImage:[UIImage imageNamed:@"sy_download_btn_h"] forState:UIControlStateSelected];
            [download setImage:[UIImage imageNamed:@"sy_download_btn_h"] forState:UIControlStateHighlighted];
            [download addTarget:_actionDelegate action:@selector(download:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:download];
        }
            break;
        case MovieInfoControllerTypeNews:
            break;
        default:
            break;
    }
    
}

- (void)setImg:(UIImage *)img
{
    _img = nil;
    _img = img;
    
    _imageView.image = _img;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.controllerStyle = MovieInfoControllerTypeLast;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.height, self.view.width)];
        [self.view addSubview:_imageView];
    }

    [self performSelector:@selector(loadAction) withObject:nil afterDelay:0.1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
