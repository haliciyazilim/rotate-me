//
//  RMIpadInGameMenuView.m
//  RotateMe
//
//  Created by Yunus Eren Guzel on 3/1/13.
//  Copyright (c) 2013 Yunus Eren Guzel. All rights reserved.
//

#import "RMIpadInGameMenuView.h"

@implementation RMIpadInGameMenuView

-(void) setBackground
{
    [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"inapp_bg_ipad.jpg"]]];
}

- (CGSize) buttonSize
{
    return CGSizeMake(252, 83);
}

- (CGFloat) fontSize
{
    return 32.0;
}


-(void) stylizeButton:(UIButton*)button
{
    [super stylizeButton:button];
    [button setBackgroundImage:[UIImage imageNamed:@"ingame_btn_bg_ipad.png"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"ingame_btn_bg_hover_ipad.png"] forState:UIControlStateHighlighted];
    [button setBackgroundImage:[UIImage imageNamed:@"ingame_btn_bg_hover_ipad.png"] forState:UIControlStateSelected];
}
@end
