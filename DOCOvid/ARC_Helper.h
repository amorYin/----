//
//  ARC_Helper.h
//  aiche
//
//  Created by droudrou on 13-5-23.
//  Copyright (c) 2013年 droudrou. All rights reserved.
//  This profile can be used as IOS 4.1 and later.

#ifndef aiche_ARC_Helper_h
#define aiche_ARC_Helper_h

#if __has_feature(objc_arc_weak)                //objc_arc_weak
#define DD_WEAK weak
#define __DD_WEAK __weak
#define DD_STRONG strong

#define DD_AUTORELEASE self
#define DD_RELEASE self
#define DD_RETAIN self
#define DD_CFTYPECAST(exp) (__bridge exp)
#define DD_TYPECAST(exp) (__bridge_transfer exp)
#define DD_CFRELEASE(exp) CFRelease(exp)
#define DD_DEALLOC self

#elif __has_feature(objc_arc)                   //objc_arc
#define DD_WEAK unsafe_unretained
#define __DD_WEAK __unsafe_unretained
#define DD_STRONG strong

#define DD_AUTORELEASE self
#define DD_RELEASE self
#define DD_RETAIN self
#define DD_CFTYPECAST(exp) (__bridge exp)
#define DD_TYPECAST(exp) (__bridge_transfer exp)
#define DD_CFRELEASE(exp) CFRelease(exp)
#define DD_DEALLOC self

#else                                           //none
#define DD_WEAK assign
#define __DD_WEAK
#define DD_STRONG retain

#define DD_AUTORELEASE autorelease
#define DD_RELEASE release
#define DD_RETAIN retain
#define DD_CFTYPECAST(exp) (exp)
#define DD_TYPECAST(exp) (exp)
#define DD_CFRELEASE(exp) CFRelease(exp)
#define DD_DEALLOC dealloc
#define __bridge

#endif//__has_feature


#endif
