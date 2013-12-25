//
//  DCViewController.h
//  DOCOVedio
//
//  Created by amor on 13-11-24.
//  Copyright (c) 2013年 amor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKTabItem.h"
@interface DCViewController : UIViewController
@property(nonatomic,strong) UISegmentedControl *segment;
@property(nonatomic,strong) UIScrollView *scrollerView;
@property(nonatomic,strong) RKTabItem *dcTabbatItem;
@end
