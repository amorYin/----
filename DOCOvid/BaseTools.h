//
//  BaseTools.h
//  DOCOVedio
//
//  Created by amor on 13-11-23.
//  Copyright (c) 2013年 amor. All rights reserved.
//

#ifndef DOCOVedio_BaseTools_h
#define DOCOVedio_BaseTools_h
#ifdef __cplusplus
extern "C" {
#endif
     int cpuCount(void);
     double   availableMemory(void);
     double   usedMemory(void);
     long long totalMemoryBytes(void);
     double   freeDiskSpaceInBytes(void);
     double   systemDiskInBytes(void);
     double   fileDiskInBytes(void);
#ifdef __cplusplus
}
#endif /*__cplusplus*/

#endif
