//
//  RMGallerySelectionViewController.h
//  RotateMe
//
//  Created by Yunus Eren Guzel on 2/6/13.
//  Copyright (c) 2013 Yunus Eren Guzel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>
#import "Reachability.h"

@interface RMGallerySelectionViewController : UIViewController <GKGameCenterControllerDelegate>

@property (strong, nonatomic) Reachability *reachability;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)openSettings:(id)sender;
- (IBAction)openGameCenter;
- (void) configureViews;
@end
