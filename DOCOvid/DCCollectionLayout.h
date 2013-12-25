//
//  CircleLayout.h
//  DOCOVedio
//
//  Created by 91aiche on 13-11-14.
//  Copyright (c) 2013年 amor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCCollectionLayout : UICollectionViewFlowLayout
@property (nonatomic, assign) CGPoint center;
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) NSInteger cellCount;
@property (nonatomic, assign) NSInteger perLine;

@end
