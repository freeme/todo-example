//
//  Task.h
//  Todo
//
//  Created by he baochen on 12-2-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class List;

@interface Task : NSManagedObject

@property (nonatomic, retain) NSDate * createDate;
@property (nonatomic, retain) NSDate * dueDate;
@property (nonatomic, retain) NSNumber * isFinish;
@property (nonatomic, retain) NSString * note;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSSet *belongList;
@end

@interface Task (CoreDataGeneratedAccessors)

- (void)addBelongListObject:(List *)value;
- (void)removeBelongListObject:(List *)value;
- (void)addBelongList:(NSSet *)values;
- (void)removeBelongList:(NSSet *)values;

@end
