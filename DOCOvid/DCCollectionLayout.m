//
//  CircleLayout.m
//  DOCOVedio
//
//  Created by 91aiche on 13-11-14.
//  Copyright (c) 2013年 amor. All rights reserved.
//

#import "DCCollectionLayout.h"
@interface DCCollectionLayout()
{
    CGFloat _padding;
    CGFloat _margin;
}
@end
@implementation DCCollectionLayout
- (id)init
{
    self = [super init];
    if (self) {
        [self initlized];
    }
    return self;
}

- (void)initlized
{

    _perLine = 3;

    
}

-(void)prepareLayout
{
    [super prepareLayout];
    CGSize size = self.collectionView.frame.size;
    self.collectionView.scrollEnabled = YES;
    self.collectionView.backgroundColor = [UIColor clearColor];
    _cellCount = [[self collectionView] numberOfItemsInSection:0];
    _center = CGPointMake(size.width / 2.0, size.height / 2.0);
    _radius = MIN(size.width, size.height) / 2.5;
    _padding = 0;//(size.width-cellSizeWidth*_perLine)/(_perLine+1);
    _margin = (size.width-cellSizeWidth*_perLine)*0.5;
}

-(CGSize)collectionViewContentSize
{
    CGFloat line = (_cellCount%_perLine>0)?(_cellCount/_perLine+1):(_cellCount/_perLine);
    return CGSizeMake(self.collectionView.width,line*(cellSizeHight/*+_padding*0.1*/)/*+_padding*0.1*/);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)path
{
    UICollectionViewLayoutAttributes* attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:path];
    attributes.size = CGSizeMake(cellSizeWidth, cellSizeHight);
    attributes.center = CGPointMake(path.item%_perLine*(cellSizeWidth+_padding)+(cellSizeWidth*0.5+_padding)+_margin,path.item/_perLine*(cellSizeHight/*+_padding*0.1*/)+(cellSizeHight*0.5/*+_padding*0.1*/));
//    attributes.center = CGPointMake(_center.x + _radius * cosf(2 * path.item * M_PI / _cellCount),
//                                    _center.y + _radius * sinf(2 * path.item * M_PI / _cellCount));
    return attributes;
}
//
- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString*)decorationViewKind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes* attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
    attributes.alpha = 0.0;
    attributes.transform3D = CATransform3DMakeScale(0.1, 0.1, 1.0);
    attributes.center = CGPointMake(_center.x, _center.y);
    return attributes;
}
//
-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray* attributes = [NSMutableArray array];
    for (NSInteger i=0 ; i < self.cellCount; i++) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    return attributes;
}

- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForInsertedItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    UICollectionViewLayoutAttributes* attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
    attributes.alpha = 0.0;
    attributes.transform3D = CATransform3DMakeScale(0.1, 0.1, 1.0);
    attributes.center = CGPointMake(_center.x, _center.y);
    return attributes;
}
//
- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDeletedItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    UICollectionViewLayoutAttributes* attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
    attributes.alpha = 0.0;
    attributes.center = CGPointMake(_center.x, _center.y);
    attributes.transform3D = CATransform3DMakeScale(0.1, 0.1, 1.0);
    return attributes;
}
//
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
@end
