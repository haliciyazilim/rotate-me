//
//  RMAppDelegate.m
//  RotateMe
//
//  Created by Yunus Eren Guzel on 1/31/13.
//  Copyright (c) 2013 Yunus Eren Guzel. All rights reserved.
//

#import "RMAppDelegate.h"
#import "RMPhotoSelectionViewController.h"
#import "RMBundleInitializer.h"
#import "Photo.h"
#import "GameCenterManager.h"
#import "RotateMeIAPHelper.h"


@implementation RMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    if([[RMDatabaseManager sharedInstance] isEmpty]){
        [RMBundleInitializer initializeBundle];
    }
    
    
    //GameCenter
    [[GameCenterManager sharedInstance] authenticateLocalUser];
    
//    [[RotateMeIAPHelper sharedInstance] requestProductsWithCompletionHandler:^(BOOL success, NSArray *products) {
//        if (!success) {
//            NSLog(@"problem when getting products");
//        }
//        for (SKProduct* product in products) {
//            [[RotateMeIAPHelper sharedInstance] setProducts:products];
//            NSLog(@"found product, \ntitle: %@, \nid: %@, \nlocalized description: %@\n----------------------\n", product.localizedTitle ,product.productIdentifier,product.localizedDescription);
//            NSLog(@"%@",[[RotateMeIAPHelper sharedInstance] getProductWithProductIdentifier:product.productIdentifier]);
////            [self buyYourGallery];
//        }
//    }];
    
    return YES;
}
//- (void) buyYourGallery {
//    [[RotateMeIAPHelper sharedInstance] buySelectedProduct:0];
//}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
