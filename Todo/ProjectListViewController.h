//
//  ProjectListViewController.h
//  Todo
//
//  Created by he baochen on 12-2-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseListViewController.h"

@interface ProjectListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate> {
    UITableView *_tableView;
    NSString *_entityName;
    NSFetchRequest *_request;
    NSMutableArray *_listArray;
    UIView *_inputContainer;
    UITextField *_inputField;
    UIControl *_coverView;
}

- (id)initWithEntityName:(NSString*)entityName;
- (void) showAddView;

@end
