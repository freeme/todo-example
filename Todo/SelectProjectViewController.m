//
//  SelectProjectViewController.m
//  Todo
//
//  Created by he baochen on 12-2-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SelectProjectViewController.h"


@implementation SelectProjectViewController
@synthesize curProject = _currentProject;
@synthesize delegate = _delegate;

- (void) dealloc {
    [_currentProject release];
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = nil;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
  UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    Project *project = (Project*)[_projectArray objectAtIndex:indexPath.row];
    if (project.objectID == _currentProject.objectID) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Project *project = (Project*)[_projectArray objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    if ([_delegate respondsToSelector:@selector(didSelectedProject:)]) {
        [_delegate didSelectedProject:project];
    }
  [self.navigationController popViewControllerAnimated:YES];
}



@end
