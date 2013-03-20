//
//  RMBundleInitializer.m
//  RotateMe
//
//  Created by Yunus Eren Guzel on 2/4/13.
//  Copyright (c) 2013 Yunus Eren Guzel. All rights reserved.
//

#import "RMBundleInitializer.h"
#import "Photo.h"

@implementation RMBundleInitializer

+ (void)initializeBundle
{
    NSArray* imageNames;
    Gallery* gallery;
    
    imageNames = [NSArray arrayWithObjects:
                  @"test1.jpg",
                  @"test2.jpg",
                  @"test3.jpg",
                  @"test4.jpg",
                  @"test001.jpg",
                  @"test002.jpg",
                  @"test003.jpg",
                  @"test004.jpg",
                  @"test005.jpg",
                  nil];
    [RMBundleInitializer copyImages:imageNames forGallery:DEFAULT_GALLERY_NAME];
    gallery = [Gallery createGalleryWithName:DEFAULT_GALLERY_NAME];
    gallery.isPurchased = YES;
    [[RMDatabaseManager sharedInstance] saveContext];
    [RMBundleInitializer insertImages:imageNames forGallery:gallery];
        
    imageNames = [NSArray arrayWithObjects:
                  @"banana_1.jpg",
                  @"banana_2.jpg",
                  @"banana_3.jpg",
                  @"banana_4.jpg",
                  @"banana_5.jpg",
                  @"banana_6.jpg",
                  @"banana_7.jpg",
                  @"banana_8.jpg",
                  @"banana_9.jpg",
                  @"banana_10.jpeg",
                  @"banana_11.jpg",
                  nil];
    [RMBundleInitializer copyImages:imageNames forGallery:BANANA_GALLERY_NAME];
    gallery = [Gallery createGalleryWithName:BANANA_GALLERY_NAME];
    gallery.isPurchased = YES;
    [[RMDatabaseManager sharedInstance] saveContext];
    [RMBundleInitializer insertImages:imageNames forGallery:gallery];
    
    gallery = [Gallery createGalleryWithName:USER_GALLERY_NAME];
    gallery.isPurchased = YES;
    [[RMDatabaseManager sharedInstance] saveContext];
}


+ (void) copyImages:(NSArray*) imageNames forGallery:(NSString*)galleryName
{
    for(NSString* imageName in imageNames){
        NSError *error;
        NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        NSString *sourcePath = [[NSBundle mainBundle] resourcePath];
//        sourcePath = [sourcePath stringByAppendingPathComponent:@"gallery"];
//        sourcePath = [sourcePath stringByAppendingPathComponent:galleryName];
        sourcePath = [sourcePath stringByAppendingPathComponent:imageName];
        
        NSString *folderPath = [documentsDirectory stringByAppendingPathComponent:galleryName];
        
        [[NSFileManager defaultManager] createDirectoryAtPath:folderPath
                                  withIntermediateDirectories:NO
                                                   attributes:nil
                                                        error:&error];
        
        folderPath = [folderPath stringByAppendingPathComponent:imageName];
        
        
        [[NSFileManager defaultManager] copyItemAtPath:sourcePath
                                                toPath:folderPath
                                                 error:&error];
        
    }
}

+ (void) insertImages:(NSArray*)imageNames forGallery:(Gallery*)gallery
{
    for(NSString* imageName in imageNames){
        [Photo createPhotoWithFileName:imageName andGallery:gallery];
    }
}

@end
