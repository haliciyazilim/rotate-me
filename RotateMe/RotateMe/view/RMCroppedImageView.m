//
//  RMCroppedImageView.m
//  RotateMe
//
//  Created by Yunus Eren Guzel on 2/4/13.
//  Copyright (c) 2013 Yunus Eren Guzel. All rights reserved.
//

#import "RMCroppedImageView.h"
#import "RMInGameViewController.h"

#import <QuartzCore/QuartzCore.h>

@implementation RMCroppedImageView
{
    BOOL isAnimating;
    float currentAngle;
    UITapGestureRecognizer *tapGesture;
    UISwipeGestureRecognizer *swipeLeftGesture;
    UISwipeGestureRecognizer *swipeRightGesture;
    UISwipeGestureRecognizer *swipeUpGesture;
    UISwipeGestureRecognizer *swipeDownGesture;
    
    CGPoint touchLocation;
    float initialAngle;
    float moveSpeed;
}


-(id)initWithImage:(UIImage *)image
{
    if(self = [super init]){
        self.imageView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:self.imageView];
        [self setUserInteractionEnabled:YES];
        currentAngle = 0;
        
//        swipeRightGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self
//                                                                 action:@selector(handleSwipeGesture:)];
//        swipeRightGesture.direction = UISwipeGestureRecognizerDirectionRight;
//        [self addGestureRecognizer:swipeRightGesture];
//        
//        swipeLeftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self
//                                                                      action:@selector(handleSwipeGesture:)];
//        swipeLeftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
//        [self addGestureRecognizer:swipeLeftGesture];
//        
//        swipeUpGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self
//                                                                      action:@selector(handleSwipeGesture:)];
//        swipeUpGesture.direction = UISwipeGestureRecognizerDirectionUp;
//        [self addGestureRecognizer:swipeUpGesture];
//        
//        swipeDownGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self
//                                                                     action:@selector(handleSwipeGesture:)];
//        swipeDownGesture.direction = UISwipeGestureRecognizerDirectionDown;
//        [self addGestureRecognizer:swipeDownGesture];
//        
//        
//        
//        
//        tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
//                                                             action:@selector(handleTapGesture:)];
//        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

-(void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.imageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
}

-(void) rotateToAngle:(float)angle
{
    self.imageView.transform = CGAffineTransformMakeRotation(angle);
    currentAngle = angle;
}

- (float)getAngleFromPoint:(CGPoint)fromPoint
                   toPoint:(CGPoint)toPoint {
    if (fromPoint.x == toPoint.x && fromPoint.y == toPoint.y) {
        return 0;
    }
    
    float angle = atan((-toPoint.y+fromPoint.y)/(toPoint.x-fromPoint.x));
    
    if (toPoint.x < fromPoint.x) {
        angle += M_PI;
    }
    
    if (angle > M_PI) {
        angle -= 2 * M_PI;
    }
    
    return angle;
}

- (float)getAngleFromPoint:(CGPoint)fromPoint
              throughPoint:(CGPoint)throughPoint
                   toPoint:(CGPoint)toPoint {
    
    
    float angle1 = [self getAngleFromPoint:throughPoint
                                   toPoint:fromPoint];
    
    float angle2 = [self getAngleFromPoint:throughPoint
                                   toPoint:toPoint];
    
    float angle = angle2 - angle1;
    
    if (angle > M_PI) {
        angle -= 2 * M_PI;
    }
    
    if (angle < -M_PI) {
        angle += 2 * M_PI;
    }
    
    return  angle;
}



- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.superview bringSubviewToFront:self];
    touchLocation = [[touches anyObject] locationInView:self];
    initialAngle = currentAngle;
    
    
//    switch (getCurrentDifficulty()) {
//        case EASY:
//            moveSpeed = 0.004;
//            break;
//        case NORMAL:
//            moveSpeed = 0.0055;
//            break;
//        case HARD:
//            moveSpeed = 0.007;
//            break;
//        default:
//            break;
//    }
    
    [UIView animateWithDuration:0.15 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        CGAffineTransform t1 = CGAffineTransformMakeScale(1.2, 1.2);
        CGAffineTransform t2 = CGAffineTransformMakeRotation(currentAngle);
        self.imageView.transform = CGAffineTransformConcat(t1, t2);
    } completion:^(BOOL finished) {

    }];

    
    self.layer.rasterizationScale = 2;
    [self.layer setShouldRasterize:YES];
    self.layer.masksToBounds = NO;
    
    self.layer.shadowOffset = CGSizeMake(2, 2);
    self.layer.shadowRadius = 4;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.6;
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.superview bringSubviewToFront:self];
    
