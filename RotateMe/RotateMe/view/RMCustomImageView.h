//
//  RMCustomImageView.h
//  RotateMe
//
//  Created by Yunus Eren Guzel on 2/1/13.
//  Copyright (c) 2013 Yunus Eren Guzel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TypeDefs.h"

@interface RMCustomImageView : UIImageView

-(void)setTouchesBegan:(IteratorBlock)block;
-(BOOL)isInsideTouchesBegan;
@end
