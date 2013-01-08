//
//  KPStore.m
//  kweibo
//
//  Created by He baochen on 11-9-6.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "KPStore.h"
/**
 使用说明：
 1. 在新工程中使用的时候，需要先修改 MODEL_FILE_NAME, 例如model文件名为 Hello.xcdatamodeld，MODEL_FILE_NAME 需要指定为Hello
 
 */
#define SHARED_MODEL_FILE_NAME @"BabyTT"
#ifndef SHARED_MODEL_FILE_NAME
#warning please define SHARED_MODEL_FILE_NAME
#endif
@interface KPStore(Private)


@end

static KPStore* __instance = nil;
static NSMutableDictionary* __namedStoreDict = nil;
static NSMutableDictionary* __boundClassDict = nil;
@implementation KPStore

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

+ (void)initialize {
  __namedStoreDict = [[NSMutableDictionary alloc] init];
  __boundClassDict = [[NSMutableDictionary alloc] init];
}

+ (KPStore*)registerStoreWithName:(NSString*)name modelFile:(NSString*)modelFileName {
  KPStore *store = [__namedStoreDict objectForKey:name];
  if (!store) {
    store = [[[KPStore alloc] initWithModelFileName:modelFileName] autorelease];
    [__namedStoreDict setObject:store forKey:name];
  }
  return store;
}

+ (KPStore*)storeForName:(NSString*)name {
  KPStore *store = [__namedStoreDict objectForKey:name];
  return store;
}
+ (void)bindObjectClass:(Class)objClass toStore:(KPStore*)store{
  [__boundClassDict setObject:store forKey:NSStringFromClass(objClass)];
}

+ (KPStore*)storeForObject:(Class) objClass {
  KPStore *store = [__boundClassDict objectForKey:NSStringFromClass(objClass)];
  if (!store) {
    store = [self sharedStore];
  }
  return store;
}

+ (KPStore*) sharedStore {
  if (!__instance) {
    @synchronized(self) {
      if (!__instance) {
        __instance = [[KPStore alloc] initWithModelFileName:SHARED_MODEL_FILE_NAME];
      }
    }
  }
  return __instance;
}

+ (void) saveAllStore {
  
}

+ (void)destory {
  [__instance release];
  __instance = nil;
}


- (id) initWithModelFileName:(NSString*)modelFileName {
  self = [super init];
  if (self) {
    _modelFileName = [modelFileName copy];
  }
  return self;
}
- (void)dealloc {
  [_managedObjectContext release];
  [_managedObjectModel release];
  [_persistentStoreCoordinator release];
  [_modelFileName release];
  [super dealloc];
}

- (void) resetPersistentStore {
  [self saveContext];
  [_managedObjectContext release];
  _managedObjectContext = nil;
  [_managedObjectModel release];
  _managedObjectModel = nil;
  [_persistentStoreCoordinator release];
  _persistentStoreCoordinator = nil;
}


- (void) didReceiveMemoryWarning {
  
  
}


#pragma mark -
#pragma mark - Core Data stack

- (void)saveContext {
  NSError *error = nil;
  NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
  if (managedObjectContext != nil) {
    if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
      /*
       Replace this implementation with code to handle the error appropriately.
       
       abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
       */
      NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
#ifdef DEBUG
      abort();
#endif
    }
  }
}

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext {
  if (_managedObjectContext != nil) {
    return _managedObjectContext;
  }
  
  NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
  if (coordinator != nil) {
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
  }
  return _managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel {
  if (_managedObjectModel != nil) {
    return _managedObjectModel;
  }
  NSURL *modelURL = [[NSBundle mainBundle] URLForResource:_modelFileName withExtension:@"momd"];
  _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
  return _managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
  if (_persistentStoreCoordinator != nil) {
    return _persistentStoreCoordinator;
  }
  
  NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:[NSString stringWithFormat:@"%@_DB.sqlite",_modelFileName]];
  
  NSError *error = nil;
  NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
  
  _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
  NSPersistentStore *persistenStore = [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error];
  if (!persistenStore) {
    [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
    NSLog(@"Removed incompatible model version: %@", [storeURL lastPathComponent]);
    
    persistenStore = [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error];
    if (persistenStore) {
      error = nil;
    } else {
      NSLog(@"error domain: %@, error code:%d", [error domain], [error code]);
    }
    /*
     Replace this implementation with code to handle the error appropriately.
     
     abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
     
     Typical reasons for an error here include:
     * The persistent store is not accessible;
     * The schema for the persistent store is incompatible with current managed object model.
     Check the error message to determine what the actual problem was.
     
     
     If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
     
     If you encounter schema incompatibility errors during development, you can reduce their frequency by:
     * Simply deleting the existing store:
     [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
     
     * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
     [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
     
     Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
     
     */
    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
#ifdef DEBUG
    abort();
#endif
  }
  
  return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory {
  return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


#pragma mark - NSManagedObjectContext
- (NSManagedObject *)objectWithID:(NSManagedObjectID *)objectID {
  if (objectID != nil) {
		return [self.managedObjectContext objectWithID:objectID];
  } else {
		return nil;
	}
}

- (void)deleteObject:(NSManagedObject *)object {
  [self.managedObjectContext deleteObject:object];
}

- (NSManagedObject*)insertNewObjectForEntityForName:(NSString*)entityName {
  return [NSEntityDescription insertNewObjectForEntityForName:entityName
                                       inManagedObjectContext:self.managedObjectContext];
}

- (void)deleteObjectByID:(NSManagedObjectID *)objectID {
  NSManagedObject *object = [self objectWithID:objectID];
  [self deleteObject:object];
}
- (NSEntityDescription*)entityForName:(NSString*)entityName {
  return [NSEntityDescription entityForName:entityName inManagedObjectContext:self.managedObjectContext];
}

- (NSArray *)executeFetchRequest:(NSFetchRequest *)request
                           error:(NSError **)error {
  return [self.managedObjectContext executeFetchRequest:request
                                                  error:error];
}


@end
