//
//  TaskListViewController.m
//  Todo
//
//  Created by he baochen on 12-2-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TaskListViewController.h"
#import "KPAppDelegate.h"

@implementation TaskListViewController

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

}

- (void) showAddView {
    
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
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    id <NSFetchedResultsSectionInfo> sectionInfo = [[_fetchController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
      UIImage *img = [UIImage imageNamed:@"CheckboxActive-N.png"];
      cell.imageView.image = img;
      UIControl *markControl = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, img.size.width, img.size.height)];
      [markControl addTarget:self action:@selector(markAction:) forControlEvents:UIControlEventTouchUpInside];
      cell.imageView.userInteractionEnabled = YES;
      [cell.imageView addSubview:markControl];
      [markControl release];
    }
    Task *task = (Task*)[_fetchController objectAtIndexPath:indexPath];

    cell.textLabel.text = task.title;
    if ([task.isFinish boolValue]) {
      cell.imageView.image = [UIImage imageNamed:@"CheckboxDone-N.png"];
    } else {
      cell.imageView.image = [UIImage imageNamed:@"CheckboxActive-N.png"];
    }
    
    return cell;
}

- (void) markAction:(id)sender {
  UIControl *control = (UIControl*)sender;
  //推荐的解决方案
  CGPoint originInTable = [control convertPoint:control.frame.origin toView:self.tableView];
  NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:originInTable];
  UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
  Task *task = (Task*)[_fetchController objectAtIndexPath:indexPath];
    task.isFinish = [NSNumber numberWithBool:![task.isFinish boolValue] ];
  if ([task.isFinish boolValue]) {
    cell.imageView.image = [UIImage imageNamed:@"CheckboxDone-N.png"];
  } else {
    cell.imageView.image = [UIImage imageNamed:@"CheckboxActive-N.png"];
  }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
