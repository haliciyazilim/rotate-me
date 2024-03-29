//
//  RMGallerySelectionIPadViewController.m
//  RotateMe
//
//  Created by Eren Halici on 06.02.2013.
//  Copyright (c) 2013 Yunus Eren Guzel. All rights reserved.
//

#import "RMGallerySelectionIPadViewController.h"
#import "RMIpadGallerySelectionItemView.h"
#import "RMIpadSettingsView.h"
#import "RotateMeIpadIAPHelper.h"

@interface RMGallerySelectionIPadViewController ()

@end

@implementation RMGallerySelectionIPadViewController

- (CGSize) scrollViewItemSize{
    return CGSizeMake(350,300);
}

-(void) setBackground
{
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"selection_bg_ipad.jpg"]]];	
}

- (RMGallerySelectionItemView*) generateGallerySelectionItemViewWithGallery:(Gallery*)gallery animate:(BOOL)animate
{
    return [[RMIpadGallerySelectionItemView alloc] initWithGallery:gallery animate:YES];
}
- (IBAction)openSettings:(id)sender {
    RMSettingsView* settings = [[RMIpadSettingsView alloc] init];
    [self.view addSubview:settings];
}
- (void) openInAppPurchaseForGallery:(Gallery*)gallery
{
    [[RotateMeIpadIAPHelper sharedInstance] showProduct:gallery onViewController:self];
    
}
- (int) rowCount
{
    return 2;
}
- (CGFloat) leftMargin
{
    return 40.0;
}

-(CGFloat) topMargin
{
    return 40.0;
}

- (IBAction)openGameCenter {
    if(!self.reachability)
        self.reachability = [Reachability reachabilityForInternetConnection];
    
    NetworkStatus netStatus = [self.reachability currentReachabilityStatus];
    
    if(netStatus == NotReachable){
        UIAlertView *noConnection = [[UIAlertView alloc] initWithTitle:@""
                                                               message:NSLocalizedString(@"CONNECTION_ERROR", nil)
                                                              delegate:self
                                                     cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                                     otherButtonTitles:nil,nil];
        [noConnection show];
    }
    else{
        GKGameCenterViewController *gameCenterController = [[GKGameCenterViewController alloc] init];
        if (gameCenterController != nil){
            gameCenterController.gameCenterDelegate = self;
            [self presentViewController:gameCenterController animated:YES completion:nil];
        }
    }
    
}

@end
