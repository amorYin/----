//
//  DCTableViewController.m
//  DOCOVedio
//
//  Created by amor on 13-11-15.
//  Copyright (c) 2013年 amor. All rights reserved.
//

#import "DCTableViewController.h"
#import "DCTableViewCell.h"

static NSString *CellIdentifier = @"DCTableViewControllerCell";
@interface DCTableViewController ()
{
    NSIndexPath *lastAccessed;
    NSMutableDictionary *selectedIdx;
    BOOL      killAll;
    BOOL      editStart;
}
@end

@implementation DCTableViewController


#pragma layout
- (void)layoutSubView:(BOOL)edit;
{
    //set editing
    editStart  = edit;
    //set killAll
    killAll    = NO;
    //reloadRadta
    if (edit) {
        //if edit only refresh the changes
        [self.tableView reloadRowsAtIndexPaths:[self.tableView indexPathsForVisibleRows] withRowAnimation:UITableViewRowAnimationFade];
    }else{
        //else reload
        [self.tableView reloadData];
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
            [self.tableView deleteRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationFade];
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
        //else remove all
        [selectedIdx removeAllObjects];
    }
    
    [self.tableView reloadRowsAtIndexPaths:[self.tableView indexPathsForVisibleRows] withRowAnimation:UITableViewRowAnimationFade];
}
#pragma view
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    selectedIdx = [[NSMutableDictionary alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[DCTableViewCell class] forCellReuseIdentifier:CellIdentifier];
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _arrayData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return the height for rows
    return 200;
}

- (DCTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:
                             indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // Configure the cell...
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(DCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[_arrayData objectAtIndex: [indexPath row]]]];

    if (editStart)
    {
        [cell.delete_tag setAlpha:cellAHidden];
        cell.contentView.alpha = cellADeactive;
    }else
    {
        [selectedIdx removeObjectForKey:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
    }
    
    // You supposed to highlight the selected cell in here; This is an example
    bool cellSelected = [selectedIdx objectForKey:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
    [self setCellSelection:cell selected:cellSelected];
}

- (void) setCellSelection:(DCTableViewCell *)cell selected:(bool)selected
{
    if (editStart)
    {
        cell.contentView.alpha = selected ? cellAAcitve : cellADeactive;
        cell.delete_tag.alpha = selected ? cellAAcitve : cellAHidden;
        cell.hiddenBgImge = NO;
        
    }else
    {
        cell.contentView.alpha = cellAAcitve;
        cell.delete_tag.alpha = cellAHidden;
        cell.hiddenBgImge = YES;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DCTableViewCell *cell = (DCTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    if (editStart)
    {
//        if (killAll) {
//            [self setCellSelection:cell selected:NO];
//            [selectedIdx removeObjectForKey:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
//        }else{
            if ([selectedIdx objectForKey:[NSString stringWithFormat:@"%ld", (long)indexPath.row]]) {
                [self setCellSelection:cell selected:NO];
                [selectedIdx removeObjectForKey:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
            }else{
                [self setCellSelection:cell selected:YES];
                [selectedIdx setValue:@"1" forKey:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
            }
//        }
    }else{
        if ([_actionDelegate respondsToSelector:@selector(play:)]) {
            [_actionDelegate play:Nil];
        }
    }
    
    if ([_actionDelegate respondsToSelector:@selector(deleteVedio:)]) {
        [_actionDelegate performSelector:@selector(deleteVedio:) withObject:selectedIdx];
    }
}

//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    DCTableViewCell *cell = (DCTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
//    if (editStart)
//    {
//        if (killAll) {
//            [self setCellSelection:cell selected:YES];
//            [selectedIdx setValue:@"1" forKey:[NSString stringWithFormat:@"%d", indexPath.row]];
//        }else{
//            [self setCellSelection:cell selected:NO];
//            [selectedIdx removeObjectForKey:[NSString stringWithFormat:@"%d", indexPath.row]];
//        }
//    }else{
//        
//    }
//}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{

}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];

    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
 
 */

@end
