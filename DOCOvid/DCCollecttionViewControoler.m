//
//  DCCollecttionViewControoler.m
//  DOCOVedio
//
//  Created by amor on 13-11-13.
//  Copyright (c) 2013年 amor. All rights reserved.
//

#import "DCCollecttionViewControoler.h"
#import "UIView+Positioning.h"
#import "DCCollectionCell.h"
#import "DCCollectionLayout.h"
#import "AFCollectionViewFlowLargeLayout.h"

static NSString *CellIdentifierLandscape = @"CellIdentifierLandscape";
@interface DCCollecttionViewControoler ()
{
    NSIndexPath *lastAccessed;
    NSMutableDictionary *selectedIdx;
    BOOL      killAll;
}
@property (nonatomic, strong) DCCollectionLayout *largeLayout;
@end

@implementation DCCollecttionViewControoler


#pragma layout
- (void)layoutSubView:(BOOL)edit;
{
    self.editing  = edit;
    killAll = NO;
    if (edit) {
        //if edit only refresh the changes
        [self.collectionView reloadItemsAtIndexPaths:[self.collectionView indexPathsForVisibleItems]];
    }else{
        //else reload
        [self.collectionView reloadData];
    }
}

- (void)deletePituresInRange:(BOOL)range callback:(void (^)(NSMutableArray *data))callbak
{
    @autoreleasepool {
        
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:0];
        //had delete
        if (selectedIdx.count>0) {
            //find and record the selected cell indexpath
            [[selectedIdx allKeys] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                //find
                if ([selectedIdx objectForKey:obj]) {
                    //record the changed indexpath
                    [array addObject:[NSIndexPath indexPathForRow:[obj integerValue] inSection:0]];
                    //record the changed obj
                    [dataArray addObject:[_arrayData objectAtIndex:[obj integerValue]]];
                    //remove the changed indexpath
                    [selectedIdx removeObjectForKey:obj];
                }
            }];
            //compare the obj and remove from dataSource,avoid error
            [dataArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                //remove the change obj
                [_arrayData removeObject:obj];
            }];
            //move the selected cell
            [self.collectionView deleteItemsAtIndexPaths:array];
        }else{
            
            //do nothing
        }
        //after update the new view,reset the killAll
        killAll = NO;
        //return Data
        callbak(_arrayData);
    }
}

