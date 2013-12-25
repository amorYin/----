//
//  AFCollectionViewFlowLargeLayout.m
//  UICollectionViewFlowLayoutExample
//
//  Created by Ash Furrow on 2013-02-05.
//  Copyright (c) 2013 Ash Furrow. All rights reserved.
//

#import "AFCollectionViewFlowLargeLayout.h"

@implementation AFCollectionViewFlowLargeLayout

-(id)init
{
    if (!(self = [super init])) return nil;
    
    self.itemSize = CGSizeMake(cellSizeWidth, cellSizeWidth);
    self.sectionInset = UIEdgeInsetsMake(10, 30, 10, 10);
    self.minimumInteritemSpacing = 30.0f;
    self.minimumLineSpacing = 10.0f;
    
    return self;
}

@end
