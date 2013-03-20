//
//  RMInGameIPadViewController.m
//  RotateMe
//
//  Created by Eren Halici on 07.02.2013.
//  Copyright (c) 2013 Yunus Eren Guzel. All rights reserved.
//

#import "RMInGameIPadViewController.h"
#import "RMPhotoSelectionIPadViewController.h"
#import "RMImage.h"
#import "RMIpadInGameMenuView.h"
#import "RMIpadInGameWinScreenView.h"

@interface RMInGameIPadViewController ()

@end

@implementation RMInGameIPadViewController
{
    
}

+(RMInGameIPadViewController *)lastInstance
{
    return lastInstance;
}

static RMInGameIPadViewController* lastInstance = nil;


- (int) tileSize {
    if(getCurrentDifficulty() == EASY){
        return 198;
    }
    else if(getCurrentDifficulty() == NORMAL){
        return 132;
    }
    else {
        return 99;
    }
}

- (int) photoHolderTopPadding {
    if(getCurrentDifficulty() == NORMAL) {
        return 11;
    } else {
        return 11;
    }
}

- (CGFloat) timerFontSize
{
    return 34.0;
}

- (int) photoHolderLeftPadding {
    if(getCurrentDifficulty() == NORMAL) {
        return 17;
    } else {
        return 16;
    }
}

- (UIImage*) photoHolderNormalImage
{
    return [UIImage imageNamed:@"photo_holder_normal_ipad.png"];
}
- (void) setBackground {
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"game_bg_ipad.jpg"]]]; 
}
- (IBAction)displayMenu:(id)sender
{
    [self.menuButton setEnabled:NO];
    
    UIView* view = [[RMIpadInGameMenuView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width)];
    view.tag = 1234;
    [self.view addSubview:view];
    
}
- (void) showWinScreen
{
    [RMIpadInGameWinScreenView showWinScreenWithScore:[self.stopWatch toStringWithoutMiliseconds] forInGameViewController:self];
}
- (void)viewDidUnload {
    [self setTimerHolder:nil];
    [self setMenuButton:nil];
    [super viewDidUnload];
}
@end


