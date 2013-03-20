//
//  Photo.m
//  RotateMe
//
//  Created by Yunus Eren Guzel on 2/4/13.
//  Copyright (c) 2013 Yunus Eren Guzel. All rights reserved.
//

#import "Photo.h"
#import "RMDatabaseManager.h"
#import "RMImage.h"
#import "GameCenterManager.h"

@implementation Photo
{
    RMImage* image;
    RMImage* thumbnailImage;
    PhotoManagedObject* managedObject;
}

+ (Photo*) photoWithManagedObject:(PhotoManagedObject*)managedObject
{
    return [[Photo alloc] initWithManagedObject:managedObject];
}

- (id) initWithManagedObject:(PhotoManagedObject*)_managedObject
{
    managedObject = _managedObject;
    self.filename = managedObject.filename;
    self.gallery = managedObject.gallery;
    return self;
}

- (void)setThumbnailImage:(RMImage *)_thumbnailImage
{
    thumbnailImage = _thumbnailImage;
    thumbnailImage.owner = self;
    
}

- (RMImage*) getThumbnailImage
{
    return thumbnailImage;
}


+ (Photo*)createPhotoWithFileName:(NSString*)fileName andGallery:(Gallery*)gallery
{
    PhotoManagedObject* photo = (PhotoManagedObject*)[[RMDatabaseManager sharedInstance] createEntity:@"Photo"];
    photo.filename = fileName;
    photo.gallery = gallery;
    [[RMDatabaseManager sharedInstance] saveContext];
    [[NSNotificationCenter defaultCenter] postNotificationName:kPhotoNotificationPhotoCreated object:photo];
    return [Photo photoWithManagedObject:photo];
}

- (void) setScore:(int)elapsedTime forDifficulty:(DIFFICULTY)difficulty
{
    Score* score = [self getScoreForDifficulty:difficulty];
    if(score == nil){
        score = (Score*)[[RMDatabaseManager sharedInstance] createEntity:@"Score"];
        score.photo = managedObject;
        score.difficulty = difficulty;
        score.elapsedSeconds = elapsedTime;
    }
    else if(score.elapsedSeconds > elapsedTime){
        score.elapsedSeconds = elapsedTime;
    }
    [[GameCenterManager sharedInstance] submitScore:elapsedTime category:[NSString stringWithFormat:@"%@_mode",stringOfDifficulty(difficulty)]];
    
    //TEST
    [[GameCenterManager sharedInstance] getScores];

    [[RMDatabaseManager sharedInstance] saveContext];

}
- (Score*) getScoreForDifficulty:(DIFFICULTY)difficulty
{
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"photo == %@ && difficulty == %d", managedObject, difficulty];
    [request setPredicate:predicate];
    return (Score*)[[RMDatabaseManager sharedInstance] entityWithRequest:request forName:@"Score"];
}

- (NSString *)getImagePath {
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *folderPath = [documentsDirectory stringByAppendingPathComponent:self.gallery.name];
    return [folderPath stringByAppendingPathComponent:self.filename];
}

- (RMImage*) getImage
{
    if(image == nil){
        image = [[RMImage alloc] initWithContentsOfFile:[self getImagePath]];
        image.owner = self;
    }
    return image;
}

- (void) removeFromDatabase
{
    [[RMDatabaseManager sharedInstance] deleteObject:managedObject];

    NSError *error;
    if ([[NSFileManager defaultManager] removeItemAtPath:[self getImagePath] error:&error] != YES) {
        NSLog(@"Unable to delete file: %@", [error localizedDescription]);
    }

    [[NSNotificationCenter defaultCenter] postNotificationName:kPhotoNotificationPhotoDeleted object:self];
}

@end
