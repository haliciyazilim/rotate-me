//
//  RMInGameViewController.m
//  RotateMe
//
//  Created by Yunus Eren Guzel on 1/31/13.
//  Copyright (c) 2013 Yunus Eren Guzel. All rights reserved.
//

#import "RMInGameViewController.h"
#import "RMPhotoSelectionViewController.h"
#import "RMImage.h"
#import "RMInGameWinScreenView.h"
#import "RMInGameMenuView.h"


@interface RMInGameViewController ()

@end

@implementation RMInGameViewController
{
    int rows;
    int cols;
    int tileSize;
    RMImage* currentImage;
    BOOL isGameFinished;
    int photoHolderTopPadding;
    int photoHolderLeftPadding;
    int scaleFactor;
    UIActivityIndicatorView* indicator;
}


+(RMInGameViewController *)lastInstance
{
    return lastInstance;
}

static RMInGameViewController* lastInstance = nil;

-(id) init
{
    if(self = [super init]){
    
    }
    return self;
}

- (void) setBackground {
    if([[UIScreen mainScreen] bounds].size.height == 568){
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"game_bg-568h.jpg"]]];
    }
    else{
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"game_bg.jpg"]]];
        
    }
}

- (int)tileSize {
    if(getCurrentDifficulty() == EASY){
        return 90;
    }
    else if(getCurrentDifficulty() == NORMAL){
        return 61;
    }
    else {
        return 45;
    }
}

- (int) photoHolderTopPadding {
    if(getCurrentDifficulty() == NORMAL) {
        return 4;
    } else {
        return 5;
    }
}

- (int) photoHolderLeftPadding {
    if(getCurrentDifficulty() == NORMAL) {
        return 6;
    } else {
        return 7;
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setBackground];
    if ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] &&
        ([UIScreen mainScreen].scale == 2.0)) {
        scaleFactor = 2;
    } else {
        scaleFactor = 1;
    }
    lastInstance = self;
    isGameFinished = NO;
    self.stopWatch = [[RMStopWatch alloc] init];
    
    if(getCurrentDifficulty() == EASY){
        rows = 3;
        cols = 4;
    }
    else if(getCurrentDifficulty() == NORMAL){
        rows = 4;
        cols = 6;
    }
    else if(getCurrentDifficulty() == HARD){
        rows = 6;
        cols = 8;
    }
    
    tileSize = [self tileSize];
    photoHolderTopPadding = [self photoHolderTopPadding];
    photoHolderLeftPadding = [self photoHolderLeftPadding];
    
    if(getCurrentDifficulty() == NORMAL){
        [self.photoHolder setImage:[self photoHolderNormalImage]];
        self.photoHolder.frame = CGRectMake(self.photoHolder.frame.origin.x-6, self.photoHolder.frame.origin.y+10, self.photoHolder.image.size.width, self.photoHolder.image.size.height);
    }
    [self.stopWatchLabel setFont:[UIFont fontWithName:@"TRMcLean" size:[self timerFontSize]]];
    [self.stopWatchLabel setText:@"00:00"];
    
}


- (UIImage*) photoHolderNormalImage
{
    return [UIImage imageNamed:@"photo_holder_normal.png"];
}

-(void)viewWillAppear:(BOOL)animated
{
    indicator = [[UIActivityIndicatorView alloc] initWithFrame:self.photoHolder.frame];
    [indicator startAnimating];
    [indicator setColor:[UIColor blackColor]];
    [self.view addSubview:indicator];
    NSThread* thread = [[NSThread alloc] initWithTarget:self selector:@selector(configureGame) object:nil];
    [thread start];
}

-(void)viewDidAppear:(BOOL)animated
{
    [[RMPhotoSelectionViewController lastInstance] lighten];
    [self.stopWatch startTimerWithRepeatBlock:^{
        [self.stopWatchLabel setText:[self.stopWatch toStringWithoutMiliseconds]];
    }];
}

- (void) setImage:(RMImage*)image
{
    if(currentImage != image){
        currentImage = image;
    }
}

- (CGFloat) timerFontSize
{
    return 20.0;
}

- (BOOL) isGameFinished
{
    return isGameFinished;
}

