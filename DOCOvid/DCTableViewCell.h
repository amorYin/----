//
//  DCTableViewCell.h
//  DOCOVedio
//
//  Created by amor on 13-11-15.
//  Copyright (c) 2013年 amor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCTableViewCell : UITableViewCell
@property (DD_STRONG, nonatomic)  UIImageView *delete_tag;
@property (DD_STRONG, nonatomic)  UILabel *titlelal;
@property (DD_STRONG, nonatomic)  UILabel *timelal;
@property (DD_STRONG, nonatomic)  UILabel *cellectlal;
@property (DD_STRONG, nonatomic)  UILabel *statuslal;

@property (DD_STRONG, nonatomic)  UILabel *deslal;

@property (DD_STRONG, nonatomic)  UIImageView *imageView;
@property (DD_STRONG, nonatomic)  UILabel *lengthlal;
@property (assign,nonatomic)BOOL hiddenBgImge;

-(void)setImage:(UIImage *)image;

@end
