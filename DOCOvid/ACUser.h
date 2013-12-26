//
//  ACUser.h
//  aiche
//
//  Created by 91aiche on 13-6-17.
//  Copyright (c) 2013年 droudrou. All rights reserved.
//

typedef NS_ENUM(NSInteger, UserLoadStauts) {
    UserLoadStautsNone = 0,
    UserLoadStautsWillLoadQQ,
    UserLoadStautsWillLoadSina,
    UserLoadStautsLoadingQQ,
    UserLoadStautsLoadingSina,
    UserLoadStautsLoadedQQ,
    UserLoadStautsLoadedSina,
    UserLoadStautsErrorQQ,
    UserLoadStautsErrorSina,
};

@interface ACUser : NSObject<NSCoding>

@property(nonatomic,strong)NSString *session;
@property(nonatomic,strong)NSString *account;
@property(nonatomic,strong)NSString *uuid;
@property(nonatomic,strong)NSString *nick;
@property(nonatomic,strong)NSString *pass;
@property(nonatomic,strong)NSString *apiType;
@property(nonatomic,strong)NSString *deviceType;
@property(nonatomic,strong)NSString *screenSize;
@property(nonatomic,strong)NSString *strPhoneName;
@property(nonatomic,strong)NSString *strOSVersion;
@property(nonatomic,strong)NSString *strTooken;
@property(readwrite)UserLoadStauts userStatus;
@property(readwrite)BOOL isAutoLoad;
@property(readwrite)BOOL isTestUser;
+ (id)instanseUser;
+ (void)saveUser;
- (NSString*)longitude;
- (NSString*)latitude;
@end
