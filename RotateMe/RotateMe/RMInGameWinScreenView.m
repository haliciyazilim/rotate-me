//
//  RMInGameWinScreenView.m
//  RotateMe
//
//  Created by Yunus Eren Guzel on 2/19/13.
//  Copyright (c) 2013 Yunus Eren Guzel. All rights reserved.
//

#import "RMInGameWinScreenView.h"
#import "RMInGameViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Config.h"
#import "RMPhotoSelectionViewController.h"


@implementation RMInGameWinScreenView
{
    NSString* score;
    RMInGameViewController* inGameViewController;
    CGRect hiddenImageTargetFrame;
    CGFloat rotationAmount;
}

+ (RMInGameWinScreenView*) showWinScreenWithScore:(NSString*)score forInGameViewController:(RMInGameViewController*) inGameViewController
{
    return [[RMInGameWinScreenView alloc] initWithScore:score andInGameViewController:inGameViewController];
}

- (id) initWithScore:(NSString*) _score andInGameViewController:(RMInGameViewController*) _inGameViewController
{
    if(self = [super init]){
        score = _score;
        inGameViewController = _inGameViewController;
        rotationAmount = -M_PI*0.044;
        [self cleanViewControllerImagesWithAnimation];
    }
    return self;
}

- (CGRect) hiddenImageTargetFrame
{
    return  CGRectMake(0, 0, 248, 200);
}

- (void) cleanViewControllerImagesWithAnimation
{
    hiddenImageTargetFrame = [self hiddenImageTargetFrame];
    [inGameViewController.hiddenImage setClipsToBounds:YES];
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        inGameViewController.hiddenImage.frame = CGRectMake(
                    -inGameViewController.photoHolder.frame.origin.x,
                    -inGameViewController.photoHolder.frame.origin.y,
                    [[UIScreen mainScreen] bounds].size.height,
                    [[UIScreen mainScreen] bounds].size.width);
        [inGameViewController.menuButton setAlpha:0.0];
    } completion:^(BOOL finished) {
        [self appendNewPhotoHolderImage];
        [inGameViewController.stopWatchLabel setAlpha:0.0];
        [inGameViewController.timerHolder setAlpha:0.0];
        [inGameViewController.menuButton setAlpha:0.0];
        [self appendNewViewControllerBackground];
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            inGameViewController.hiddenImage.frame = hiddenImageTargetFrame;
            inGameViewController.hiddenImage.transform = CGAffineTransformRotate(inGameViewController.hiddenImage.transform, rotationAmount);
            inGameViewController.photoHolder.transform = CGAffineTransformMakeTranslation(20, 20);
            
        } completion:^(BOOL finished) {
            [inGameViewController.hiddenImage.layer setCornerRadius:[self imageRadius]];
            [inGameViewController.hiddenImage.layer setBorderWidth:0.5];
            [inGameViewController.hiddenImage.layer setBorderColor:[UIColor whiteColor].CGColor];
            [inGameViewController.hiddenImage setClipsToBounds:YES];
            [self showButtons];
        }];
    }];
}
-(CGFloat) imageRadius
{
    return 3.0;
}
-(void) appendNewViewControllerBackground
{
    if([[UIScreen mainScreen] bounds].size.height == 568){
        [self setControllerBackground:[UIImage imageNamed:@"inapp_bg-568h.png"]];
    }
    else{
        [self setControllerBackground:[UIImage imageNamed:@"inapp_bg.png"]];
    }
}

- (void) setControllerBackground:(UIImage*)image
{
    [inGameViewController.view setBackgroundColor:[UIColor colorWithPatternImage:image]];
}

- (CGRect) newPhotoHolderImageFrame
{
    return CGRectMake(-5, -5, 262, 240);
}

- (UIImage*) youwinPhotoHolderImage
{
    return [UIImage imageNamed:@"youwin_photo_bg.png"];
}

