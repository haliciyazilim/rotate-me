//
//  RMImage.h
//  RotateMe
//
//  Created by Yunus Eren Guzel on 2/5/13.
//  Copyright (c) 2013 Yunus Eren Guzel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"


@interface RMImage : UIImage

@property Photo* owner;
- (RMImage*) imageWithGaussianBlur9;
- (RMImage*) imageByScalingAndCroppingForSize:(CGSize)targetSize;
@end
