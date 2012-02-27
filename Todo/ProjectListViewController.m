//
//  ProjectListViewController.m
//  Todo
//
//  Created by he baochen on 12-2-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ProjectListViewController.h"
#import "KPAppDelegate.h"
#import "Project.h"

@interface ProjectListViewController(Private) 

- (BOOL) saveProject ;
- (void) reloadList;
- (void) closeAddView;
@end

@implementation ProjectListViewController

- (id)initWithEntityName:(NSString*)entityName {
    self = [super init];
    if (self) {
        _entityName = [entityName copy];
    }
    return self;
}

- (void) dealloc {
    [_inputField release];
    [_entityName release];
    [_request release];
    [_listArray release];
    [_coverView release];
    [_inputContainer release];
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
//    self.view = [[[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds] autorelease];
    _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _coverView = [[UIControl alloc] initWithFrame:CGRectMake(0, 44, 320, 480)];
    _coverView.backgroundColor = [UIColor blackColor];
    _coverView.alpha = 0.0;
    [_coverView addTarget:self action:@selector(closeAddView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_coverView];
    _inputContainer = [[UIView alloc] initWithFrame:CGRectMake(0, -44, 320, 44)];
    _inputContainer.backgroundColor = [UIColor whiteColor];
    _inputField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 280, 22)];
    _inputField.font = [UIFont systemFontOfSize:18];
    _inputField.delegate = self;
    //_inputField.backgroundColor = [UIColor lightGrayColor];
    [_inputContainer addSubview:_inputField];
    
    UIButton *quickAdd = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [quickAdd addTarget:self action:@selector(quickAdd) forControlEvents:UIControlEventTouchUpInside];
    quickAdd.center = CGPointMake(300, 22);
    [_inputContainer addSubview:quickAdd];

    [self.view addSubview:_inputContainer];
    

    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showAddView)] autorelease];
    
    KPAppDelegate *appDelegate = [KPAppDelegate shareDelegate];
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:_entityName inManagedObjectContext:context];
    _request = [[NSFetchRequest alloc] init];
    [_request setEntity:entityDescription];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"name" ascending:YES];
    [_request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    [sortDescriptor release];
    
    NSError *error = nil;
    NSArray *array = [context executeFetchRequest:_request error:&error];
    _listArray = [[NSMutableArray alloc] initWithArray:array];
    [_tableView reloadData];
}

- (void) reloadList {
    KPAppDelegate *appDelegate = [KPAppDelegate shareDelegate];
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    NSArray *array = [context executeFetchRequest:_request error:NULL];
    if (_listArray) {
        [_listArray release];
    }
    _listArray = [[NSMutableArray alloc] initWithArray:array];
    [_tableView reloadData];
}

- (void) showAddView {
    self.title = @"新建项目";
    [_inputField becomeFirstResponder];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    _inputContainer.frame = CGRectMake(0, 0, 320, 44);
    _tableView.scrollEnabled = NO;
    _coverView.alpha = 0.7;
    //self.tableView.userInteractionEnabled = NO;
    [UIView commitAnimations];
}

- (void) closeAddView {
    self.title = @"项目";
    _inputField.text = @"";
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    _inputContainer.frame = CGRectMake(0, -44, 320, 44);
    _tableView.scrollEnabled = YES;
    _coverView.alpha = 0.0;
    [UIView commitAnimations];
}

- (void) quickAdd {
    [self saveProject];
}

- (BOOL) saveProject {
    if ([_inputField.text length] >0) {
        KPAppDelegate *appDelegate = [KPAppDelegate shareDelegate];
        BOOL result = [appDelegate quickAddProjectWithName:_inputField.text];
        if (result) {
            [self reloadList];
            return result;
        }
    } 
    return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    BOOL result = [self saveProject];
    if (result) {
        [self closeAddView];
        [_inputField resignFirstResponder];
    }
    return result;
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [_listArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    Project *project = (Project*)[_listArray objectAtIndex:indexPath.row];
    // Configure the cell...
    cell.textLabel.text = project.name;
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
