//
//  RMGallerySelectionViewController.h
//  RotateMe
//
//  Created by Yunus Eren Guzel on 2/6/13.
//  Copyright (c) 2013 Yunus Eren Guzel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMGallerySelectionViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)openSettings:(id)sender;
- (void) configureViews;
@end
