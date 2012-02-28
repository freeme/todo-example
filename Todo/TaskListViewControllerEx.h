//
//  TaskListViewControllerEx.h
//  Todo
//
//  Created by he baochen on 12-2-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Project.h"

@interface TaskListViewControllerEx : UITableViewController {
    Project *_project;
}

@property(nonatomic, retain) Project *project;



@end
