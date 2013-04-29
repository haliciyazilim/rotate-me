//
//  RMAboutUsView.m
//  RotateMe
//
//  Created by Yunus Eren Guzel on 3/13/13.
//  Copyright (c) 2013 Yunus Eren Guzel. All rights reserved.
//

#import "RMAboutUsView.h"
#import "RMStopWatch.h"
#import <QuartzCore/QuartzCore.h>
#import "Config.h"

@implementation RMAboutUsView
{
    UIView* contentView;
    RMStopWatch* stopWatch;
    int didScrolled;
    UIView * aboutScreen;
    UIScrollView * credits;
    
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
//    [self setBackgroundColor:[UIColor redColor]];
    if([[UIScreen mainScreen] bounds].size.height == 568){
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"inapp_bg-568h.png"]];
    }
    else if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"inapp_bg_ipad.jpg"]];
    }
    else{
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"inapp_bg.png"]];
    }
}

- (void) setFrame
{
    self.frame = CGRectMake(0.0, 0.0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width);
}

- (void) configureView
{
    [self setBackground];
    [self showAboutScreen];
    
    
}

-(void) showAboutScreen{
    
    CGFloat winWidth = self.frame.size.width;
    CGFloat winHeight= self.frame.size.height;
    
    aboutScreen = self;
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake((winWidth-(winWidth-35.0))/2, 0.0, winWidth-35.0, 45.0)];
    [headerLabel setBackgroundColor:[UIColor clearColor]];
    [headerLabel setFont:[UIFont fontWithName:@"TRMcLeanBold" size:30.0]];
    [headerLabel setTextColor:LIGHT_BROWN_TEXT_COLOR];
    [headerLabel setShadowOffset:CGSizeMake(0.0, 1.0)];
    [headerLabel setShadowColor:[UIColor whiteColor]];
    [headerLabel setTextAlignment:NSTextAlignmentCenter];
    [headerLabel setText:NSLocalizedString(@"ABOUT", nil)];
    
    UIView *headerDoubleLine = [[UIView alloc] initWithFrame:CGRectMake((winWidth-(winWidth/3))/2, 45.0, winWidth/3, 3.0)];
    [headerDoubleLine setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"double_line.png"]]];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"delete_photo_btn.png"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    closeButton.frame = CGRectMake(winWidth-45.0, 5.0, 35.0, 35.0);
    
    UIView * mask=[[UIView alloc]initWithFrame:CGRectMake(20, 60, winWidth-40, winHeight-60)];
    [mask setBackgroundColor:[UIColor clearColor]];
    mask.clipsToBounds=YES;
    
    credits=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, winWidth, winHeight-60)];
    [credits setBackgroundColor:[UIColor clearColor]];
    //    [credits setUserInteractionEnabled:NO];
    [credits setContentSize:CGSizeMake(winWidth-40, 700+110)];
    [credits setShowsHorizontalScrollIndicator:NO];
    [credits setShowsVerticalScrollIndicator:NO];
    
    float fontSizeL = 22.0;
    float fontSizeM = 20.0;
    NSString *fontHeader = @"TRMcLeanBold";
    NSString *font = @"TRMcLeanBold";
    UIColor *color = LIGHT_BROWN_TEXT_COLOR;
    
    // Company Name
    UILabel * cName=[[UILabel alloc] initWithFrame:CGRectMake(0.0, 40, mask.frame.size.width, 22.0)];
    [cName setFont:[UIFont fontWithName:fontHeader size:fontSizeL]];
    [cName setTextColor:color];
    [cName setTextAlignment:NSTextAlignmentCenter];
    [cName setBackgroundColor:[UIColor clearColor]];
    [cName setText:@"HALICI BİLGİ İŞLEM A.Ş."];
    
    // Adress
    UILabel * cAdress=[[UILabel alloc] initWithFrame:CGRectMake(0.0, 50, mask.frame.size.width, 120)];
    [cAdress setFont:[UIFont fontWithName:@"TRMcLean" size:fontSizeM]];
    [cAdress setTextColor:color];
    [cAdress setTextAlignment:NSTextAlignmentCenter];
    [cAdress setBackgroundColor:[UIColor clearColor]];
    [cAdress setNumberOfLines:3];
    [cAdress setText:@"ODTÜ-Halıcı Yazılımevi \nİnönü Bulvarı 06531 \nODTÜ-Teknokent/ANKARA"];
    
    // Mail
    UILabel * cMail=[[UILabel alloc] initWithFrame:CGRectMake(0.0, 150, mask.frame.size.width, 40.0)];
    [cMail setFont:[UIFont fontWithName:font size:fontSizeM]];
    [cMail setTextColor:color];
    [cMail setTextAlignment:NSTextAlignmentCenter];
    [cMail setBackgroundColor:[UIColor clearColor]];
    [cMail setText:@"iletisim@halici.com.tr"];
    
    
    // Programming
    UILabel * cProgramming=[[UILabel alloc] initWithFrame:CGRectMake(0.0, 200, mask.frame.size.width, 40.0)];
    [cProgramming setFont:[UIFont fontWithName:fontHeader size:fontSizeL]];
    [cProgramming setTextColor:color];
    [cProgramming setTextAlignment:NSTextAlignmentCenter];
    [cProgramming setBackgroundColor:[UIColor clearColor]];
    [cProgramming setText:NSLocalizedString(@"PROGRAMMING",nil)];
    
    
    // Names
    NSArray * names=[[NSArray alloc] initWithObjects:@"Eren HALICI",@"Yunus Eren GÜZEL", @"Abdullah KARACABEY",@"Alperen KAVUN", nil];
    for(int i=0; i<names.count;i++){
        UILabel * cName=[[UILabel alloc] initWithFrame:CGRectMake(0.0, 230+i*30, mask.frame.size.width, 40.0)];
        [cName setFont:[UIFont fontWithName:@"TRMcLean" size:fontSizeM]];
        [cName setTextColor:color];
        [cName setTextAlignment:NSTextAlignmentCenter];
        [cName setBackgroundColor:[UIColor clearColor]];
        [cName setNumberOfLines:2];
        [cName setText:names[i]];
        [credits addSubview:cName];
    }
    
    
    // Art
    UILabel * cArt=[[UILabel alloc] initWithFrame:CGRectMake(0.0, 370, mask.frame.size.width, 40.0)];
    [cArt setFont:[UIFont fontWithName:fontHeader size:fontSizeL]];
    [cArt setTextColor:color];
    [cArt setTextAlignment:NSTextAlignmentCenter];
    [cArt setBackgroundColor:[UIColor clearColor]];
    [cArt setText:NSLocalizedString(@"ART", nil)];
    
    UILabel * cArtName=[[UILabel alloc] initWithFrame:CGRectMake(0.0, 400, mask.frame.size.width, 40.0)];
    [cArtName setFont:[UIFont fontWithName:@"TRMcLean" size:fontSizeM]];
    [cArtName setTextColor:color];
    [cArtName setTextAlignment:NSTextAlignmentCenter];
    [cArtName setBackgroundColor:[UIColor clearColor]];
    [cArtName setNumberOfLines:2];
    [cArtName setText:@"Ebuzer Egemen DURSUN"];
    
    // Photography
    UILabel * cPhotography=[[UILabel alloc] initWithFrame:CGRectMake(0.0, 450, mask.frame.size.width, 40.0)];
    [cPhotography setFont:[UIFont fontWithName:fontHeader size:fontSizeL]];
    [cPhotography setTextColor:color];
    [cPhotography setTextAlignment:NSTextAlignmentCenter];
    [cPhotography setBackgroundColor:[UIColor clearColor]];
    [cPhotography setText:NSLocalizedString(@"PHOTOGRAPHY", nil)];
    
    // Names
    NSArray * photographyNames=[[NSArray alloc] initWithObjects:@"Uğur HALICI",@"Eren HALICI", nil];
    for(int i=0; i<photographyNames.count;i++){
        UILabel * cName=[[UILabel alloc] initWithFrame:CGRectMake(0.0, 480+i*30, mask.frame.size.width, 40.0)];
        [cName setFont:[UIFont fontWithName:@"TRMcLean" size:fontSizeM]];
        [cName setTextColor:color];
        [cName setTextAlignment:NSTextAlignmentCenter];
        [cName setBackgroundColor:[UIColor clearColor]];
        [cName setNumberOfLines:2];
        [cName setText:photographyNames[i]];
        [credits addSubview:cName];
    }
    
    // Copyright
    UILabel * cCRight=[[UILabel alloc] initWithFrame:CGRectMake(0.0, 600+110, mask.frame.size.width, 40.0)];
    [cCRight setFont:[UIFont fontWithName:font size:fontSizeL]];
    [cCRight setTextColor:color];
    [cCRight setTextAlignment:NSTextAlignmentCenter];
    [cCRight setBackgroundColor:[UIColor clearColor]];
    [cCRight setText:@"Copyright © 2013"];
    
    // BrainQuire
    UILabel * cBrainQuire=[[UILabel alloc] initWithFrame:CGRectMake(0.0, 630+110, mask.frame.size.width, 40.0)];
    [cBrainQuire setFont:[UIFont fontWithName:font size:fontSizeL]];
    [cBrainQuire setTextColor:color];
    [cBrainQuire setTextAlignment:NSTextAlignmentCenter];
    [cBrainQuire setBackgroundColor:[UIColor clearColor]];
    [cBrainQuire setText:@"www.brainquire.com"];

    [credits addSubview:cName];
    [credits addSubview:cAdress];
    [credits addSubview:cMail];
    [credits addSubview:cProgramming];
    [credits addSubview:cArt];
    [credits addSubview:cArtName];
    [credits addSubview:cPhotography];
    [credits addSubview:cCRight];
    [credits addSubview:cBrainQuire];
    [mask addSubview:credits];
    [aboutScreen addSubview:headerLabel];
    [aboutScreen addSubview:headerDoubleLine];
    [aboutScreen addSubview:closeButton];
    [aboutScreen addSubview:mask];

    stopWatch = [[RMStopWatch alloc] init];
    [stopWatch startTimerWithRepeatBlock:^{
        
    }];
    [credits setUserInteractionEnabled:YES];
    [UIScrollView beginAnimations:nil context:NULL];
    [UIScrollView setAnimationDuration:30.0f];
    [UIScrollView setAnimationCurve:UIViewAnimationCurveLinear];
    [credits setDelegate:self];
    [credits setContentOffset:CGPointMake(0, 700+110-credits.frame.size.height)];
    [UIScrollView commitAnimations];
    didScrolled=0;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //    NSLog(@"DEBUG: scrollViewDidScroll" );
    didScrolled++;
    
    if(didScrolled==2)
        [self scrollViewTap];
}

-(void) scrollViewTap
{
    [credits.layer removeAllAnimations];
    [stopWatch pauseTimer];
    float timer=[stopWatch getElapsedMiliseconds]/1000.0;
    //    NSLog(@"Touch detected - scrollViewTap: %f",timer);
    [credits.layer removeAllAnimations];
    [credits setContentOffset:CGPointMake(0, (700.0+110-credits.frame.size.height)*timer/30.0)];
    
}

- (void) close
{
    [self removeFromSuperview];
}

@end
