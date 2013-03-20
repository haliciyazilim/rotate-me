//
//  RMPhotoSelectionImageView.h
//  RotateMe
//
//  Created by Yunus Eren Guzel on 2/7/13.
//  Copyright (c) 2013 Yunus Eren Guzel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMCustomImageView.h"
#import "Photo.h"

@interface RMPhotoSelectionImageView : RMCustomImageView
@property Photo* photo;
+(RMPhotoSelectionImageView*) viewWithPhoto:(Photo*)photo andFrame:(CGRect)frame andScaleSize:(CGSize)imageScaleSize;
- (void) setScoreLabelFontSize:(CGFloat) size;
@end
