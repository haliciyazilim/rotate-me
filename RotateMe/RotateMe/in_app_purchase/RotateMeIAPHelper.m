//
//  RotateMeIAPHelper.m
//  RotateMe
//
//  Created by Alperen Kavun on 13.02.2013.
//  Copyright (c) 2013 Yunus Eren Guzel. All rights reserved.
//

#import "RotateMeIAPHelper.h"
#import "RotateMeIAPSpecificValues.h"
#import "Gallery.h"
#import <QuartzCore/QuartzCore.h>
#import "RMGallerySelectionViewController.h"
#import "RMGallerySelectionItemView.h"

@implementation RotateMeIAPHelper
{
    NSString *currentProductIdentifier;
    UILabel *descriptionLabel;
    UILabel *priceLabel;
    UIButton *buyButton;
    UIActivityIndicatorView *activity;
    Gallery *currentGallery;
    UIViewController *currentController;
    BOOL canShowCompletedAlert;
}

+ (RotateMeIAPHelper *)sharedInstance {
    static dispatch_once_t once;
    static RotateMeIAPHelper * sharedInstance;
    dispatch_once(&once, ^{
        NSDictionary *products = @{iYourGalleryKey : iYourGallerySecret,
                                   iSportsGalleryKey : iSportsGallerySecret};
        sharedInstance = [[self alloc] initWithProductsDictionary:products];
        [[NSNotificationCenter defaultCenter] addObserver:sharedInstance selector:@selector(productPurchaseCompleted:) name:IAPHelperProductPurchasedNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:sharedInstance selector:@selector(enableBuyButton) name:IAPHelperEnableBuyButtonNotification object:nil];
    });
    return sharedInstance;
}

- (void)productPurchaseCompleted:(NSNotification *)notif {
    currentGallery = nil;
    currentController = nil;
    [self closeStore];
    
    [self enableBuyButton];
    if (canShowCompletedAlert) {
        UIAlertView *productPurchased = [[UIAlertView alloc] initWithTitle:@""
                                                                   message:NSLocalizedString(@"PRODUCT_PURCHASE_COMPLETED", nil)
                                                                  delegate:self
                                                         cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                                         otherButtonTitles:nil,nil];
        [productPurchased show];
        canShowCompletedAlert = NO;
    }
}
- (void) provideContentForProductIdentifier:(NSString *)productIdentifier {
    Gallery* gallery = [Gallery getGalleryWithName:productIdentifier];
    [gallery purchaseGallery];
    [super provideContentForProductIdentifier:productIdentifier];
}

-(void) setBackground
{
    CGFloat currentScreenWidth = [[UIScreen mainScreen] bounds].size.height;
    if(currentScreenWidth == 568){
        [self.currentStore setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"inapp_bg-568h.png"]]];
    }
    else{
        [self.currentStore setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"inapp_bg.png"]]];
    }
}

- (void) appendGalleryItemForGallery:(Gallery*)gallery
{
    
    UIView* view = [[RMGallerySelectionItemView alloc] initForInAppPurchaseWithGallery:gallery];
    view.transform = CGAffineTransformRotate(view.transform, -M_PI*0.06);
    [self.storeContainer addSubview:view];
    
}