//    float difference = touchLocation - [[touches anyObject] locationInView:self].x;
    
    CGAffineTransform t1 = CGAffineTransformMakeScale(1.2, 1.2);

//    currentAngle = initialAngle - difference * M_PI * moveSpeed;
    currentAngle = initialAngle - [self getAngleFromPoint:touchLocation
                                             throughPoint:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)
                                                  toPoint:[[touches anyObject] locationInView:self]];

    CGAffineTransform t2 = CGAffineTransformMakeRotation(currentAngle);
    self.imageView.transform = CGAffineTransformConcat(t1, t2);
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.superview bringSubviewToFront:self];
    
//    float difference = touchLocation - [[touches anyObject] locationInView:self].x;
    
//    currentAngle = initialAngle - difference * M_PI * moveSpeed;
    currentAngle = initialAngle - [self getAngleFromPoint:touchLocation
                                             throughPoint:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)
                                                  toPoint:[[touches anyObject] locationInView:self]];
    
    while (currentAngle >= 2*M_PI) {
        currentAngle -= 2 * M_PI;
    }
    
    while (currentAngle < 0) {
        currentAngle += 2 * M_PI;
    }
    
    currentAngle = ((int)(currentAngle * 2 / M_PI + 0.5)) * M_PI / 2.0;
    
    
    [UIView animateWithDuration:0.15 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        CGAffineTransform t2 = CGAffineTransformMakeRotation(currentAngle);
        self.imageView.transform = t2;
    } completion:^(BOOL finished) {
        self.layer.rasterizationScale = 1;
        [self.layer setShouldRasterize:NO];
        
        self.layer.shadowRadius = 0.0;
        self.layer.shadowColor = nil;
        self.layer.shadowOpacity = 0.0;

        isAnimating = NO;
        if([self.parent canGameFinish]){
            [self.parent endGame];
        }
    }];
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesEnded:touches withEvent:event];
}


-(void) rotate:(BOOL)left {
    if(isAnimating)
        return;
    isAnimating = YES;
    if([self.parent isGameFinished])
        return;
    [self.superview bringSubviewToFront:self];
    [UIView animateWithDuration:0.15 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        CGAffineTransform t1 = CGAffineTransformMakeScale(1.2, 1.2);
        if (left) {
            currentAngle -= M_PI * 0.25;
        } else {
            currentAngle += M_PI * 0.25;
        }
        CGAffineTransform t2 = CGAffineTransformMakeRotation(currentAngle);
        self.imageView.transform = CGAffineTransformConcat(t1, t2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            CGAffineTransform t1 = CGAffineTransformMakeScale(1.0, 1.0);
            if (left) {
                currentAngle -= M_PI * 0.25;
            } else {
                currentAngle += M_PI * 0.25;
            }
            CGAffineTransform t2 = CGAffineTransformMakeRotation(currentAngle);
            self.imageView.transform = CGAffineTransformConcat(t1, t2);
        } completion:^(BOOL finished){
            isAnimating = NO;
            if([self.parent canGameFinish]){
                [self.parent endGame];
            }
        }];
    }];
}

-(void)setRotationStateTo:(int)state
{
    if(state < 0 || state > 3)
        return;
    currentAngle = M_PI * ((float)state / 2.0) ;
    [self rotateToAngle:currentAngle];
}

-(int)getCurrentRotationState
{
    if(isAnimating)
        return -2;
    
    float angle = currentAngle;
    
    while (angle < 0) {
        angle += M_PI * 2;
    }
    while(angle > M_PI * 2){
        angle -= M_PI * 2;
    }
    
    float error = 0.0001;
    int state = -1;
    
    if(angle >= 0 - error && angle <= 0 + error )
        state = 0;
    else if(angle >= M_PI * 0.5 - error && angle <= M_PI * 0.5 + error)
        state = 1;
    else if(angle >= M_PI * 1.0 - error && angle <= M_PI * 1.0 + error)
        state = 2;
    else if(angle >= M_PI * 1.5 - error && angle <= M_PI * 1.5 + error)
        state = 3;
    else if(angle >= M_PI * 2.0 - error && angle <= M_PI * 2.0 + error)
        state = 0;
    
    return state;
}

- (void)handleSwipeGesture:(UISwipeGestureRecognizer *)sender {
    if (sender == swipeRightGesture || sender == swipeUpGesture) {
        [self rotate:NO];
    } else if (sender == swipeLeftGesture || sender == swipeDownGesture) {
        [self rotate:YES];
    }
}

- (void)handleTapGesture:(UISwipeGestureRecognizer *)sender {
    [self rotate:NO];
}

@end
