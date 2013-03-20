//
//  RMIpadSettingsView.m
//  RotateMe
//
//  Created by Yunus Eren Guzel on 3/1/13.
//  Copyright (c) 2013 Yunus Eren Guzel. All rights reserved.
//

#import "RMIpadSettingsView.h"

@implementation RMIpadSettingsView

-(void) setBackground
{
    [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"inapp_bg_ipad.jpg"]]];
}

- (CGSize) getButtonSize
{
    return CGSizeMake(252, 83);
}

-(void) stylizeButton:(UIButton*) button
{
    [super stylizeButton:button];
    [button setBackgroundImage:[UIImage imageNamed:@"ingame_btn_bg_ipad.png"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"ingame_btn_bg_hover_ipad.png"] forState:UIControlStateHighlighted];
    [button setBackgroundImage:[UIImage imageNamed:@"ingame_btn_bg_hover_ipad.png"] forState:UIControlStateSelected];
}
- (CGFloat) fontSize
{
    return 26.0;
}
@end
