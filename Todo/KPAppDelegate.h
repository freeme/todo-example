//
//  KPAppDelegate.h
//  Todo
//
//  Created by he baochen on 12-2-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface KPAppDelegate : UIResponder <UIApplicationDelegate> {
    
    UINavigationController *_navController;
    RootViewController *_rootViewController;
}

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (BOOL)saveContext;
- (NSURL *)applicationDocumentsDirectory;

+ (KPAppDelegate*) shareDelegate;
- (BOOL) quickAddProjectWithName:(NSString*)name;
@end
