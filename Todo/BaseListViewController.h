//
//  BaseListViewController.h
//  Todo
//
//  Created by he baochen on 12-2-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseListViewController : UITableViewController {
    NSFetchedResultsController *_fetchController;
    NSString *_entityName;
}

- (id)initWithEntityName:(NSString*)entityName;

- (NSArray*) sortDescriptors;

@end
