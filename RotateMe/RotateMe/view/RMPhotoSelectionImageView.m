//
//  RMPhotoSelectionImageView.m
//  RotateMe
//
//  Created by Yunus Eren Guzel on 2/7/13.
//  Copyright (c) 2013 Yunus Eren Guzel. All rights reserved.
//

#import "RMPhotoSelectionImageView.h"
#import <QuartzCore/QuartzCore.h>
#import "Config.h"
#import "RMImage.h"

@implementation RMPhotoSelectionImageView
{
    CGSize imageScaleSize;
    UILabel* scoreLabel;
    BOOL isLoaded;
}

+ (RMPhotoSelectionImageView *)viewWithPhoto:(Photo *)photo andFrame:(CGRect)frame andScaleSize:(CGSize)imageScaleSize
{
    RMPhotoSelectionImageView* photoView = [[RMPhotoSelectionImageView alloc] initWithPhoto:photo andFrame:frame andScaleSize:imageScaleSize];
    return photoView;
}
- (id) initWithPhoto:(Photo *)photo andFrame:(CGRect)frame andScaleSize:(CGSize)_imageScaleSize
{
    imageScaleSize = _imageScaleSize;
    isLoaded = NO;
    if(self = [super init]){
        self.tag = PHOTO_SELECTION_IMAGEVIEW_TAG;
        self.frame = frame;
        [self setContentMode:UIViewContentModeScaleAspectFill];
        [self setClipsToBounds:YES];
        [self setUserInteractionEnabled:YES];
        
        UIActivityIndicatorView* activityIndicator = [[UIActivityIndicatorView alloc] init];
        activityIndicator.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [activityIndicator startAnimating];
        [self addSubview:activityIndicator];
        
        Score* score = [photo getScoreForDifficulty:getCurrentDifficulty()];
        if(score != nil){
            UIImageView* gradient = [[UIImageView alloc] initWithImage:[self gradientImage]];
            gradient.frame = CGRectMake(0, frame.size.height - gradient.image.size.height, frame.size.width, gradient.image.size.height);
            [self addSubview:gradient];
            CGSize scoreLabelSize = CGSizeMake(70, 25);
            
            scoreLabel = [[UILabel alloc] init];
            scoreLabel.frame = CGRectMake(10, frame.size.height - scoreLabelSize.height*1.0, scoreLabelSize.width, scoreLabelSize.height);
            scoreLabel.text = [score toText];
            scoreLabel.backgroundColor = [UIColor clearColor];
            [scoreLabel setTextColor:[UIColor whiteColor]];
            [scoreLabel setShadowColor:[UIColor blackColor]];
            [scoreLabel setShadowOffset:CGSizeMake(0,1)];
            [self setScoreLabelFontSize:14.0];
            
            [scoreLabel setTextAlignment:NSTextAlignmentLeft];
            [self addSubview:scoreLabel];
        }
        
        [[[NSThread alloc] initWithTarget:self selector:@selector(loadImageForView:) object:[NSArray arrayWithObjects:photo,activityIndicator, nil]] start];
    }
    return self;
}

- (UIImage*) gradientImage
{
    return [UIImage imageNamed:@"photo_gradient.png"];
}

- (void) setScoreLabelFontSize:(CGFloat) size
{
    [scoreLabel setFont:[UIFont fontWithName:@"TR McLean" size:size]];
}


- (void) loadImageForView:(NSArray*)params
{
    Photo* photo = [params objectAtIndex:0];
    UIActivityIndicatorView* activityIndicator = [params objectAtIndex:1];
    
    RMImage* originalImage = [photo getImage];
    if([photo getThumbnailImage] == nil){
        [photo setThumbnailImage:[originalImage imageByScalingAndCroppingForSize:imageScaleSize]];
    }
    self.image = [photo getThumbnailImage];
    
    [activityIndicator removeFromSuperview];
    activityIndicator = nil;
    isLoaded = YES;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(isLoaded){
        [super touchesBegan:touches withEvent:event];
    }
}


@end