- (void)allSelect_done:(BOOL)sender
{
    killAll = !killAll;
    if (killAll) {
        //if killAll  create the all
        for (int i= 0; i<_arrayData.count; i++)
            [selectedIdx setObject:@"1" forKey:[NSString stringWithFormat:@"%d",i]];
    }else{
        [selectedIdx removeAllObjects];
    }
    
    [self.collectionView reloadItemsAtIndexPaths:[self.collectionView indexPathsForVisibleItems]];
}
#pragma mark -

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)loadView
{
        selectedIdx = [[NSMutableDictionary alloc] init];
    self.largeLayout = [[DCCollectionLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.largeLayout];
    [self.collectionView registerClass:[DCCollectionCell class] forCellWithReuseIdentifier:CellIdentifierLandscape];
//        [self.collectionView registerNib:[UINib nibWithNibName:@"DCCollectionCell" bundle:nil] forCellWithReuseIdentifier:CellIdentifierLandscape];
    [self.collectionView setAllowsMultipleSelection:YES];
    self.collectionView.backgroundColor = [UIColor clearColor];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    UIPanGestureRecognizer *gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
//    [self.view addGestureRecognizer:gestureRecognizer];
//    [gestureRecognizer setMinimumNumberOfTouches:1];
//    [gestureRecognizer setMaximumNumberOfTouches:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _arrayData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DCCollectionCell *cell = (DCCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifierLandscape forIndexPath:indexPath];
    
    cell.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[_arrayData objectAtIndex: [indexPath row] ]]];
    
    if (self.editing)
    {
        [cell.delete_tag setAlpha:cellAHidden];
        cell.imageView.alpha = cellADeactive;
    }else
    {
        [selectedIdx removeObjectForKey:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
    }
    
    // You supposed to highlight the selected cell in here; This is an example
    bool cellSelected = [selectedIdx objectForKey:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
    [self setCellSelection:cell selected:cellSelected];
    return cell;
}
//
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DCCollectionCell *cell = (DCCollectionCell*)[collectionView cellForItemAtIndexPath:indexPath];
    if (self.editing)
    {
        if (killAll) {
            [self setCellSelection:cell selected:NO];
            [selectedIdx removeObjectForKey:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
        }else{
            [self setCellSelection:cell selected:YES];
            [selectedIdx setValue:@"1" forKey:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
        }
    }else{
        if ([_actionDelegate respondsToSelector:@selector(play:)]) {
            [_actionDelegate play:Nil];
        }
    }
    
    if ([_actionDelegate respondsToSelector:@selector(deleteVedio:)]) {
        [_actionDelegate performSelector:@selector(deleteVedio:) withObject:selectedIdx];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DCCollectionCell *cell = (DCCollectionCell*)[collectionView cellForItemAtIndexPath:indexPath];
    if (self.editing)
    {
        if (killAll) {
            [self setCellSelection:cell selected:YES];
            [selectedIdx setValue:@"1" forKey:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
        }else{
            [self setCellSelection:cell selected:NO];
            [selectedIdx removeObjectForKey:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
        }
    }else{
        
    }
    
    if ([_actionDelegate respondsToSelector:@selector(deleteVedio:)]) {
        [_actionDelegate performSelector:@selector(deleteVedio:) withObject:selectedIdx];
    }
}

- (void) setCellSelection:(DCCollectionCell *)cell selected:(bool)selected
{
    if (self.editing)
    {
        cell.imageView.alpha = selected ? cellAAcitve : cellADeactive;
        cell.delete_tag.alpha = selected ? cellAAcitve : cellAHidden;
        cell.hiddenBgImge = NO;
        
    }else
    {
        cell.imageView.alpha = cellAAcitve;
        cell.delete_tag.alpha = cellAHidden;
        cell.hiddenBgImge = YES;
    }

}

- (void) resetSelectedCells
{
    for (UICollectionViewCell *cell in self.collectionView.visibleCells) {
        [self deselectCellForCollectionView:self.collectionView atIndexPath:[self.collectionView indexPathForCell:cell]];
    }
}

- (void) handleGesture:(UIPanGestureRecognizer *)gestureRecognizer
{
    float pointerX = [gestureRecognizer locationInView:self.collectionView].x;
    float pointerY = [gestureRecognizer locationInView:self.collectionView].y;
    
    for (UICollectionViewCell *cell in self.collectionView.visibleCells) {
        float cellSX = cell.frame.origin.x;
        float cellEX = cell.frame.origin.x + cell.frame.size.width;
        float cellSY = cell.frame.origin.y;
        float cellEY = cell.frame.origin.y + cell.frame.size.height;
        
        if (pointerX >= cellSX && pointerX <= cellEX && pointerY >= cellSY && pointerY <= cellEY)
        {
            NSIndexPath *touchOver = [self.collectionView indexPathForCell:cell];
            
            if (lastAccessed != touchOver)
            {
                if (cell.selected)
                    [self deselectCellForCollectionView:self.collectionView atIndexPath:touchOver];
                else
                    [self selectCellForCollectionView:self.collectionView atIndexPath:touchOver];
            }
            
            lastAccessed = touchOver;
        }
    }
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        lastAccessed = nil;
        self.collectionView.scrollEnabled = YES;
    }
    
    
}

- (void) selectCellForCollectionView:(UICollectionView *)collection atIndexPath:(NSIndexPath *)indexPath
{
    [collection selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    [self collectionView:collection didSelectItemAtIndexPath:indexPath];
}

- (void) deselectCellForCollectionView:(UICollectionView *)collection atIndexPath:(NSIndexPath *)indexPath
{
    [collection deselectItemAtIndexPath:indexPath animated:YES];
    [self collectionView:collection didDeselectItemAtIndexPath:indexPath];
}
@end
