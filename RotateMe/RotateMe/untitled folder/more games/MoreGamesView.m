//
//  MoreGamesView.m
//  RotateMe
//
//  Created by Yunus Eren Guzel on 3/13/13.
//  Copyright (c) 2013 Yunus Eren Guzel. All rights reserved.
//

#import "MoreGamesView.h"

#define DI @"downloaded_image"
#define logo1x @"logo1x"
#define logo2x @"logo2x"
#define logo4x @"logo4x"
#define APP_NAME_KEY @"app_name"

static MKNetworkEngine* networkEngine;

@implementation MoreGamesView
{
    UIButton *leftLeftView, *leftView, *centerView, *rightView, *rightRightView;
    UIImageView* backgroundView;
    NSArray* games;
    BOOL isAnimating;
    CGSize gameViewSize;
    int currentIndex,horizontalMargin, x, xConstant, y, movementAmount, startingXLocation;
    CGFloat animationDuration;  
    BOOL isTouchDown;
    UIView* hittedView;
    CGSize closeButtonSize;
    UIButton* closeButton;
    UIActivityIndicatorView* activityIndicator;
    
//    UISwipeGestureRecognizer *swipeLeftGesture;
//    UISwipeGestureRecognizer *swipeRightGesture;
    
}

- (id) init
{
    if(self = [super init]){
        [self setFrame];
        [self setBackground];
        
        [self setAlpha:0.0];
        [UIView animateWithDuration:0.5 animations:^{
            [self setAlpha:1.0];
        }];
        
        currentIndex = 0;
        movementAmount = 0;
        startingXLocation = 0;
        animationDuration = 0.2;
        isTouchDown = NO;
        
        [self setLayoutParameters];
        [self downloadGames];
        [self appendCloseButton];
    }
    return self;
}

- (void) downloadGames
{
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [activityIndicator setFrame:self.frame];
    [self addSubview:activityIndicator];
    [activityIndicator startAnimating];
    if(games == nil){
        if(networkEngine == nil){
            networkEngine = [[MKNetworkEngine alloc] initWithHostName:@""];
            [networkEngine useCache];
        }
        MKNetworkOperation* operation = [[MKNetworkOperation alloc]
                                         initWithURLString:@"http://brainquire.herokuapp.com/games.json"
                                         params:@{APP_NAME_KEY:APP_NAME}
                                         httpMethod:@"GET"];
        [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
            NSData *responseJSON = [[completedOperation responseString] dataUsingEncoding:NSUTF8StringEncoding];
            NSArray* response = [NSJSONSerialization JSONObjectWithData:responseJSON options:0 error:nil];
            NSLog(@"%@",response);
            NSMutableArray* gamesMutable = [[NSMutableArray alloc] init];
            for (NSDictionary* game in response) {
                [gamesMutable addObject:[NSMutableDictionary dictionaryWithDictionary:game]];
            }
            games = gamesMutable;
            [self initializeGameImages];
            
        } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
            [self closeView];
        }];
        [[[MKNetworkEngine alloc] initWithHostName:@""] enqueueOperation:operation];
    }
}

- (void) initializeGameImages
{
    __block int index = 0;
    NSString* logoKey;
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] == YES && [[UIScreen mainScreen] scale] == 2.00) {
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
            logoKey = logo4x;
        }else{
            logoKey = logo2x;
        }
    }
    else{
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
            logoKey = logo2x;
        }else{
            logoKey = logo1x;
        }
    }
    for (NSMutableDictionary* game in games) {
        index++;
        
        MKNetworkOperation *op = [[MKNetworkOperation alloc]
                                   initWithURLString:[game objectForKey:logoKey]
                                   params:nil
                                   httpMethod:@"GET"];
        [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
            [game setObject:[completedOperation responseImage] forKey:DI];
            index--;
            if(index <= 0){
                [activityIndicator removeFromSuperview];
                [self configureView];
            }
        } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
            [self closeView];
        }];
        [networkEngine enqueueOperation:op];
    }
}


- (void) setBackground
{
    backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"moregames_bg.jpg"]];
    backgroundView.frame = self.frame;
    [backgroundView setContentMode:UIViewContentModeScaleToFill];
    [self addSubview:backgroundView];
}

- (void) setFrame
{
    self.frame = CGRectMake(0.0, 0.0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width);
}

- (void) configureView
{
    [self setUserInteractionEnabled:YES];
    
    centerView      = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if([games count] >= 2) {
        rightView       = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    
    if([games count] >= 3){
        leftLeftView    = [UIButton buttonWithType:UIButtonTypeCustom];
        leftView        = [UIButton buttonWithType:UIButtonTypeCustom];
        rightRightView  = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    
    [self stylizeButton:leftLeftView];
    [self stylizeButton:leftView];
    [self stylizeButton:centerView];
    [self stylizeButton:rightView];
    [self stylizeButton:rightRightView];
    
    [self addSubview:centerView];
    [self addSubview:rightView];
    [self addSubview:rightRightView];
    [self addSubview:leftView];
    [self addSubview:leftLeftView];

    [self setPositions];
    [self fillButtons];
    
}
- (void) setLayoutParameters
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        gameViewSize = CGSizeMake(560, 400);
        horizontalMargin = 160.0;
        closeButtonSize  = CGSizeMake(40, 40);
    }
    else{
        gameViewSize = CGSizeMake(280, 200);
        horizontalMargin = 80.0;
        closeButtonSize  = CGSizeMake(40, 30);
    }
    y = self.frame.size.height * 0.5 -  gameViewSize.height * 0.5;
    x = self.frame.size.width * 0.5 -  gameViewSize.width * 0.5;
    xConstant =  horizontalMargin +  gameViewSize.width;
}

