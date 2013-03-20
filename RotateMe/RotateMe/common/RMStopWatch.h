//
//  RMStopWatch.h
//  RotateMe
//
//  Created by Yunus Eren Guzel on 2/4/13.
//  Copyright (c) 2013 Yunus Eren Guzel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TypeDefs.h"
@interface RMStopWatch : NSObject


- (void) pauseTimer;
- (void) resumeTimer;
- (void) resetTimer;
- (void) startTimerWithRepeatBlock:(IteratorBlock)block;
- (void) stopTimer;
- (void) updateTimer:(NSTimer*)timer;
- (int)  getElapsedMiliseconds;

- (int) getElapsedSeconds;

- (NSString*) toString;
- (NSString*) toStringWithoutMiliseconds;

@end
