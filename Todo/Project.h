//
//  Project.h
//  Todo
//
//  Created by he baochen on 12-2-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Task;

@interface Project : NSManagedObject

@property (nonatomic, retain) NSDate * createDate;
@property (nonatomic, retain) NSNumber * isFinish;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * dueDate;
@property (nonatomic, retain) NSOrderedSet *alltask;
@end

@interface Project (CoreDataGeneratedAccessors)

- (void)insertObject:(Task *)value inAlltaskAtIndex:(NSUInteger)idx;
- (void)removeObjectFromAlltaskAtIndex:(NSUInteger)idx;
- (void)insertAlltask:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeAlltaskAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInAlltaskAtIndex:(NSUInteger)idx withObject:(Task *)value;
- (void)replaceAlltaskAtIndexes:(NSIndexSet *)indexes withAlltask:(NSArray *)values;
- (void)addAlltaskObject:(Task *)value;
- (void)removeAlltaskObject:(Task *)value;
- (void)addAlltask:(NSOrderedSet *)values;
- (void)removeAlltask:(NSOrderedSet *)values;
@end