- (void) showProduct:(Gallery*)gallery onViewController:(UIViewController*) viewController
{
    canShowCompletedAlert = YES;
    currentGallery = gallery;
    currentController = viewController;
    CGFloat currentScreenWidth = [[UIScreen mainScreen] bounds].size.height;
    CGFloat currentScreenHeight = [[UIScreen mainScreen] bounds].size.width;
    
    activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [activity setHidesWhenStopped:YES];
    [activity startAnimating];
    activity.frame = CGRectMake(241.0, 115.0, 60.0, 60.0);
    
    CGRect frame = viewController.view.frame;
    currentProductIdentifier = [NSString stringWithString:gallery.name];
    
    self.currentStore = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x,frame.origin.y,frame.size.height,frame.size.width)];
    
    
    self.storeContainer = [[UIView alloc] initWithFrame:CGRectMake((currentScreenWidth-438.0)*0.5, (currentScreenHeight-278.0)*0.5, 438.0, 278.0)];
    [self.storeContainer setBackgroundColor:[UIColor clearColor]];
    
    [self setBackground];
    
    [self appendGalleryItemForGallery:gallery];
    
    // alloc, init and customize description label here
    descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(219.0, 65.0, 219.0, 106.0)];
    [descriptionLabel setBackgroundColor:[UIColor clearColor]];
    [descriptionLabel setNumberOfLines:7];
    [descriptionLabel setFont:[UIFont fontWithName:@"TRMcLean" size:18.0]];
    [descriptionLabel setTextColor:[UIColor whiteColor]];
    [descriptionLabel setShadowColor:[UIColor colorWithWhite:0.0 alpha:0.6]];
    [descriptionLabel setShadowOffset:CGSizeMake(0.0, 1.0)];
    
    // alloc, init and customize price label here
    priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(219.0, 170.0, 112.0, 30.0)];
    [priceLabel setBackgroundColor:[UIColor clearColor]];
    [priceLabel setFont:[UIFont fontWithName:@"TRMcLeanBold" size:18.0]];
    [priceLabel setTextColor:[UIColor whiteColor]];
    [priceLabel setShadowColor:[UIColor colorWithWhite:0.0 alpha:0.6]];
    [priceLabel setShadowOffset:CGSizeMake(0.0, 1.0)];
    
    // alloc, init, customize and add target to buy button here
    buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [buyButton setFrame:CGRectMake(219.0, 215.0, 99.0, 36.0)];
    [buyButton setBackgroundImage:[UIImage imageNamed:@"buy_btn_bg.png"] forState:UIControlStateNormal];
    [buyButton setBackgroundImage:[UIImage imageNamed:@"buy_btn_bg_hover.png"] forState:UIControlStateHighlighted];
    buyButton.layer.cornerRadius = 7.0;
    UILabel *buyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 97.0, 34.0)];
    [buyLabel setBackgroundColor:[UIColor clearColor]];
    [buyLabel setFont:[UIFont fontWithName:@"TRMcLeanBold" size:18]];
    [buyLabel setTextColor:[UIColor colorWithRed:0.420 green:0.227 blue:0.082 alpha:1.0]];
    [buyLabel setShadowColor:[UIColor whiteColor]];
    [buyLabel setShadowOffset:CGSizeMake(0.0, 1.0)];
    [buyLabel setText:NSLocalizedString(@"BUY_NOW", nil)];
    [buyLabel setTextAlignment:NSTextAlignmentCenter];
    [buyButton addSubview:buyLabel];
    
    // alloc, init, customize and add target to close button here
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setFrame:CGRectMake(394.0, 0.0, 42.0, 42.0)];
    UIImageView *closeImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"delete_photo_btn.png"]];
    [closeImage setFrame:CGRectMake(10.0, 10.0, 21.0, 21.0)];
    [closeButton addTarget:self action:@selector(closeStore) forControlEvents:UIControlEventTouchUpInside];
    [closeButton addSubview:closeImage];
    
    [self.storeContainer addSubview:activity];
    [self.storeContainer addSubview:descriptionLabel];
    [self.storeContainer addSubview:priceLabel];
    [self.storeContainer addSubview:buyButton];
    [self.storeContainer addSubview:closeButton];
    
    [self.currentStore addSubview:self.storeContainer];
    
    [viewController.view addSubview:self.currentStore];
    
    if (!self.products) {
        [self requestProductsWithCompletionHandler:^(BOOL success, NSArray *products) {
            NSLog(@"%d products found",[products count]);
            if ([self isPro]) {
                NSLog(@"yes it is pro!");
            } else {
                NSLog(@"no it is not pro!");
            }
            self.products = products;
            [self productBlock];
        }];
    } else {
        [self productBlock];
    }
}
- (void) productBlock {
    [activity stopAnimating];
    NSNumberFormatter *priceFormatter = [[NSNumberFormatter alloc] init];
    [priceFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [priceFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    SKProduct *myProduct = [self getProductWithProductIdentifier:currentProductIdentifier];
    
    [priceFormatter setLocale:myProduct.priceLocale];
    
    NSString *priceStr = [priceFormatter stringFromNumber:[myProduct price]];
    NSString *descriptionStr = [myProduct localizedDescription];
    
    [descriptionLabel setText:descriptionStr];
    [priceLabel setText:priceStr];
    [buyButton addTarget:self action:@selector(buyCurrentProduct) forControlEvents:UIControlEventTouchUpInside];
}
- (SKProduct *) getProductWithProductIdentifier:(NSString *)productIdentifier {
    for (SKProduct* product in self.products) {
//        NSLog(@"%@, and %@",productIdentifier, product.productIdentifier);
        if ([product.productIdentifier isEqualToString:productIdentifier]) {
            return product;
        }
    }
    return nil;
}
- (void)closeStore {
    activity = nil;
    priceLabel = nil;
    descriptionLabel = nil;
    buyButton = nil;
    self.storeContainer = nil;
    [self.currentStore removeFromSuperview];
    self.currentStore = nil;

    currentProductIdentifier = nil;
}
- (void) buyCurrentProduct {
    [self disableBuyButton];
    if([[RotateMeIAPHelper sharedInstance] canMakePurchases]){
        [[RotateMeIAPHelper sharedInstance] buyProduct:[[RotateMeIAPHelper sharedInstance] getProductWithProductIdentifier:currentProductIdentifier]];
    }
    else{
        UIAlertView *couldNotMakePurchasesAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"IN_APP_PURCHASES", nil)
                 message:NSLocalizedString(@"COULD_NOT_MAKE_PURCHASES", nil)
                delegate:self
       cancelButtonTitle:NSLocalizedString(@"OK", nil)
       otherButtonTitles:nil,nil];
        [couldNotMakePurchasesAlert show];
    }
}

- (void)restorePurchases {
    canShowCompletedAlert = YES; 
    [[RotateMeIAPHelper sharedInstance] restoreCompletedTransactions];
}

- (BOOL) isProductPurchased:(NSString *)productKey {
    return [self productPurchased:productKey];
}
- (BOOL)isPro {
    NSString *device = [[UIDevice currentDevice] name];
    NSString *proString = [NSString stringWithFormat:@"%@%@",iProSecret,device];
    
    if ([[[NSUserDefaults standardUserDefaults] stringForKey:iProKey] isEqualToString:[self sha1:proString]]) {
        return YES;
    } else {
        return NO;
    }
}
- (void) disableBuyButton {
    [buyButton setEnabled:NO];
}
- (void) enableBuyButton {
    [buyButton setEnabled:YES];
}
@end
