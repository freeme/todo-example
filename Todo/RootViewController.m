//
//  RootViewController.m
//  Todo
//
//  Created by he baochen on 12-2-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "KPAppDelegate.h"
#import "TaskListViewController.h"
#import "ProjectListViewController.h"

@interface RootViewController(Private) 

- (BOOL) saveTask;

@end

@implementation RootViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) dealloc {
    [_inputField release];
    [super dealloc];
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

    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = YES;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"新建任务" style:UIBarButtonItemStyleBordered target:self action:@selector(showAddTaskView)] autorelease];
    
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"新建清单" style:UIBarButtonItemStyleBordered target:self action:@selector(showAddListView)] autorelease];
    
    _inputField = [[UITextField alloc] initWithFrame:CGRectMake(6, 10, 240, 22)];
    _inputField.font = [UIFont systemFontOfSize:18];
    //_inputField.backgroundColor = [UIColor lightGrayColor];
    _inputField.placeholder = @"在此添加新任务";
    _inputField.delegate = self;
}

- (void) quickAdd {
    [self saveTask];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    BOOL result = [self saveTask];
    if (result) {
        [_inputField resignFirstResponder];
    }
    
    return result;
}

- (BOOL) saveTask {
    if ([_inputField.text length] >0) {
        KPAppDelegate *appDelegate = [KPAppDelegate shareDelegate];
        BOOL result = [appDelegate quickAddTaskWithText:_inputField.text];
        if (result) {
            _inputField.text = @"";
            return result;
        }
    } 
    return NO;
}

- (void) showAddTaskView {
    
}

- (void) showAddListView {
    ProjectListViewController *listViewController = [[ProjectListViewController alloc] initWithEntityName:@"Project"];
    listViewController.title = @"项目";
    [self.navigationController pushViewController:listViewController animated:YES];
    [listViewController showAddView];
    [listViewController release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return SectionTypeCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    NSInteger rowCount = 1;
    return rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
        if (indexPath.section == SectionTypeInput) {
            UIButton *quickAdd = [UIButton buttonWithType:UIButtonTypeContactAdd];
            [quickAdd addTarget:self action:@selector(quickAdd) forControlEvents:UIControlEventTouchUpInside];
            quickAdd.center = CGPointMake(280, 22);
            [cell.contentView addSubview:quickAdd];
            [cell.contentView addSubview:_inputField];
        } else {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    
    // Configure the cell...
    switch (indexPath.section) {
        case SectionTypeInbox:
            cell.textLabel.text = @"整理箱";
            break;        
        case SectionTypeTime:
            cell.textLabel.text = @"今天";
            break;        
        case SectionTypeProject:
            cell.textLabel.text = @"项目";
            break; 
        case SectionTypeFinish:
            cell.textLabel.text = @"已完成";
            break;
            
        default:
            break;
    }
    return cell;
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
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == SectionTypeInbox) {
        
        TaskListViewController *listViewController = [[TaskListViewController alloc] initWithEntityName:@"Task"];
        listViewController.title = @"整理箱";
        [self.navigationController pushViewController:listViewController animated:YES];
        [listViewController release];
    } else if(indexPath.section == SectionTypeProject) {
        ProjectListViewController *listViewController = [[ProjectListViewController alloc] initWithEntityName:@"Project"];
        listViewController.title = @"项目";
        [self.navigationController pushViewController:listViewController animated:YES];
        [listViewController release];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
