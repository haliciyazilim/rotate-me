//
//  RMInGameWinScreenView.h
//  RotateMe
//
//  Created by Yunus Eren Guzel on 2/19/13.
//  Copyright (c) 2013 Yunus Eren Guzel. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RMInGameViewController;

@interface RMInGameWinScreenView : UIView
+ (RMInGameWinScreenView*) showWinScreenWithScore:(NSString*)score forInGameViewController:(RMInGameViewController*) inGameViewController;

- (id) initWithScore:(NSString*) _score andInGameViewController:(RMInGameViewController*) _inGameViewController;

- (void) setControllerBackground:(UIImage*)image;

-(void) stylizeButton:(UIButton*)button;

@end
