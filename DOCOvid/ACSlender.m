//
//  ACSlender.m
//  aiche
//
//  Created by 91aiche on 13-6-26.
//  Copyright (c) 2013年 droudrou. All rights reserved.
//

#import "ACSlender.h"

#pragma mark - slender_button_layer
typedef enum {
    YZSSbtnLayerBacks,
    YZSSbtnLayerCovers,
    YZSSbtnLayerLabels
} slender_button_layer_Group;

@interface slender_button_layer: CALayer
- (CALayer*)bgLayers;
- (CALayer*)coverLayers;
- (CALayer*)lableLayers;
- (void)removeAllSelfLayers;
@end
@implementation slender_button_layer

- (id)init
{
    self = [super init];
    if (self) {
        [self setContentsScale:[[UIScreen mainScreen] scale]];
        [self addSublayer:[CALayer layer]]; // YZSSbtnLayerBacks
        [self addSublayer:[CALayer layer]]; // YZSSbtnLayerCovers
        [self addSublayer:[CALayer layer]]; // YZSSbtnLayerLabels
        
        [[self sublayers] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [obj setContentsScale:[[UIScreen mainScreen] scale]];
        }];
        
    }
    return self;
}

- (CALayer*)bgLayers
{
    return [[self sublayers] objectAtIndex:YZSSbtnLayerBacks];
}

- (CALayer*)coverLayers
{
    return [[self sublayers] objectAtIndex:YZSSbtnLayerCovers];
}

- (CALayer*)lableLayers
{
    return [[self sublayers] objectAtIndex:YZSSbtnLayerLabels];
}

- (void)removeAllSelfLayers
{
    {
        NSArray *layers = [NSArray arrayWithArray:[[self bgLayers] sublayers]];
        [layers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [obj removeFromSuperlayer];
        }];
    }
    
    {
        NSArray *layers = [NSArray arrayWithArray:[[self coverLayers] sublayers]];
        [layers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [obj removeFromSuperlayer];
        }];
    }
    
    {
        NSArray *layers = [NSArray arrayWithArray:[[self lableLayers] sublayers]];
        [layers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [obj removeFromSuperlayer];
        }];
    }
}
@end

@implementation slender_button
@synthesize delegate=_delegate;
@synthesize titles=_titles;
@synthesize hilightColor=_hilightColor;
@synthesize nomalColor=_nomalColor;
@synthesize selectBgImg=_selectBgImg;
@synthesize nomalBgImg=_nomalBgImg;
@synthesize bgImg=_bgImg;
@synthesize nomalSelectIndex=_nomalSelectIndex;

+(Class)layerClass
{
    return [slender_button_layer class];
}

- (id)initWithFrame:(CGRect)frame action:(id<slender_button_delegate>)dele
{
    self = [super initWithFrame:frame];
    if (self) {
        //NOTE : last textlayer
        _delegate = dele;
        _nomalSelectIndex = 0;
        _nomalColor = [UIColor darkGrayColor].CGColor;
        _hilightColor = [UIColor whiteColor].CGColor;
        self.backgroundColor = [UIColor clearColor];
//        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"CYJL_PH_WX.png"]];
    }
    return self;
}

- (void)setBgImg:(UIImage *)bgImg
{
    slender_button_layer *slender_layer = (slender_button_layer*)[self layer];
    [[slender_layer bgLayers] setBounds:self.bounds];
    [[slender_layer bgLayers] setAnchorPoint:CGPointMake(0, 0)];
    [[slender_layer bgLayers] setContents:(__bridge id)bgImg.CGImage];
    _bgImg = bgImg;
}

- (void)setup
{
    slender_button_layer *slender_layer = (slender_button_layer*)[self layer];
    [slender_layer removeAllSelfLayers];
    //NOTE : set backgroud
    
       //NOTE : set scroller
//    if (!_selectBgImg) {
//        _selectBgImg = [UIImage imageNamed:@"custom_center.png"];
//    }
    
    //NOTE : set lable
    if (!_titles) {
        _titles = [NSArray arrayWithObjects:@"油“斯基”",@"勤“斯基”",@"全能“斯基”", nil];
    }
    
    // bgcolor
#ifndef    APP_VERSION_REDIOM_1_3
    //total count
    int count = _titles.count;
#else
    //total count
    int count = (_titles.count<2)?2:_titles.count;
#endif
    
    CGFloat perW = self.width/count;
    
    for (int i=0; i<_titles.count; i++) {
        CAShapeLayer *layer = [CAShapeLayer layer];
        [layer setContentsScale:[[UIScreen mainScreen] scale]];
        [layer setAnchorPoint:CGPointMake(0, 0)];
        [layer setFrame:CGRectMake(perW*i, 0, perW, self.height)];
        [[slender_layer bgLayers] addSublayer:layer];
        if (i!=0) {
            [layer setContents:(__bridge id)_nomalBgImg.CGImage];
        }
    }
    
    //cover layer
    CALayer *layer = [CALayer layer];
    [layer setContentsScale:[[UIScreen mainScreen] scale]];
    //
    CGFloat w = CGImageGetWidth(_selectBgImg.CGImage);
    CGFloat h = CGImageGetHeight(_selectBgImg.CGImage);
    [layer setContents:(__bridge id)_selectBgImg.CGImage];
    [layer setBounds:
     CGRectMake(0, 0, w,h)]; 
    [layer setPosition:CGPointMake(self.width*(0.5)/_titles.count, self.height/2-13)];
    [[slender_layer coverLayers] addSublayer:layer];
    
    [_titles enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CATextLayer *textLayer = [CATextLayer layer];
        [textLayer setContentsScale:[[UIScreen mainScreen] scale]];
        CGFontRef font = CGFontCreateWithFontName((__bridge CFStringRef) [[UIFont boldSystemFontOfSize:16.0] fontName]);
        [textLayer setFont:font];
        CFRelease(font);
        [textLayer setFontSize:16.0];
        if (idx==_nomalSelectIndex)
            [textLayer setForegroundColor:_hilightColor];
        else
            [textLayer setForegroundColor:_nomalColor];
        
        [textLayer setAnchorPoint:CGPointMake(0.5, 0.5)];
        [textLayer setAlignmentMode:kCAAlignmentCenter];
        CGSize size = [(NSString*)obj sizeWithFont:[UIFont boldSystemFontOfSize:16.0]];
        [textLayer setBounds:CGRectMake(0.0, 0.0, size.width, size.height)];
        [textLayer setPosition:CGPointMake(self.width*(idx+0.5)/count, self.height/2)];
        [textLayer setString:(NSString*)obj];
        [[slender_layer lableLayers] addSublayer:textLayer];
    }];
    
    [_delegate slender_button_select:_nomalSelectIndex];
}