- (void) appendCloseButton
{
    closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setImage:[UIImage imageNamed:@"more_games_close_btn.png"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    [closeButton setFrame:CGRectMake(self.frame.size.width - closeButtonSize.width, 0, closeButtonSize.width, closeButtonSize.height)];
    [closeButton setContentMode:UIViewContentModeCenter];
    [self addSubview:closeButton];
}

- (void) stylizeButton:(UIButton*)button
{
    [button.layer setBorderColor:[UIColor whiteColor].CGColor];
    [button.layer setBorderWidth:2.0];
    [button.layer setShadowRadius:5.0];
    [button.layer setShadowOffset:CGSizeMake(1, 2)];
    [button.layer setShadowColor:[UIColor blackColor].CGColor];
    [button.layer setShadowOpacity:0.4];
}

- (void) fillButtons
{
    int leftLeftIndex   = currentIndex - 2;
    int leftIndex       = currentIndex - 1;
    int centerIndex     = currentIndex;
    int rightIndex      = currentIndex + 1;
    int rightRightIndex = currentIndex + 2;
    
    while(leftLeftIndex < 0)
        leftLeftIndex = [games count] + leftLeftIndex;
    
    while(leftIndex < 0)
        leftIndex = [games count] + leftIndex;
    
    while(rightIndex >= [games count])
        rightIndex = rightIndex - [games count];
    
    while(rightRightIndex >= [games count])
        rightRightIndex = rightRightIndex - [games count];
    
    [centerView setImage:[self imageForGameAtIndex:centerIndex] forState:UIControlStateNormal];
    
    if([games count] >= 2){
        [rightView setImage:[self imageForGameAtIndex:rightIndex]  forState:UIControlStateNormal];
    }
    
    if([games count] >= 3){
        [rightRightView setImage:[self imageForGameAtIndex:rightRightIndex] forState:UIControlStateNormal];
        [leftLeftView setImage:[self imageForGameAtIndex:leftLeftIndex] forState:UIControlStateNormal];
        [leftView setImage:[self imageForGameAtIndex:leftIndex] forState:UIControlStateNormal];
    }
    [leftView removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    [rightView removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    [centerView removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    
    [leftView  addTarget:self action:@selector(animateRight) forControlEvents:UIControlEventTouchUpInside];
    [rightView addTarget:self action:@selector(animateLeft) forControlEvents:UIControlEventTouchUpInside];
    [centerView addTarget:self action:@selector(redirectToGamePage) forControlEvents:UIControlEventTouchUpInside];
       
    [self becomeFirstResponder];
    [self resignFirstResponder];
    [self reloadInputViews];
    
    isAnimating = NO;
}

- (UIImage *) imageForGameAtIndex:(int) i
{
    return [[games objectAtIndex:i] objectForKey:DI];
}

- (void) redirectToGamePage
{
    NSString* url = [@"itms-apps://itunes.com/apps/" stringByAppendingString:[[games objectAtIndex:currentIndex] objectForKey:APP_NAME_KEY]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

-(void) closeView
{
    [UIView animateWithDuration:0.5 animations:^{
        [self setAlpha:0.0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(isAnimating)
        return;
    UITouch* touch = [touches anyObject];
    startingXLocation = (int)[touch locationInView:self].x;
    movementAmount = 0;
    isTouchDown = YES;
    if([centerView hitTest:[[touches anyObject] locationInView:centerView] withEvent:event] == centerView ){
        [self performSelector:@selector(highlightCenterView) withObject:nil afterDelay:0.1];
    }
}

- (void) highlightCenterView
{
    if(abs(movementAmount) <= 1){
        [centerView.layer setBorderWidth:3.0];
    }
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(isAnimating)
        return;
    if(!isTouchDown)
        return;
    UITouch* touch = [touches anyObject];
    int currentXLocation = (int)[touch locationInView:self].x;
    movementAmount = (currentXLocation - startingXLocation) * 0.5;
    
    if(abs(movementAmount) > gameViewSize.width*1.5)
        movementAmount = (movementAmount > 0 ? 1 : -1) * gameViewSize.width*1.5;
    [self setPositions];
    CGFloat movementRatio = 0.4 * ((CGFloat)abs(movementAmount) / (gameViewSize.width*1.5+1));
    if(movementAmount > 0){
        [leftView   setFrame:[self frameForIndex:-1 withScale:movementRatio+1.0]];
    }
    else{
        [rightView  setFrame:[self frameForIndex:+1 withScale:movementRatio+1.0]];
    }
    [centerView setFrame:[self frameForIndex:0  withScale:0.4-movementRatio+1.0]];
    
    
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    hittedView = [super hitTest:point withEvent:event];
    return self;
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    isTouchDown = NO;
    if(abs(movementAmount) > gameViewSize.width*0.3){
        if(movementAmount < 0){
            if([rightView imageForState:UIControlStateNormal] != nil)
                [self animateLeft];
            else
                [self animateBack];
        }
        else{
            if([leftView imageForState:UIControlStateNormal] != nil)
                [self animateRight];
            else
                [self animateBack];
        }
    }else{
        [self animateBack];
        
    }
    [centerView.layer setBorderWidth:2.0];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if([centerView hitTest:[[touches anyObject] locationInView:centerView] withEvent:event] == centerView && abs(movementAmount) <= 1 ){
        [self redirectToGamePage];
    }
    [self touchesCancelled:touches withEvent:event];
    if([closeButton hitTest:[[touches anyObject] locationInView:closeButton] withEvent:event] == closeButton && abs(movementAmount) <= 1 ){
        [self closeView];
    }
    
}

- (void) animateBack
{
    if(isAnimating)
        return;
    isAnimating = YES;
    movementAmount = 0;
    [UIView animateWithDuration:animationDuration animations:^{
        [leftLeftView   setFrame:[self frameForIndex:-2]];
        [leftView       setFrame:[self frameForIndex:-1]];
        [centerView     setFrame:[self frameForIndex: 0]];
        [rightView      setFrame:[self frameForIndex:+1]];
        [rightRightView setFrame:[self frameForIndex:+2]];
    } completion:^(BOOL finished) {
        isAnimating = NO;
    }];
    
}

- (void) setPositions
{
    [leftLeftView   setFrame:[self frameForIndex:-2]];
    [leftView       setFrame:[self frameForIndex:-1]];
    [centerView     setFrame:[self frameForIndex: 0]];
    [rightView      setFrame:[self frameForIndex:+1]];
    [rightRightView setFrame:[self frameForIndex:+2]];
    
    leftLeftView.alpha = 1.0;
    rightRightView.alpha = 1.0;
}

- (CGRect) frameForIndex:(int)index
{
    if(index != 0){
        return [self frameForIndex:index withScale:1.0];
    }
    else{
        return [self frameForIndex:0 withScale:1.4];
    }
}

- (CGRect) frameForIndex:(int)index withScale:(CGFloat)scale
{
    if(scale < 1.0){
        [[NSException exceptionWithName:@"scale is not acceptable" reason:@"" userInfo:nil] raise];
    }
    return CGRectMake(
                      x + xConstant * index - gameViewSize.width * (scale - 1.0) * 0.5 + movementAmount,
                      y - gameViewSize.height * (scale - 1.0) * 0.5,
                      gameViewSize.width  * scale,
                      gameViewSize.height * scale);
}

- (void) animateLeft
{
    if(isAnimating)
        return;
    isAnimating = YES;
    movementAmount = 0;
    [UIView animateWithDuration:animationDuration animations:^{
        [leftLeftView   setFrame:[self frameForIndex:-3]];
        [leftView       setFrame:[self frameForIndex:-2]];
        [centerView     setFrame:[self frameForIndex:-1]];
        [rightView      setFrame:[self frameForIndex: 0]];
        [rightRightView setFrame:[self frameForIndex:+1]];
    } completion:^(BOOL finished) {
        [self movePointersRight];
    }];
}

- (void) animateRight
{
    if(isAnimating)
        return;
    isAnimating = YES;
    movementAmount = 0;
    [UIView animateWithDuration:animationDuration animations:^{
        [leftLeftView   setFrame:[self frameForIndex:-1]];
        [leftView       setFrame:[self frameForIndex: 0]];
        [centerView     setFrame:[self frameForIndex:+1]];
        [rightView      setFrame:[self frameForIndex:+2]];
        [rightRightView setFrame:[self frameForIndex:+3]];
    } completion:^(BOOL finished) {
        [self movePointersLeft];
    }];
}

- (void) movePointersLeft
{
    UIButton* jumpingView = rightRightView;
    rightRightView = rightView;
    rightView = centerView;
    centerView = leftView;
    leftView = leftLeftView;
    leftLeftView = jumpingView;
    currentIndex--;
    jumpingView.alpha = 0.0;
    if(currentIndex < 0)
        currentIndex += [games count];
    [self setPositions];
    [self fillButtons];
}

- (void) movePointersRight
{
    UIButton* jumpingView = leftLeftView;
    leftLeftView = leftView;
    leftView = centerView;
    centerView = rightView;
    rightView = rightRightView;
    rightRightView = jumpingView;
    jumpingView.alpha = 0.0;
    currentIndex++;
    if(currentIndex >= [games count])
        currentIndex -= [games count];
    [self setPositions];
    [self fillButtons];
}

@end