-(void) appendNewPhotoHolderImage
{
    inGameViewController.photoHolder.image = nil;
    UIImageView* newPhotoHolderImage = [[UIImageView alloc] initWithImage:[self youwinPhotoHolderImage]];
    CGRect frame = [self newPhotoHolderImageFrame];
    newPhotoHolderImage.frame = frame;
    [inGameViewController.photoHolder addSubview:newPhotoHolderImage];
    
    [inGameViewController.photoHolder insertSubview:newPhotoHolderImage belowSubview:inGameViewController.hiddenImage];
    newPhotoHolderImage.transform = CGAffineTransformRotate(newPhotoHolderImage.transform, rotationAmount);
    [self appendScore];
}

-(void) showButtons{
    
    UIButton* menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [menuButton setTitle:@"Main Menu" forState:UIControlStateNormal];
    [self stylizeButton:menuButton];
    [menuButton addTarget:inGameViewController action:@selector(returnToMainMenu:) forControlEvents:UIControlEventTouchUpInside];
    [inGameViewController.view addSubview:menuButton];
    
    UIButton* restartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [restartButton setTitle:@"Restart" forState:UIControlStateNormal];
    [self stylizeButton:restartButton];
    [restartButton addTarget:inGameViewController action:@selector(restartGame:) forControlEvents:UIControlEventTouchUpInside];
    [inGameViewController.view addSubview:restartButton];
    
    [restartButton setFrame:[self restartButtonFrame]];
    [menuButton setFrame:[self menuButtonFrame]];

    restartButton.transform = CGAffineTransformMakeScale(1.0, 0.5);
    menuButton.transform = CGAffineTransformMakeScale(1.0, 0.5);
    [UIView animateWithDuration:0.15 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        restartButton.transform = CGAffineTransformMakeScale(1, 1);
        menuButton.transform = CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finished) {
        
    }];
    
}

- (CGRect) restartButtonFrame
{
    if([[UIScreen mainScreen] bounds].size.height == 568){
        return CGRectMake(360, 170, 154, 36);
    }
    else{
        return CGRectMake(320, 170, 154, 36);
    }
}
- (CGRect) menuButtonFrame
{
    if([[UIScreen mainScreen] bounds].size.height == 568){
        return CGRectMake(360, 120, 154, 36);
    }
    else{
        return CGRectMake(320, 120, 154, 36);
    }
}

- (CGFloat) buttonFontSize
{
    return 16.0;
}

-(void) stylizeButton:(UIButton*)button
{
    [button.titleLabel setFont:[UIFont fontWithName:@"TRMcLeanBold" size:[self buttonFontSize]]];
    [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [button setTitleColor:BROWN_TEXT_COLOR forState:UIControlStateNormal];
    [button setTitleColor:BROWN_TEXT_COLOR forState:UIControlStateHighlighted];
    [button setTitleColor:BROWN_TEXT_COLOR forState:UIControlStateSelected];
    [button setBackgroundImage:[UIImage imageNamed:@"youwin_btn_bg.png"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"youwin_btn_bg_hover.png"] forState:UIControlStateHighlighted];
    [button setBackgroundImage:[UIImage imageNamed:@"youwin_btn_bg_hover.png"] forState:UIControlStateSelected];
}

-(void) appendScore
{
    UILabel* label = [[UILabel alloc] init];
    [label setFrame:[self scoreFrame]];
    [label setFont:[UIFont fontWithName:@"TRMcLeanBold" size:[self scoreFontSize]]];
    [label setText:score];
    [label setTextColor:BROWN_TEXT_COLOR];
    [label setShadowColor:[UIColor colorWithWhite:0.0 alpha:0.3]];
    [label setShadowOffset:CGSizeMake(0.0, 1.0)];
    [label setBackgroundColor:[UIColor clearColor]];
    label.transform = CGAffineTransformRotate(label.transform, rotationAmount);
    [inGameViewController.photoHolder addSubview:label];
    [inGameViewController.photoHolder insertSubview:label belowSubview:inGameViewController.hiddenImage];
    [label setAlpha:0.0];
    [UIView animateWithDuration:1.0 animations:^{
        [label setAlpha:1.0];
    }];
}

- (CGRect)scoreFrame
{
    return CGRectMake(30, 205, 150, 30);
}

- (CGFloat) scoreFontSize
{
    return 20.0;
}

@end
