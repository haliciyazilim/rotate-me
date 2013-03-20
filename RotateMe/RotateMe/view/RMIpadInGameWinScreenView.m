//
//  RMIpadInGameWinScreenView.m
//  RotateMe
//
//  Created by Yunus Eren Guzel on 3/1/13.
//  Copyright (c) 2013 Yunus Eren Guzel. All rights reserved.
//

#import "RMIpadInGameWinScreenView.h"

@implementation RMIpadInGameWinScreenView

+ (RMInGameWinScreenView*) showWinScreenWithScore:(NSString*)score forInGameViewController:(RMInGameViewController*) inGameViewController
{
    return [[RMIpadInGameWinScreenView alloc] initWithScore:score andInGameViewController:inGameViewController];
}

- (CGRect) hiddenImageTargetFrame
{
    return  CGRectMake(50, 100, 512, 400);
}
- (CGRect) newPhotoHolderImageFrame
{
    return CGRectMake(44, 91, 534, 489);
}

- (CGRect) restartButtonFrame
{
    return CGRectMake(670, 370, 252, 83);
}
- (CGRect) menuButtonFrame
{
    return CGRectMake(670, 270, 252, 83);
}
-(void) appendNewViewControllerBackground
{
    [self setControllerBackground:[UIImage imageNamed:@"inapp_bg_ipad.jpg"]];
}
- (CGRect)scoreFrame
{
    return CGRectMake(100, 530, 150, 60);
}
-(CGFloat) scoreFontSize
{
    return 50.0;
}

-(CGFloat) imageRadius
{
    return 10.0;
}
- (UIImage*) youwinPhotoHolderImage
{
    return [UIImage imageNamed:@"youwin_photo_bg_ipad.png"];
}

- (CGFloat) buttonFontSize
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
