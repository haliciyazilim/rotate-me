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
                  @"01-volls-woyce---büyük.jpg",
                  @"02-12-Ugur-HALICI-01-(29).jpg",
                  @"03-DSC00485.jpg",
                  @"04-12-Ugur-HALICI-15-(4).jpg",
                  @"05-12-Ugur-HALICI-20-(7).jpg",
                  @"06-12-Ugur-HALICI-07-(30).jpg",
                  @"07-12-Ugur-HALICI-07-(24).jpg",
                  @"08-12-Ugur-HALICI-13-(29).jpg",
                  @"09-12-Ugur-HALICI-11-(5).jpg",
                  @"10-12-Ugur-HALICI-18-(12).jpg",
                  @"11-12-Ugur-HALICI-10-(22).jpg",
                  @"12-12-Ugur-HALICI-02-(1).jpg",
                  @"13-ugur-kanarya-(32).jpg",
                  @"14-12-Ugur-HALICI-16-(1).jpg",
                  @"15-kafes-(23).jpg",
                  @"16-12-Ugur-HALICI-23-(32).jpg",
                  @"17-12-Ugur-HALICI-06-(6).jpg",
                  @"18-12-Ugur-HALICI-12-(1).jpg",
                  @"19-DSC09706.jpg",
                  @"20-DSC_2728.jpg",
                  @"21-yakin-(8).jpg",
                  @"22-12-Ugur-HALICI-09-(3).jpg",
                  @"23-12-Ugur-HALICI-24-(16).jpg",
                  nil];
    [RMBundleInitializer copyImages:imageNames forGallery:DEFAULT_GALLERY_NAME];
    gallery = [Gallery createGalleryWithName:DEFAULT_GALLERY_NAME];
    gallery.isPurchased = YES;
    [[RMDatabaseManager sharedInstance] saveContext];
    [RMBundleInitializer insertImages:imageNames forGallery:gallery];
    
    imageNames = [NSArray arrayWithObjects:
                    @"01-12-Ugur-HALICI-20-(11).jpg",
                    @"02-12-Ugur-HALICI-01-(22).jpg",
                    @"03-venedik.JPG",
                    @"04-underground.JPG",
                    @"05-12-Ugur-HALICI-21-(16).jpg",
                    @"06-12-Ugur-HALICI-23-(11).jpg",
                    @"07-12-Ugur-HALICI-20-(13).jpg",
                    @"08-12-Ugur-HALICI-20-(21).jpg",
                    @"09-12-Ugur-HALICI-17-(12).jpg",
                    @"10-12-Ugur-HALICI-17-(26).jpg",
                    @"11-12-Ugur-HALICI-01-(2).jpg",
                    @"12-12-Ugur-HALICI-01-(11).jpg",
                    @"13-12-Ugur-HALICI-01-(1).jpg",
                    @"14-12-Ugur-HALICI-14-(2).jpg",
                    @"15-12-Ugur-HALICI-14-(17).jpg",
                    @"16-12-Ugur-HALICI-14-(25).jpg",
                    @"17-12-Ugur-HALICI-14-(15).jpg",
                    @"18-12-Ugur-HALICI-11-(28).jpg",
                    @"19-12-Ugur-HALICI-11-(35).jpg",
                    @"20-12-Ugur-HALICI-20-(26).jpg",
                    @"21-koc.JPG",
                    @"22-12-Ugur-HALICI-20-(20).jpg",
                    @"23-DSC_5950.JPG",
                  nil];
    [RMBundleInitializer copyImages:imageNames forGallery:ARCHITECTURE_GALLERY_NAME];
    gallery = [Gallery createGalleryWithName:ARCHITECTURE_GALLERY_NAME];
    gallery.isPurchased = NO;
    [[RMDatabaseManager sharedInstance] saveContext];
    [RMBundleInitializer insertImages:imageNames forGallery:gallery];

    
    
    imageNames = [NSArray arrayWithObjects:
                    @"01-12-Ugur-HALICI-01-(3).jpg",
                    @"02-12-Ugur-HALICI-20-(10).jpg",
                    @"03-12-Ugur-HALICI-14-(3).jpg",
                    @"04-12-Ugur-HALICI-10-(4).jpg",
                    @"05-12-Ugur-HALICI-10-(35).jpg",
                    @"06-12-Ugur-HALICI-18-(22).jpg",
                    @"07-12-Ugur-HALICI-23-(28).jpg",
                    @"08-12-Ugur-HALICI-22-(14).jpg",
                    @"09-12-Ugur-HALICI-02-(6).jpg",
                    @"10-12-Ugur-HALICI-02-(22).jpg",
                    @"11-12-Ugur-HALICI-02-(34).jpg",
                    @"12-12-Ugur-HALICI-18-(25).jpg",
                    @"13-12-Ugur-HALICI-19-(2).jpg",
                    @"14-12-Ugur-HALICI-16-(21).jpg",
                    @"15-12-Ugur-HALICI-15-(16).jpg",
                    @"16-12-Ugur-HALICI-08-(15).jpg",
                    @"17-12-Ugur-HALICI-19-(15).jpg",
                    @"18-12-Ugur-HALICI-10-(2).jpg",
                    @"19-12-Ugur-HALICI-08-(10).jpg",
                    @"20-12-Ugur-HALICI-01-(17).jpg",
                                     nil];
    [RMBundleInitializer copyImages:imageNames forGallery:PATTERN_GALLERY_NAME];
    gallery = [Gallery createGalleryWithName:PATTERN_GALLERY_NAME];
    gallery.isPurchased = NO;
    [[RMDatabaseManager sharedInstance] saveContext];
    [RMBundleInitializer insertImages:imageNames forGallery:gallery];

    
    
    
    imageNames = [NSArray arrayWithObjects:
                        @"01-08.jpg",
                        @"02-12-Ugur-HALICI-01-(5).jpg",
                        @"03-12-Ugur-HALICI-22-(10).jpg",
                        @"04-12-Ugur-HALICI-17-(15).jpg",
                        @"05-12-Ugur-HALICI-01-(20).jpg",
                        @"06-12-Ugur-HALICI-17-(14).jpg",
                        @"07-12-Ugur-HALICI-17-(23).jpg",
                        @"08-12-Ugur-HALICI-01-(4).jpg",
                        @"09-12-Ugur-HALICI-17-(19).jpg",
                        @"10-12-Ugur-HALICI-17-(21).jpg",
                        @"11-12-Ugur-HALICI-17-(17).jpg",
                        @"12-12-Ugur-HALICI-17-(18).jpg",
                        @"13-12-Ugur-HALICI-20-(9).jpg",
                        @"14-12-Ugur-HALICI-17-(20).jpg",
                        @"15-test002.jpg",
                        @"16-12-Ugur-HALICI-23-(41).jpg",
                        @"17-12-Ugur-HALICI-23-(40).jpg",
                        @"18-12-Ugur-HALICI-23-(18).jpg",
                        @"19-12-Ugur-HALICI-06-(28).jpg",
                        @"20-12-Ugur-HALICI-13-(26).jpg",
                        nil];
    [RMBundleInitializer copyImages:imageNames forGallery:WATER_GALLERY_NAME];
    gallery = [Gallery createGalleryWithName:WATER_GALLERY_NAME];
    gallery.isPurchased = NO;
    [[RMDatabaseManager sharedInstance] saveContext];
    [RMBundleInitializer insertImages:imageNames forGallery:gallery];
    
    
    
    gallery = [Gallery createGalleryWithName:USER_GALLERY_NAME];
    gallery.isPurchased = NO;
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
