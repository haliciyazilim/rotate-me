//
//  RotateMeIpadIAPHelper.m
//  RotateMe
//
//  Created by Yunus Eren Guzel on 3/5/13.
//  Copyright (c) 2013 Yunus Eren Guzel. All rights reserved.
//

#import "RotateMeIpadIAPHelper.h"
#import "RMIpadGallerySelectionItemView.h"

@implementation RotateMeIpadIAPHelper
-(void) setBackground
{
    
    [self.currentStore setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"inapp_bg_ipad.jpg"]]];
    
}

- (void) appendGalleryItemForGallery:(Gallery*)gallery
{
    
    UIView* view = [[RMIpadGallerySelectionItemView alloc] initForInAppPurchaseWithGallery:gallery];
    view.transform = CGAffineTransformTranslate(view.transform, -100, 0);
    view.transform = CGAffineTransformRotate(view.transform, -M_PI*0.06);
    [self.storeContainer addSubview:view];
    
}
@end
