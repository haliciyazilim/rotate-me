//
//  RotateMeIAPHelper.h
//  RotateMe
//
//  Created by Alperen Kavun on 13.02.2013.
//  Copyright (c) 2013 Yunus Eren Guzel. All rights reserved.
//

#import "IAPHelper.h"
@class Gallery;

@interface RotateMeIAPHelper : IAPHelper

+ (RotateMeIAPHelper *) sharedInstance;

- (BOOL) isProductPurchased:(NSString *)productKey;
- (void) showProduct:(Gallery*)gallery onViewController:(UIViewController*) viewController;
- (SKProduct *)getProductWithProductIdentifier:(NSString *)productIdentifier;

- (BOOL)isPro;
@end
