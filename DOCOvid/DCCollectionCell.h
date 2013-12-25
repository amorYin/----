//
//  DCCollectionCell.h
//  DOCOVedio
//
//  Created by 91aiche on 13-11-14.
//  Copyright (c) 2013年 amor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCCollectionCell : UICollectionViewCell
@property (DD_STRONG, nonatomic)  UIImageView *delete_tag;
@property (DD_STRONG, nonatomic)  UIImageView *imageView;
@property (DD_STRONG, nonatomic)  UILabel *titleLal;
@property (DD_STRONG, nonatomic)  UILabel *deslal;
@property (assign,nonatomic)BOOL hiddenBgImge;
-(void)setImage:(UIImage *)image;
@end
