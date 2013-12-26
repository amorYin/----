//
//  DCData.h
//  DOCOvid
//
//  Created by 91aiche on 13-12-26.
//  Copyright (c) 2013年 amor. All rights reserved.
//

#import "ACUser.h"
#import "ACVedio.h"

@interface DCData : NSObject
+ (BOOL)saveUserInfo;
+ (BOOL)saveVedios:(NSArray*)vedios;
- (ACUser*)userWith:(NSString*)indentifed;
@end
