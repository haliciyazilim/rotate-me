//
//  RMPhotoSelectionViewController.h
//  RotateMe
//
//  Created by Yunus Eren Guzel on 2/1/13.
//  Copyright (c) 2013 Yunus Eren Guzel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Config.h"
#import "RMDifficultySelectorView.h"
@class Gallery;

@interface RMPhotoSelectionViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPopoverControllerDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *difficultySegmentedButtons;
@property (weak, nonatomic) IBOutlet UILabel *galleryNameLabel;

@property RMDifficultySelectorView* difficultySelectorView;

- (IBAction)difficultyChanged:(id)sender;

- (IBAction)backButtonClicked:(id)sender;

+ (RMPhotoSelectionViewController*) lastInstance;

- (void) setGallery:(Gallery*)gallery;

- (void) restart;

- (void) darken;

- (void) lighten;

- (CGSize)imageScaleSize;

- (void) refreshPhotos;

@end
