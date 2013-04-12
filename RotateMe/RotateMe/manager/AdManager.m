//
//  AdManager.m
//  Equify
//
//  Created by Eren Halici on 27.03.2013.
//  Copyright (c) 2013 Halıcı. All rights reserved.
//

#define kAdRepeatMin 3
#define kAdRepeatMax 5

#import "AdManager.h"
#import "FlurryAds.h"
#import "RotateMeIAPHelper.h"

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

static AdManager *sharedInstance = nil;

@interface AdManager ()

@property (copy) CallbackBlock callbackBlock;
@property int adCountDown;

@end

@implementation AdManager

- (void)fetch {
    [FlurryAds fetchAdForSpace:@"RotateMe"
                         frame:[UIScreen mainScreen].bounds
                          size:FULLSCREEN];
}

+ (AdManager *)sharedInstance
{
    @synchronized (self) {
        if (sharedInstance == nil) {
            sharedInstance = [[self alloc] init];
        }
    }
    
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.adCountDown = arc4random_uniform(kAdRepeatMax - kAdRepeatMin) + kAdRepeatMin - 1;
        
        [self fetch];
    }
    return self;
}

- (void)showAdOnView:(UIView*)view
           withBlock:(CallbackBlock)callbackBlock {
    self.callbackBlock = callbackBlock;

    if (SYSTEM_VERSION_LESS_THAN(@"6.0")) {
        // code here
        callbackBlock();
        self.callbackBlock = nil;
        return;
    }

    
    if ([[RotateMeIAPHelper sharedInstance] isPro]){
        callbackBlock();
        self.callbackBlock = nil;
    } else {
        if (self.adCountDown == 0) {
            if ([FlurryAds adReadyForSpace:@"RotateMe"]) {
                self.adCountDown = arc4random_uniform(kAdRepeatMax - kAdRepeatMin) + kAdRepeatMin - 1;
                [FlurryAds displayAdForSpace:@"RotateMe"
                                      onView:view];
                [FlurryAds setAdDelegate:self];
                
            } else {
                self.adCountDown = 0;
                [self fetch];
                callbackBlock();
                self.callbackBlock = nil;
            }
            
        } else {
            self.adCountDown--;
            callbackBlock();
            self.callbackBlock = nil;
        }
    }
}

- (BOOL) spaceShouldDisplay:(NSString*)adSpace interstitial:(BOOL)
interstitial {
    if (interstitial) {
        // Pause app state here
    }
    
    // Continue ad display
    return YES;
}

- (void)spaceDidDismiss:(NSString *)adSpace interstitial:(BOOL)interstitial {
    if (interstitial) {
        // Resume app state here
        
        [self fetch];
        
        self.callbackBlock();
        self.callbackBlock = nil;
    }
}

@end
