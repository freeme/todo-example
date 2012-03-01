//
//  Task.h
//  Todo
//
//  Created by he baochen on 12-2-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Project;

@interface Task : NSManagedObject

@property (nonatomic, retain) NSDate * createDate;
@property (nonatomic, retain) NSDate * dueDate;
@property (nonatomic, retain) NSNumber * isFinish;
@property (nonatomic, retain) NSString * note;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) Project *project;

@end
