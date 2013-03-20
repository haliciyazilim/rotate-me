//
//  RMInGameMenuView.m
//  RotateMe
//
//  Created by Yunus Eren Guzel on 2/20/13.
//  Copyright (c) 2013 Yunus Eren Guzel. All rights reserved.
//

#import "RMInGameMenuView.h"
#import "Config.h"
#import "RMInGameViewController.h"

#import <QuartzCore/QuartzCore.h>

@implementation RMInGameMenuView

-(id) initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        [self setBackground];
        [self showButtons];
        self.alpha = 0.0;

        [UIView animateWithDuration:0.5 animations:^{
            self.alpha = 1.0;
        }];
    }
    return self;
}

- (CGSize) buttonSize
{
    return CGSizeMake(166, 53);
}

- (CGFloat) fontSize
{
    return 16.0;
}

-(void) showButtons
{
    CGSize buttonSize = [self buttonSize];
    UIButton* mainMenu = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton* restart = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton* resume = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [mainMenu setTitle:@"Main Menu" forState:UIControlStateNormal];
    [restart setTitle:@"Restart" forState:UIControlStateNormal];
    [resume setTitle:@"Resume" forState:UIControlStateNormal];
    	
    NSArray* buttons = [NSArray arrayWithObjects:resume,restart,mainMenu,nil];
    
    int index = 0;
    CGFloat margin = 20;
    for(UIButton* button in buttons){
        button.frame = CGRectMake(
                                  self.frame.size.width*0.5 - buttonSize.width*0.5,
                                  self.frame.size.height*0.5 - [buttons count]*(margin+buttonSize.height)*0.5 + margin*0.5 + index * (buttonSize.height+margin),
                                  buttonSize.width,
                                  buttonSize.height);
        [self addSubview:button];
        [self stylizeButton:button];
        index++;
    }
    
    [mainMenu addTarget:[RMInGameViewController lastInstance] action:@selector(returnToMainMenu:) forControlEvents:UIControlEventTouchUpInside];
    [restart addTarget:[RMInGameViewController lastInstance] action:@selector(restartGame:) forControlEvents:UIControlEventTouchUpInside];
    [resume addTarget:[RMInGameViewController lastInstance] action:@selector(resumeGame:) forControlEvents:UIControlEventTouchUpInside];
    
}


-(void) stylizeButton:(UIButton*)button
{
    [button.titleLabel setFont:[UIFont fontWithName:@"TRMcLeanBold" size:[self fontSize]]];
    [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [button setTitleColor:BROWN_TEXT_COLOR forState:UIControlStateNormal];
    [button setTitleColor:BROWN_TEXT_COLOR forState:UIControlStateHighlighted];
    [button setTitleColor:BROWN_TEXT_COLOR forState:UIControlStateSelected];
    [button setBackgroundImage:[UIImage imageNamed:@"ingame_btn_bg.png"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"ingame_btn_bg_hover.png"] forState:UIControlStateHighlighted];
    [button setBackgroundImage:[UIImage imageNamed:@"ingame_btn_bg_hover.png"] forState:UIControlStateSelected];
}

-(void) setBackground
{
    if([[UIScreen mainScreen] bounds].size.height == 568){
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"inapp_bg-568h.png"]]];
    }
    else{
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"inapp_bg.png"]]];
        
    }
    
}
-(void )removeFromSuperviewOnCompletion:(IteratorBlock)block
{
    [UIView animateWithDuration:0.5 delay:0.0 options:0 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        block();
    }];

    
}

@end
