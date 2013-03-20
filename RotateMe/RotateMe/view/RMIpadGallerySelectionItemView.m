//
//  RMIpadGallerySelectionItemView.m
//  RotateMe
//
//  Created by Yunus Eren Guzel on 2/28/13.
//  Copyright (c) 2013 Yunus Eren Guzel. All rights reserved.
//

#import "RMIpadGallerySelectionItemView.h"
#import "RotateMeIpadIAPHelper.h"

@implementation RMIpadGallerySelectionItemView

-(CGRect) getBorderImageViewFrame
{
    return CGRectMake(30,20,430/2,394/2);
}

-(CGSize) getPhotoImageSize
{
    return CGSizeMake(408/2, 310/2);
}

-(CGRect) getPhotoImageFrame
{
    return CGRectMake(5, 4, [self getPhotoImageSize].width, [self getPhotoImageSize].height);
}

-(CGRect) getGallleryItemFrame
{
    return CGRectMake(0, 0, 500, 400);
}

-(CGRect) getGalleryNameLabelFrame
{
    return CGRectMake(0, [self getBorderImageViewFrame].size.height - 35, [self getBorderImageViewFrame].size.width, 27);
}

- (UIImage*) maskImage
{
    return [UIImage imageNamed:@"gallery_selection_mask_ipad.png"];
}

- (UIImage*) borderImage
{
    return [UIImage imageNamed:@"gallery_selection_bg_ipad.png"];
}
-(CGFloat) galleryNameFontSize
{
    return 20.0;
}

-(UIImage*) lockImage
{
    return [UIImage imageNamed:@"icon_locked_ipad.png"];
}
@end
