//
//  RMStopWatch.m
//  RotateMe
//
//  Created by Yunus Eren Guzel on 2/4/13.
//  Copyright (c) 2013 Yunus Eren Guzel. All rights reserved.
//

#import "RMStopWatch.h"

@implementation RMStopWatch
{
    NSTimer *timer;
    int seconds;
    int minutes;
    int miliseconds;
    BOOL isPaused;
    IteratorBlock updateBlock;
    double totalPausedTimeInterval;
    NSDate *startTime;
    NSDate *lastPausedTime;
    
}

- (id) init {
    if(self = [super init]){
        seconds = 0;
        minutes = 0;
        miliseconds = 0;
        isPaused = NO;
        return self;
    }
    return nil;
}

- (void) startTimerWithRepeatBlock:(IteratorBlock)block
{
    isPaused = NO;
    updateBlock = block;
    startTime = [NSDate date];
    totalPausedTimeInterval = 0;
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(updateTimer:) userInfo:nil repeats:YES];
    [runloop addTimer:timer forMode:NSRunLoopCommonModes];
    [runloop addTimer:timer forMode:UITrackingRunLoopMode];
}

- (void) updateTimer:(NSTimer*)timer
{
    if (!isPaused) {
        
        double interval = (double)[[NSDate date] timeIntervalSinceDate:startTime];
        miliseconds = (int)((interval - (int)interval) * 1000);
        seconds = (int)floor(interval) % 60;
        minutes = (int)floor(interval) / 60;
        
        updateBlock();
    }
}

-(void)resumeTimer
{
    totalPausedTimeInterval += (double)[[NSDate date] timeIntervalSinceDate:lastPausedTime];
    lastPausedTime = nil;
    isPaused = NO;
}

-(void) pauseTimer
{
    isPaused = YES;
    if (!lastPausedTime) {
        lastPausedTime = [NSDate date];
    }
}

-(void)resetTimer
{
    minutes = 0;
    seconds = 0;
    miliseconds = 0;
    totalPausedTimeInterval = 0;
    startTime = [NSDate date];
    lastPausedTime = nil;
    [self startTimerWithRepeatBlock:updateBlock];
}

-(void) stopTimer
{
    [timer invalidate];
    timer = nil;
}
- (NSString *)toString
{
    return [RMStopWatch textWithMiliseconds:[self getElapsedMiliseconds]];
}
- (NSString*) toStringWithoutMiliseconds
{
    NSString *wholeString = [self toString];
    return [wholeString substringToIndex:[wholeString rangeOfString:@"."].location];
}

+ (NSString*) textWithMiliseconds:(int)totalMiliseconds
{
    int minutes = totalMiliseconds / 60000;
    int seconds = (totalMiliseconds % 60000) / 1000;
    int miliseconds = totalMiliseconds % 1000;
    NSString* minutesString = minutes < 10 ? [NSString stringWithFormat:@"0%d",minutes] : [NSString stringWithFormat:@"%d",minutes];
    
    NSString* secondsString = seconds < 10 ? [NSString stringWithFormat:@"0%d",seconds] : [NSString stringWithFormat:@"%d",seconds];
    
    NSString* milisecondsString = [NSString stringWithFormat:@"%d",miliseconds/100];
    
    return [NSString stringWithFormat:@"%@:%@.%@",minutesString,secondsString,milisecondsString];
}


- (int) getElapsedMiliseconds
{
    return minutes * 60 * 1000 + seconds * 1000 + miliseconds;
}


- (int) getElapsedSeconds
{
    return minutes * 60 + seconds;
}

@end
