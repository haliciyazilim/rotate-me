//
//  RMAboutUsView.m
//  RotateMe
//
//  Created by Yunus Eren Guzel on 3/13/13.
//  Copyright (c) 2013 Yunus Eren Guzel. All rights reserved.
//

#import "RMAboutUsView.h"

@implementation RMAboutUsView
{
    UIView* contentView;
}

- (id) init
{
    if(self = [super init]){
        [self setFrame];
        [self configureView];
    }
    return self;
}

- (void) setBackground
{
    [self setBackgroundColor:[UIColor redColor]];
}

- (void) setFrame
{
    self.frame = CGRectMake(0.0, 0.0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width);
}

- (void) configureView
{
    [self setBackground];
    [self configureContentView];
    [self addSubview:contentView];
}

- (void) configureContentView
{
    contentView = [[UIView alloc] initWithFrame:[self contentViewFrame]];
    [contentView setBackgroundColor:[UIColor blueColor]];

    
}

- (CGSize) contentViewSize
{
    return CGSizeMake(400, 300);
}

- (CGRect) contentViewFrame
{
    return CGRectMake(self.frame.size.width * 0.5 - [self contentViewSize].width * 0.5, self.frame.size.height * 0.5 - [self contentViewSize].height * 0.5, [self contentViewSize].width, [self contentViewSize].height);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
}

@end
