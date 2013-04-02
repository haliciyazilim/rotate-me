//
//  MoreGamesView.h
//  RotateMe
//
//  Created by Yunus Eren Guzel on 3/13/13.
//  Copyright (c) 2013 Yunus Eren Guzel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKNetworkEngine.h"
#import <QuartzCore/QuartzCore.h>

#import "Config.h"


@interface MGGameView : UIView
@property (nonatomic) UIImage* image;
@property UIImageView* imageView;
- (id) init;
@end

@interface MoreGamesView : UIView

- (id) init;

@end