- (void)drawRect:(CGRect)rect
{
    [self setup];
}

- (void)scrollToIndex:(NSInteger)index
{
    slender_button_layer *slender_layer = (slender_button_layer*)[self layer];
    index = index>(_titles.count-1)?(_titles.count-1):index;
    
    [(CATextLayer*)[[[slender_layer lableLayers] sublayers]
                    objectAtIndex:_nomalSelectIndex]
     setForegroundColor:_nomalColor];
    
    //reuse bg
    [(CAShapeLayer*)[[[slender_layer bgLayers] sublayers]
                    objectAtIndex:_nomalSelectIndex]
     setContents:(__bridge id)_nomalBgImg.CGImage];
    
    [(CATextLayer*)[[[slender_layer lableLayers] sublayers]
                    objectAtIndex:index]
     setForegroundColor:_hilightColor];
    
    //clear bg
    [(CAShapeLayer*)[[[slender_layer bgLayers] sublayers]
                    objectAtIndex:index]
     setContents:nil];
    
    _nomalSelectIndex = index;
    
    [[[slender_layer coverLayers] sublayers] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [(CALayer*)obj setPosition:CGPointMake(self.width*(_nomalSelectIndex+0.5)/_titles.count, self.height/2-13)];
        
//        UIImage* bgImge = [_delegate slender_button_bgimageAt:_nomalSelectIndex];
//        
//        CGFloat w = CGImageGetWidth(bgImge.CGImage)*0.5;
//        CGFloat h = CGImageGetHeight(_selectBgImg.CGImage)*0.5;
//        
//        CGFloat margin = self.width*(_nomalSelectIndex+0.5)/_titles.count;
//        if (_nomalSelectIndex==0) {
//            margin = w*0.5;
//        }else if (_nomalSelectIndex==_titles.count-1){
//            margin = self.width-w*0.5;
//        }
//        
//        [(CALayer*)obj setBounds:CGRectMake(0, 0, w,h)];
//        [(CALayer*)obj setPosition:CGPointMake(margin, self.height/2)];
//        [(CALayer*)obj setContents:(__bridge id)bgImge.CGImage];
        
    }];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    
    slender_button_layer *slender_layer = (slender_button_layer*)[self layer];
    
    [(CATextLayer*)[[[slender_layer lableLayers] sublayers]
                    objectAtIndex:_nomalSelectIndex]
     setForegroundColor:_nomalColor];
    
    //reuse bg
    [(CAShapeLayer*)[[[slender_layer bgLayers] sublayers]
                    objectAtIndex:_nomalSelectIndex]
     setContents:(__bridge id)_nomalBgImg.CGImage];
    
    [(CATextLayer*)[[[slender_layer lableLayers] sublayers]
                    objectAtIndex:floor(p.x*_titles.count/self.width)]
     setForegroundColor:_hilightColor];
    //clear bg
    [(CAShapeLayer*)[[[slender_layer bgLayers] sublayers]
                    objectAtIndex:floor(p.x*_titles.count/self.width)]
     setContents:nil];

    _nomalSelectIndex = floor(p.x*_titles.count/self.width);
    [_delegate slender_button_select:_nomalSelectIndex];
    [[[slender_layer coverLayers] sublayers] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [(CALayer*)obj setPosition:CGPointMake(self.width*(floor(p.x*_titles.count/self.width)+0.5)/_titles.count, self.height/2-13)];
        
//        UIImage* bgImge = [_delegate slender_button_bgimageAt:_nomalSelectIndex];
//        
//        CGFloat w = CGImageGetWidth(bgImge.CGImage)*0.5;
//        CGFloat h = CGImageGetHeight(_selectBgImg.CGImage)*0.5;
//        
//        CGFloat margin = self.width*(_nomalSelectIndex+0.5)/_titles.count;
//        if (_nomalSelectIndex==0) {
//            margin = w*0.5;
//        }else if (_nomalSelectIndex==_titles.count-1){
//            margin = self.width-w*0.5;
//        }
//        
//        [(CALayer*)obj setBounds:CGRectMake(0, 0, w,h)];
//        [(CALayer*)obj setPosition:CGPointMake(margin, self.height/2)];
//        [(CALayer*)obj setContents:(__bridge id)bgImge.CGImage];

    }];
}
@end
