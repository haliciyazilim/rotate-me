//
//  RMCustomImageView.m
//  RotateMe
//
//  Created by Yunus Eren Guzel on 2/1/13.
//  Copyright (c) 2013 Yunus Eren Guzel. All rights reserved.
//

#import "RMCustomImageView.h"

@implementation RMCustomImageView

{
    IteratorBlock touchBeganBlock;
    BOOL isInsideTouchesBegan;
}


-(void)setTouchesBegan:(IteratorBlock)block
{
    touchBeganBlock = block;
}

-(BOOL)isInsideTouchesBegan
{
    return isInsideTouchesBegan;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    isInsideTouchesBegan = YES;
    if(touchBeganBlock != nil)
        touchBeganBlock();
    isInsideTouchesBegan = NO;
}

@end
