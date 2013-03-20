//
//  Gallery.m
//  RotateMe
//
//  Created by Yunus Eren Guzel on 2/4/13.
//  Copyright (c) 2013 Yunus Eren Guzel. All rights reserved.
//

#import "Gallery.h"
#import "PhotoManagedObject.h"
#import "Photo.h"

@implementation Gallery
@dynamic name;
@dynamic photos;
@dynamic isPurchased;

+ (Gallery*) createGalleryWithName:(NSString*)name
{
    Gallery* gallery = (Gallery*)[[RMDatabaseManager sharedInstance] createEntity:@"Gallery"];
    gallery.name = name;
    gallery.isPurchased = NO;
    [[RMDatabaseManager sharedInstance] saveContext];
    return gallery;
}

+ (NSMutableArray*) allGalleries
{
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    return [[RMDatabaseManager sharedInstance] entitiesWithRequest:request forName:@"Gallery"];
}

+ (Gallery*) getGalleryWithName:(NSString *)name
{
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"name == %@ ", name];
    [request setPredicate:predicate];
    return (Gallery *)[[RMDatabaseManager sharedInstance] entityWithRequest:request forName:@"Gallery"];

}
- (NSArray*) allPhotos
{
    NSMutableArray* array = [[NSMutableArray alloc] init];
    [self.photos enumerateObjectsUsingBlock:^(PhotoManagedObject* obj, BOOL *stop) {
        [array addObject:[Photo photoWithManagedObject:obj]];
    }];
    
    [array sortUsingComparator:^NSComparisonResult(Photo* obj1, Photo* obj2) {
        return [obj1.filename compare:obj2.filename];
    }];
    return array;
}

- (void) purchaseGallery
{
    self.isPurchased = YES;
    [[RMDatabaseManager sharedInstance] saveContext];
}

@end
