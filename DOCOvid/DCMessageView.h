//
//  DCMessageView.h
//  DOCOVedio
//
//  Created by amor on 13-12-18.
//  Copyright (c) 2013年 amor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCMessageView : NSObject
- (id)initWithTitle:(NSString*)title message:(NSString*)msg;
- (void)show;
@end
