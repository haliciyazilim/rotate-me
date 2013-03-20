//
//  RMDatabaseManager.h
//  RotateMe
//
//  Created by Yunus Eren Guzel on 2/4/13.
//  Copyright (c) 2013 Yunus Eren Guzel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMDatabaseManager : NSObject


@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (RMDatabaseManager *)sharedInstance;

- (NSURL *)applicationDocumentsDirectory;
- (void)saveContext;
- (BOOL)isEmpty;
- (NSManagedObject*) createEntity:(NSString*)entityName;

- (NSMutableArray *)entitiesWithRequest:(NSFetchRequest *)request forName:(NSString*)entitiyName;
- (NSManagedObject *)entityWithRequest:(NSFetchRequest *)request forName:(NSString*)entitiyName;

-(void)deleteObject:(NSManagedObject*)managedObject;

@end
