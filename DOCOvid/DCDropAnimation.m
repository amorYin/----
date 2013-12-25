//
//  DCDropAnimation.m
//  DOCOVedio
//
//  Created by amor on 13-12-18.
//  Copyright (c) 2013年 amor. All rights reserved.
//

#import "DCDropAnimation.h"
#import "RKTabItem.h"
NSString *const DCDropAnimationDownloadFinishNotification = @"DCDropAnimationDownloadFinishNotification";
NSString *const DCDropAnimationDownloadReDropNotification = @"DCDropAnimationDownloadReDropNotification";
NSString *const DCDropAnimationCellectFinishNotification = @"DCDropAnimationCellectFinishNotification";
NSString *const DCDropAnimationCellectReDropNotification = @"DCDropAnimationCellectReDropNotification";

static DCDropAnimation *_dropAnimation;
@interface DCDropAnimation()
{
    UIButton *object;
    CGRect target;
    RKTabItem *targetBar;
    NSInteger newbadge;
    DCDropAnimationType _droptype;
}
@end

@implementation DCDropAnimation

+ (void)animationDeDropWith:(UIButton*)obj type:(DCDropAnimationType)type
{
    switch (type) {
        case DCDropAnimationDownload:
        {
                [[NSNotificationCenter defaultCenter] postNotificationName:DCDropAnimationDownloadReDropNotification object:nil];
        }
            break;
        case DCDropAnimationCollect:
        {
                [[NSNotificationCenter defaultCenter] postNotificationName:DCDropAnimationCellectReDropNotification object:nil];
        }
            break;
        default:
            break;
    }
}

+ (void)animationDropWith:(UIButton*)obj  type:(DCDropAnimationType)type
{
    if (!_dropAnimation) {
        _dropAnimation = [[DCDropAnimation alloc] init];
    }
    _dropAnimation->object = obj;
    _dropAnimation->_droptype = type;
    [_dropAnimation addDropAnimation:_dropAnimation->object];
}

+ (void)animationFinishWith:(RKTabItem*)obj badge:(NSInteger)new
{
    if (!_dropAnimation) {
        _dropAnimation = [[DCDropAnimation alloc] init];
    }
    _dropAnimation->targetBar = obj;
    _dropAnimation->newbadge = new;
    [_dropAnimation addShopFinished:_dropAnimation->newbadge];
}
//加入动画
- (void)addDropAnimation:(UIButton*)obj{
    //加入动画效果
    CALayer *transitionLayer = [[CALayer alloc] init];
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    transitionLayer.opacity = 1.0;
    transitionLayer.contents = (id)([obj imageForState:UIControlStateHighlighted].CGImage);
    transitionLayer.frame = [[UIApplication sharedApplication].keyWindow convertRect:obj.bounds fromView:obj];
    [[UIApplication sharedApplication].keyWindow.layer addSublayer:transitionLayer];
    [CATransaction commit];
    
    //路径曲线
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:transitionLayer.position];
    
    switch (_droptype) {
        case DCDropAnimationDownload:
        {
            if ([[UIApplication sharedApplication] statusBarOrientation]==UIInterfaceOrientationLandscapeLeft)
            {
                CGPoint toPoint = CGPointMake(712, 362);
                [movePath addQuadCurveToPoint:toPoint
                                 controlPoint:CGPointMake(transitionLayer.position.x-200,transitionLayer.position.y-200)];
            }else{
                CGPoint toPoint = CGPointMake(60, 652);
                [movePath addQuadCurveToPoint:toPoint
                                 controlPoint:CGPointMake(transitionLayer.position.x+200,transitionLayer.position.y+200)];
            }
        }
            break;
        case DCDropAnimationCollect:
        {
            if ([[UIApplication sharedApplication] statusBarOrientation]==UIInterfaceOrientationLandscapeLeft)
            {
                CGPoint toPoint = CGPointMake(712, 466);
                [movePath addQuadCurveToPoint:toPoint
                                 controlPoint:CGPointMake(transitionLayer.position.x-200,transitionLayer.position.y-200)];
            }else{
                CGPoint toPoint = CGPointMake(60, 562);
                [movePath addQuadCurveToPoint:toPoint
                                 controlPoint:CGPointMake(transitionLayer.position.x+200,transitionLayer.position.y+200)];
            }
        }
            break;
        default:
            break;
    }

    //关键帧
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimation.path = movePath.CGPath;
    positionAnimation.removedOnCompletion = YES;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.beginTime = CACurrentMediaTime();
    group.duration = 0.7;
    group.animations = [NSArray arrayWithObjects:positionAnimation,nil];
    group.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    group.delegate = self;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    group.autoreverses= NO;
    
    [transitionLayer addAnimation:group forKey:@"frame"];
    [self performSelector:@selector(notificationStopFinish:) withObject:transitionLayer afterDelay:0.5f];
}

- (void)notificationStopFinish:(CALayer*)transitionLayer{
    transitionLayer.opacity = 0;
    switch (_droptype) {
        case DCDropAnimationDownload:
        {
                [[NSNotificationCenter defaultCenter] postNotificationName:DCDropAnimationDownloadFinishNotification object:nil];
        }
            break;
        case DCDropAnimationCollect:
        {
                [[NSNotificationCenter defaultCenter] postNotificationName:DCDropAnimationCellectFinishNotification object:nil];
        }
            break;
        default:
            break;
    }
}

//加入购物车 步骤2
- (void)addShopFinished:(NSInteger)new{
        targetBar.badgeValue = new;
    
//        CALayer *transitionLayer1 = [[CALayer alloc] init];
//        
//        CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
//        opacityAnimation.fromValue = [NSNumber numberWithFloat:1.0];
//        opacityAnimation.toValue = [NSNumber numberWithFloat:0];
//        
//        CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
//        rotateAnimation.fromValue = [NSNumber numberWithFloat:0 * M_PI];
//        rotateAnimation.toValue = [NSNumber numberWithFloat:2 * M_PI];
//        
//        CAAnimationGroup *group = [CAAnimationGroup animation];
//        group.beginTime = CACurrentMediaTime();
//        group.duration = 0.3;
//        group.animations = [NSArray arrayWithObjects:opacityAnimation,nil];
//        group.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//        group.delegate = self;
//        group.fillMode = kCAFillModeForwards;
//        group.removedOnCompletion = NO;
//        group.autoreverses= NO;
//        [transitionLayer1 addAnimation:group forKey:@"opacity"];
}
@end
