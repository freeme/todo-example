//
//  TaskListViewControllerEx.m
//  Todo
//
//  Created by he baochen on 12-2-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TaskListViewControllerEx.h"
#import "KPAppDelegate.h"
#import "Task.h"

@implementation TaskListViewControllerEx
@synthesize project = _project;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showAddView)] autorelease];
}

- (void) showAddView {
    EditTaskViewController * viewController = [[EditTaskViewController alloc] initWithStyle:UITableViewStyleGrouped];
    viewController.createdInProject = _project;
    viewController.delegate = self;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    [self presentModalViewController:navController animated:YES];
    
    [viewController release];
    [navController release];
    /*
    KPAppDelegate *appDelegate = [KPAppDelegate shareDelegate];
//    BOOL result = [appDelegate quickAddTaskWithText:@"testTask"];
    
    Task *newTask = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:appDelegate.managedObjectContext];
    newTask.text = @"Test Task";
    newTask.createDate = [NSDate date];

    //方法一
    newTask.belongList = _project;
  

     */
    //方法二
 
    /*
     在使用NSOrderedSet时，有个BUG，而NSSet时没有。
    　下面代码不好用，可能是个系统BUG
     解决方案，自己实现这个方法
     - (void)addTasksObject:(Task *)value {
     NSMutableOrderedSet* tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:self.tasks];
     [tempSet addObject:value];
     self.tasks = tempSet;
     }
     */
    //[_project addTasksObject:newTask]; 
    //[self.tableView reloadData];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [_project.tasks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }

    Task *task = [_project.tasks objectAtIndex:indexPath.row];
    cell.textLabel.text = task.text;
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } 
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EditTaskViewController * viewController = [[EditTaskViewController alloc] initWithStyle:UITableViewStyleGrouped];
    viewController.createdInProject = _project;
    viewController.delegate = self;
    viewController.editingTask = (Task*)[_project.tasks objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:viewController animated:YES];
    
    [viewController release];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Edit Task delegate
- (void) didFinishEditTask:(Task*)task {
    [self.tableView reloadData];
}

@end
