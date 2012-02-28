//
//  FetchRequestFactory.m
//  Todo
//
//  Created by He baochen on 12-2-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FetchRequestFactory.h"
#import "KPAppDelegate.h"

@interface FetchRequestFactory (private)

+ (NSFetchRequest*) defaultTaskFetchRequest;
+ (NSArray*) defaultSortDescriptors;

@end

@implementation FetchRequestFactory

+ (NSArray*) defaultSortDescriptors {
  NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"dueDate" ascending:YES];
  NSSortDescriptor *sortDescriptor2 = [[NSSortDescriptor alloc] initWithKey:@"createDate" ascending:YES];
  
  NSArray *sortDescriptors = [[[NSArray alloc] initWithObjects:sortDescriptor1,sortDescriptor2, nil] autorelease];
  [sortDescriptor1 release];
  [sortDescriptor2 release];
  return sortDescriptors;
}

+ (NSFetchRequest*) defaultTaskFetchRequest {
  NSFetchRequest *request = nil;
  KPAppDelegate *appDelegate = [KPAppDelegate shareDelegate];
  NSManagedObjectContext *context = appDelegate.managedObjectContext;
  request = [[NSFetchRequest alloc] init];
  [request setEntity:[NSEntityDescription entityForName:@"Task" inManagedObjectContext:context]];
  NSArray* sortDescriptors = [self defaultSortDescriptors];
  [request setSortDescriptors:sortDescriptors];
  return request;
}

+ (NSFetchRequest*) inboxTaskFetchRequest {
  NSFetchRequest *request = [self defaultTaskFetchRequest];
  // 不在任何项目中的任务
  NSPredicate *predicate = [NSPredicate
                            predicateWithFormat:@"belongList == nil"];
  [request setPredicate:predicate];
  return request;
}

+ (NSFetchRequest*) todayTaskFetchRequest {
  NSFetchRequest *request = [self defaultTaskFetchRequest];
  // 今天的任务，任务的到期时间 小于等于　今天的
  NSDate *today = [NSDate date];
  //NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
  NSCalendar *calendar = [NSCalendar currentCalendar];
  NSDateComponents *todayComponents =
  [calendar components:(kCFCalendarUnitDay | kCFCalendarUnitMonth | kCFCalendarUnitYear) fromDate:today];
  NSInteger day = [todayComponents day];
  [todayComponents setDay:day + 1];
  
  //今天晚上12:00，所有小于这个时间都放在今天显示
  NSDate *todayEnd = [calendar dateFromComponents:todayComponents];

  return request;
}

@end