- (BOOL) canGameFinish
{
    BOOL isFinished = YES;
    for(RMCroppedImageView* croppedImage in self.croppedImages){
        if([croppedImage getCurrentRotationState] != 0)
            isFinished = NO;
    }
    return isFinished;
}

- (void) endGame
{
    isGameFinished = YES;
    [self.stopWatch stopTimer];
    [currentImage.owner setScore:[self.stopWatch getElapsedSeconds] forDifficulty:getCurrentDifficulty()];
    
    for(RMCroppedImageView* croppedImage in self.croppedImages){
        [croppedImage removeFromSuperview];
    }
    [self showWinScreen];
}

- (void) showWinScreen
{
    [RMInGameWinScreenView showWinScreenWithScore:[self.stopWatch toStringWithoutMiliseconds] forInGameViewController:self];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void) configureGame
{
    CGSize canvasSize = CGSizeMake(cols * tileSize * scaleFactor, rows * tileSize * scaleFactor);
    NSMutableArray* croppedImages = [[NSMutableArray alloc] init];
    
    UIImage* resizedImage = [currentImage imageByScalingAndCroppingForSize:canvasSize];
    self.hiddenImage = [[UIImageView alloc] initWithImage:resizedImage];
    self.hiddenImage.frame = CGRectMake(photoHolderLeftPadding, photoHolderTopPadding, cols * tileSize, rows * tileSize);
    [self.photoHolder addSubview:self.hiddenImage];
    [self.hiddenImage setClipsToBounds:YES];
    [self.hiddenImage setContentMode:UIViewContentModeScaleAspectFill];
    for(int x=0; x<cols; x++){
        for(int y=0; y<rows; y++){
            CGRect rect;
            if ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] &&
                ([UIScreen mainScreen].scale == 2.0)) {
                rect = CGRectMake(x*tileSize*2, y*tileSize*2, tileSize*2, tileSize*2);
            } else {
                rect = CGRectMake(x*tileSize, y*tileSize, tileSize, tileSize);
            }
            
            CGImageRef imageRef = CGImageCreateWithImageInRect([resizedImage CGImage], rect);
            UIImage *img = [UIImage imageWithCGImage:imageRef];
            RMCroppedImageView* imgView = [[RMCroppedImageView alloc] initWithImage:img];
            imgView.frame = CGRectMake(photoHolderLeftPadding+x*tileSize, photoHolderTopPadding+y*tileSize, tileSize, tileSize);
            
            if(arc4random()%100 < 10)
                [imgView setRotationStateTo: M_PI * 0.0];
            else if(arc4random()%100 < 40)
                [imgView setRotationStateTo: M_PI * 0.5];
            else if(arc4random()%100 < 70)
                [imgView setRotationStateTo: M_PI * 1.0];
            else if(arc4random()%100 < 100)
                [imgView setRotationStateTo: M_PI * 1.5];

            [self.photoHolder addSubview:imgView];
            imgView.parent = self;
            [croppedImages addObject:imgView];
                        
        }
    }
    self.croppedImages = croppedImages;
    [indicator removeFromSuperview];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [self setStopWatchLabel:nil];
    [self setTimerHolder:nil];
    [self setMenuButton:nil];
    [super viewDidUnload];
}
- (IBAction)displayMenu:(id)sender
{
    [self.menuButton setEnabled:NO];
    
    UIView* view = [[RMInGameMenuView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width)];
    view.tag = 1234;
    [self.view addSubview:view];
}

-(void) returnToMainMenu:(UIButton*)button
{
    [self dismissViewControllerAnimated:YES completion:^{

    }];
}

-(void)resumeGame:(UIButton*)button
{
    [(RMInGameMenuView*)[self.view viewWithTag:1234] removeFromSuperviewOnCompletion:^{
        [self.menuButton setEnabled:YES];
    }];
}

-(void) restartGame:(UIButton*)button
{
//    NSLog(@"I'm here");
    [[RMPhotoSelectionViewController lastInstance] darken];
    [self dismissViewControllerAnimated:YES completion:^{
        [[RMPhotoSelectionViewController lastInstance] restart];
    }];
    
}

@end


