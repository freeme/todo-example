//
//  Project.m
//  Todo
//
//  Created by He baochen on 12-2-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Project.h"
#import "Task.h"


@implementation Project

@dynamic createDate;
@dynamic dueDate;
@dynamic isFinish;
@dynamic name;
@dynamic tasks;

- (void)addTasksObject:(Task *)value {
  NSMutableOrderedSet* tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:self.tasks];
  [tempSet addObject:value];
  self.tasks = tempSet;
}


@end
