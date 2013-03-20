//
//  RMInGameViewController.h
//  RotateMe
//
//  Created by Yunus Eren Guzel on 1/31/13.
//  Copyright (c) 2013 Yunus Eren Guzel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMStopWatch.h"
#import "RMCroppedImageView.h"

@interface RMInGameViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *photoHolder;
@property (weak, nonatomic) IBOutlet UIImageView *timerHolder;

@property (weak, nonatomic) IBOutlet UILabel *stopWatchLabel;

@property UIImageView* hiddenImage;

- (IBAction)displayMenu:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;

@property NSArray* croppedImages;

@property RMStopWatch* stopWatch;

+(RMInGameViewController*)lastInstance;

- (void) setImage:(UIImage*)image;

- (BOOL) isGameFinished;

- (void) endGame;

- (BOOL) canGameFinish;

-(void) restartGame:(UIButton*)button;

-(void)resumeGame:(UIButton*)button;

-(void) returnToMainMenu:(UIButton*)button;
@end
