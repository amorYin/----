//
//  BaseTools.c
//  DOCOVedio
//
//  Created by amor on 13-11-23.
//  Copyright (c) 2013年 amor. All rights reserved.
//
//#include <stdio.h>
#include "BaseTools.h"
#import <sys/types.h>
#include <mach/mach.h>
//#include <sys/param.h>
#include <sys/mount.h>
#include <sys/sysctl.h>


//获取当前设备的信息
long long getSysInfo(uint typeSpecifier)
{
    size_t size = sizeof(int);
    int  results;
    int mib[2] = {CTL_HW, typeSpecifier};
    sysctl(mib, 2, &results, &size, NULL, 0);
    return results;
}
//获取当前设备的总内存
long long totalMemoryBytes(void)
{
    return  getSysInfo(HW_PHYSMEM)/1024/1024;
}

//获取当前设备的CPU核心
int cpuCount(void)
{
    return (int)getSysInfo(HW_NCPU);
}

// 获取当前设备可用内存(单位：MB）
 double availableMemory(void)
{
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(),
                                               HOST_VM_INFO,
                                               (host_info_t)&vmStats,
                                               &infoCount);
    
    if (kernReturn != KERN_SUCCESS) {
        return 0;
    }
    
    return ((vm_page_size *vmStats.free_count) / 1024.0) / 1024.0;
}

// 获取当前任务所占用的内存（单位：MB）
 double   usedMemory(void)
{
    task_basic_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(),
                                         TASK_BASIC_INFO,
                                         (task_info_t)&taskInfo,
                                         &infoCount);
    
    if (kernReturn != KERN_SUCCESS
        ) {
        return 0;
    }
    
    return taskInfo.resident_size / 1024.0 / 1024.0;
}

double get_disk_capacity(char *path)
{
    struct statfs buf;
    long long freespace = -1;
    if(statfs(path, &buf) >= 0){
        freespace = (long long)(buf.f_bsize * buf.f_bfree);
    }
    return freespace;
}
// 获取剩余存储空间函数如下
 double freeDiskSpaceInBytes(void)
{
    struct statfs buf;
    long long freespace = -1;
    if(statfs("/var", &buf) >= 0){
        freespace = (long long)(buf.f_bsize * buf.f_bfree);
    }
    return freespace/1024/1024;
}

// 获取系统总空间大小
 double systemDiskInBytes(void)
{
    
    struct statfs buf;
    long long totalspace = -1;
    if(statfs("/var", &buf) >= 0){
        totalspace = (long long)buf.f_bsize * buf.f_blocks;
    }
    return totalspace/1024/1024;
}

// 获取系统占用空间大小
double fileDiskInBytes(void)
{
    struct statfs buf;
    long long freespace = -1;
    if(statfs("./", &buf) >= 0){
        freespace = (long long)(buf.f_bsize * buf.f_bavail);
    }
    return freespace/1024/1024;
}