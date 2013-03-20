//
//  RMInGameMenuView.h
//  RotateMe
//
//  Created by Yunus Eren Guzel on 2/20/13.
//  Copyright (c) 2013 Yunus Eren Guzel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TypeDefs.h"

@interface RMInGameMenuView : UIView

-(id) initWithFrame:(CGRect)frame;
- (void) removeFromSuperviewOnCompletion:(IteratorBlock)block;

-(void) stylizeButton:(UIButton*)button;
@end
