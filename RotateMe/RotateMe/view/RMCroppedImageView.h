//
//  RMCroppedImageView.h
//  RotateMe
//
//  Created by Yunus Eren Guzel on 2/4/13.
//  Copyright (c) 2013 Yunus Eren Guzel. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RMInGameViewController;

@interface RMCroppedImageView : UIView

@property RMInGameViewController* parent;
@property UIImageView *imageView;

-(id)initWithImage:(UIImage *)image;

- (void) rotateToAngle:(float)angle;
- (void) setRotationStateTo:(int)state;
- (int) getCurrentRotationState;
@end
