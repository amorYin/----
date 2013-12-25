//
//  DCVedioViewDeleagate.h
//  DOCOVedio
//
//  Created by amor on 13-12-22.
//  Copyright (c) 2013年 amor. All rights reserved.
//

#ifndef DOCOVedio_DCVedioViewDeleagate_h
#define DOCOVedio_DCVedioViewDeleagate_h

@protocol DCVedioViewDeleagate <NSObject>
@optional
- (void)play:(id)sender;
- (void)deleteVedio:(NSDictionary*)arr;
@end


#endif
