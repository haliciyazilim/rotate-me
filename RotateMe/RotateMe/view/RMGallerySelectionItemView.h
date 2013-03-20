//
//  RMGallerySelectionItemView.h
//  RotateMe
//
//  Created by Yunus Eren Guzel on 2/11/13.
//  Copyright (c) 2013 Yunus Eren Guzel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMCustomImageView.h"
@class Gallery;

@interface RMGallerySelectionItemView : RMCustomImageView

- (id) initWithGallery:(Gallery*) _gallery animate:(BOOL)animate;

- (id) initForInAppPurchaseWithGallery:(Gallery *)_gallery;

-(void)setLocked;

@end
