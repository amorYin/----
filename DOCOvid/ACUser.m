//
//  ACUser.m
//  aiche
//
//  Created by 91aiche on 13-6-17.
//  Copyright (c) 2013年 droudrou. All rights reserved.
//

#import "ACUser.h"
#import "Base64.h"

static ACUser *a_user = nil;
@implementation ACUser

@synthesize session     =_session;
@synthesize uuid        =_uuid;
@synthesize account     =_account;
@synthesize nick        =_nick;
@synthesize pass        =_pass;
@synthesize isAutoLoad  =_isAutoLoad;
@synthesize apiType     =_apiType;
@synthesize deviceType  =_deviceType;
@synthesize screenSize  =_screenSize;
@synthesize strPhoneName=_strPhoneName;
@synthesize strOSVersion=_strOSVersion;
@synthesize strTooken   =_strTooken;
@synthesize isTestUser  =_isTestUser;
@synthesize userStatus  =_userStatus;
- (id)init
{
    self = [super init];
    if (self) {
        UIDevice *device = [UIDevice currentDevice];
        _apiType = API_VERSION;
        _deviceType = @"0";
        _screenSize = NSStringFromCGSize([UIScreen mainScreen].bounds.size);
        _strPhoneName = device.model;
        _strOSVersion = device.systemVersion;
        _userStatus = UserLoadStautsNone;
    }
    return self;
}

- (NSString*)longitude
{
    NSString *lon = [[NSUserDefaults standardUserDefaults] objectForKey:@"lon"];
    if (lon!=NULL) {
        return lon;
    }
    return @"116.462193";
}
- (NSString*)latitude
{
    NSString *lan = [[NSUserDefaults standardUserDefaults] objectForKey:@"lan"];
    if (lan!=NULL) {
        return lan;
    }
    return @"39.878843";
}

- (void)setPass:(NSString *)passd
{
    _pass  = [passd base64EncodedString];
}

- (void)setSession:(NSString *)session
{

    if (!session||
        [session isEqualToString:@"null"]||
        [session isEqualToString:@""]||
        [session isEqualToString:@"(null)"]) {
        
    }else if([session isEqualToString:@"---"]){
        //清空
        _session = @"";
        [ACUser saveUser];
    }else{
        _session = session;
        [ACUser saveUser];
    }
}

- (id)initWithCoder:(NSCoder*)aCoder
{
    self = [super init];
    if (self) {
        [self setSession:[aCoder decodeObjectForKey:@"A_session"]];
        [self setAccount:[aCoder decodeObjectForKey:@"A_account"]];
        [self setPass:[aCoder decodeObjectForKey:@"A_pass"]];
        [self setNick:[aCoder decodeObjectForKey:@"A_nick"]];
        [self setIsAutoLoad:[aCoder decodeBoolForKey:@"A_AutoLoad"]];
        
        [self setUuid:[aCoder decodeObjectForKey:@"A_Uuid"]];
        
        [self setDeviceType:[aCoder decodeObjectForKey:@"A_deviceType"]];
        [self setScreenSize:[aCoder decodeObjectForKey:@"A_screenSize"]];
        [self setStrOSVersion:[aCoder decodeObjectForKey:@"A_strOSVersion"]];
        [self setStrPhoneName:[aCoder decodeObjectForKey:@"A_strPhoneName"]];
        [self setStrTooken:[aCoder decodeObjectForKey:@"A_strTooken"]];
        
        [self setIsTestUser:[aCoder decodeBoolForKey:@"A_TestUser"]];
        
        self.apiType = API_VERSION;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder*)aCoder
{
    [aCoder encodeObject:[self session] forKey:@"A_session"];
    [aCoder encodeObject:[self account] forKey:@"A_account"];
    [aCoder encodeObject:[self pass] forKey:@"A_pass"];
    [aCoder encodeObject:[self nick] forKey:@"A_nick"];
    [aCoder encodeBool:self.isAutoLoad forKey:@"A_AutoLoad"];
    
    [aCoder encodeObject:self.uuid forKey:@"A_Uuid"];
    
    [aCoder encodeObject:[self deviceType] forKey:@"A_deviceType"];
    [aCoder encodeObject:[self screenSize] forKey:@"A_screenSize"];
    [aCoder encodeObject:[self strOSVersion] forKey:@"A_strOSVersion"];
    [aCoder encodeObject:[self strPhoneName] forKey:@"A_strPhoneName"];
    [aCoder encodeObject:[self strTooken] forKey:@"A_strTooken"];
    
    [aCoder encodeBool:[self isTestUser] forKey:@"A_TestUser"];
}

+ (id)instanseUser
{
    @synchronized(self){
        if (!a_user) {
            NSData *codeData = (NSData*)[[NSUserDefaults standardUserDefaults] objectForKey:@"A_code"];
            if (codeData) {
                a_user = [NSKeyedUnarchiver unarchiveObjectWithData:codeData];
            }else{
                a_user = [[self alloc] init];
            }
            
        }
        return a_user;
    }
}

+ (void)saveUser
{
    if (a_user) {
        NSData *codeData = [NSKeyedArchiver archivedDataWithRootObject:a_user];
        [[NSUserDefaults standardUserDefaults] setObject:codeData forKey:@"A_code"];
    }
}
@end
