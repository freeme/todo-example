//
//  BaseListViewController.h
//  Todo
//
//  Created by he baochen on 12-2-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FetchListViewController : UITableViewController {
    NSFetchedResultsController *_fetchController;
    NSString *_entityName;
    NSArray *_sortDescriptors;
    NSPredicate *_predicate;
}

- (id)initWithEntityName:(NSString*)entityName;

@property(nonatomic, retain) NSArray *sortDescriptors;
@property(nonatomic, retain) NSPredicate *predicate;

@end
