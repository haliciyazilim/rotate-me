//
//  Gallery.h
//  RotateMe
//
//  Created by Yunus Eren Guzel on 2/4/13.
//  Copyright (c) 2013 Yunus Eren Guzel. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "RMDatabaseManager.h"

@interface Gallery : NSManagedObject

@property NSString* name;
@property NSSet* photos;
@property BOOL isPurchased;

+ (NSMutableArray*) allGalleries;

+ (Gallery*) createGalleryWithName:(NSString*)name;

+ (Gallery*) getGalleryWithName:(NSString *)name;

- (NSArray*) allPhotos;

- (void) purchaseGallery;

@end
