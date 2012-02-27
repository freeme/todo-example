//
//  RootViewController.h
//  Todo
//
//  Created by he baochen on 12-2-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    SectionTypeInput = 0,
    SectionTypeInbox ,
    SectionTypeTime,
    SectionTypeProject,
    SectionTypeFinish,
    SectionTypeCount
} SectionType;


@interface RootViewController : UITableViewController<UITextFieldDelegate> {
    UITextField *_inputField;
}

@end
