//
//  IAPHelper.h
//  RotateMe
//
//  Created by Alperen Kavun on 13.02.2013.
//  Copyright (c) 2013 Yunus Eren Guzel. All rights reserved.
//

#import <StoreKit/StoreKit.h>

#define IAPHelperProductPurchasedNotification @"IAPHelperProductPurchasedNotification"
#define IAPHelperEnableBuyButtonNotification @"IAPHelperEnableBuyButtonNotification"

typedef void (^RequestProductsCompletionHandler)(BOOL success, NSArray * products);

@interface IAPHelper : NSObject

@property NSDictionary *iProducts;
@property NSArray* products;
@property UIView* currentStore;
@property UIView* storeContainer;

- (id)initWithProductsDictionary:(NSDictionary *)products;
- (void)requestProductsWithCompletionHandler:(RequestProductsCompletionHandler)completionHandler;

- (BOOL)canMakePurchases;
- (BOOL)productPurchased:(NSString *)productIdentifier;
- (void)buyProduct:(SKProduct *)product;
- (void)restoreCompletedTransactions;
- (void)addActivityToView:(UIView *)view withFrame:(CGRect)frame;
- (void)removeActivity;
-(NSString*) sha1:(NSString*)input;
- (void)provideContentForProductIdentifier:(NSString *)productIdentifier;

@end