//
//  RMPhotoSelectionViewController.m
//  RotateMe
//
//  Created by Yunus Eren Guzel on 2/1/13.
//  Copyright (c) 2013 Yunus Eren Guzel. All rights reserved.
//

#import "RMPhotoSelectionViewController.h"
#import "RMCustomImageView.h"
#import "RMInGameViewController.h"
#import "RMImage.h"
#import "Photo.h"
#import "UIView+Util.h"
#import "RMPhotoSelectionImageView.h"

@interface RMPhotoSelectionViewController ()

@end

@implementation RMPhotoSelectionViewController
{
    RMCustomImageView* touchedPhoto;
    RMCustomImageView* lastTouchedPhoto;
    Gallery* currentGallery;
    NSMutableArray* photos;
    CGSize imageScaleSize;
    NSMutableArray* imageThreads;
    UIImagePickerController* imagePicker;
    RMCustomImageView* testImageView;
    BOOL needsRefresh;
    UIPopoverController *popoverController;
}

-(id) init
{
    if(self = [super init]){
        
    }
    return self;
}

- (IBAction)backButtonClicked:(id)sender {
    [self dismissModalViewControllerAnimated:YES ];
}

static RMPhotoSelectionViewController* lastInstance = nil;
+ (RMPhotoSelectionViewController*) lastInstance
{
    return lastInstance;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void) setBackground
{
    if([[UIScreen mainScreen] bounds].size.height == 568){
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"selection_bg-568h.png"]]];
    }
    else{
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"selection_bg.png"]]];
        
    }
}

- (CGRect) difficultySelectorViewFrame
{
    CGFloat left = [self.view frame].size.height - 140;
    return CGRectMake(left, 7, 120, 50);
}

- (void)viewDidLoad
{
    lastInstance = self;
    [super viewDidLoad];
    
    touchedPhoto = nil;
    
    [self setBackground];
    
    self.difficultySelectorView = [[RMDifficultySelectorView alloc] init];
    self.difficultySelectorView.frame = [self difficultySelectorViewFrame];
    [self.view addSubview:self.difficultySelectorView];

    imageThreads = [[NSMutableArray alloc] init];
    [self configureView];
    
}

- (void) setGallery:(Gallery*)gallery
{
    if(currentGallery != gallery){
        currentGallery = gallery;
        photos = nil;
        [self configureView];
    }
}
-(CGFloat) galleryNameLabelFontSize
{
    return 20.0;
}
-(void)configureView
{
    [self.galleryNameLabel setText:NSLocalizedString(currentGallery.name,nil)];
    [self.galleryNameLabel setFont:[UIFont fontWithName:@"TRMcLeanBold" size:[self galleryNameLabelFontSize]] ];
    [self printPhotos];
    [self processImageThreads];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self refreshPhotos];
}

- (void) refreshPhotos
{
    [RMPhotoSelectionViewController setLastScroll:self.scrollView.contentOffset.x];
    NSArray* imageViews = [self.scrollView viewsByTag:PHOTO_SELECTION_IMAGEVIEW_TAG];
    for(UIImageView* imageView in imageViews ){
        [imageView removeFromSuperview];
    }
    [self printPhotos];
    [self processImageThreads];
}

- (int) leftMargin
{
    return 20;
}

- (int) topMargin
{
    return 5;
}

- (CGSize) size
{
    return CGSizeMake(156, 116);
}

- (CGSize) photoSize
{
    return CGSizeMake(136, 102);
}

- (int) rowCount
{
    return 2;
}

- (void) printPhotos
{
    int leftMargin = [self leftMargin];
    int topMargin = [self topMargin];
    int rowCount = [self rowCount];
    CGSize size = [self size];
    CGSize photoSize = [self photoSize];
    if ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] &&
        ([UIScreen mainScreen].scale == 2.0)) {
        imageScaleSize = CGSizeMake(photoSize.width*2, photoSize.height*2.0);
        
    } else {
        imageScaleSize = photoSize;
    }
    
    if(photos == nil){
        photos = [NSMutableArray arrayWithArray:[currentGallery allPhotos]];
    }
    NSMutableArray* subViews = [[NSMutableArray alloc] init];
    [self.scrollView setContentOffset:CGPointMake([RMPhotoSelectionViewController getLastScroll], 0.0)];
    if([currentGallery.name compare:USER_GALLERY_NAME] == 0){
        RMCustomImageView* addFromGallery = [self addFromGalleryView];
        RMCustomImageView* addFromCamera = [self addFromCameraView];
        [subViews addObject:addFromGallery];
        [subViews addObject:addFromCamera];
    }
    
    for(int i=0; i < [photos count]; i++){
        Photo* photo = (Photo*)[photos objectAtIndex:i];
        CGRect photoViewRect = CGRectMake(leftMargin+(i/rowCount)*size.width, topMargin + (i%rowCount) * size.height, photoSize.width, photoSize.height);
        RMPhotoSelectionImageView* photoView = [self generateSelectionViewWithPhoto:photo andFrame:photoViewRect];
        [photoView setScoreLabelFontSize:[self photoSelectionScoreFontSize]];
        __block RMCustomImageView* blockPhotoView = photoView;
        [photoView setTouchesBegan:^{
            if(touchedPhoto == nil){
                touchedPhoto = blockPhotoView;
                lastTouchedPhoto = touchedPhoto;
                [self performSegueWithIdentifier:@"StartGame" sender:self];
            }
        }];
        photoView.layer.zPosition = 1;
        if([currentGallery.name compare:USER_GALLERY_NAME] == 0){
            RMCustomImageView* deleteView = [[RMCustomImageView alloc] initWithImage:[self deletePhotoImage]];
            int padding = 10;
            deleteView.frame = CGRectMake(photoSize.width - deleteView.image.size.width-1-padding*0.5, 3-padding*0.5, deleteView.image.size.width+padding, deleteView.image.size.height+padding);
            [deleteView setContentMode:UIViewContentModeCenter];
            [photoView addSubview:deleteView];
            deleteView.layer.zPosition = 2;
            [deleteView setUserInteractionEnabled:YES];
            [deleteView setTouchesBegan:^{
                [photos removeObject:photo];
                [photo removeFromDatabase];
                [self refreshPhotos];
            }];
        }
        [subViews addObject:photoView];
    }
    
    [self.scrollView setContentSize:CGSizeMake(leftMargin + ceil(subViews.count / (float)rowCount) * size.width,
                                               topMargin  + size.height*rowCount)];
    
    for(int i=0;i< [subViews count];i++){
        CGRect frame = CGRectMake(leftMargin+(i/rowCount)*size.width, topMargin + (i%rowCount) * size.height, photoSize.width, photoSize.height);
        UIView* view = [subViews objectAtIndex:i];
        [view setFrame:frame];
        [self applyBorderAndShadow:view];
        view.tag = PHOTO_SELECTION_IMAGEVIEW_TAG;
        view.layer.zPosition = 1;
        [self.scrollView addSubview:view];
    }
}

- (CGSize)imageScaleSize
{
    return imageScaleSize;
}

- (RMPhotoSelectionImageView*) generateSelectionViewWithPhoto:(Photo*)photo andFrame:(CGRect)frame
{
    return [RMPhotoSelectionImageView viewWithPhoto:photo andFrame:frame andScaleSize:[self imageScaleSize]];
}

- (RMCustomImageView*) addFromCameraView
{
    RMCustomImageView* addFromCamera = [[RMCustomImageView alloc] initWithImage:[self takePhotoImage]];
    [addFromCamera setUserInteractionEnabled:YES];
    [addFromCamera setTouchesBegan:^{
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentModalViewController:imagePicker animated:YES];
        }
    }];
    [addFromCamera setContentMode:UIViewContentModeCenter];
    return addFromCamera;
}

- (UIImage*) deletePhotoImage
{
    return [UIImage imageNamed:@"delete_photo_btn.png"];
}

- (UIImage*) takePhotoImage
{
    return [UIImage imageNamed:@"take_photo_btn.png"];
}
- (UIImage*) galleryPhotoImage
{
    return [UIImage imageNamed:@"gallery_photo_btn.png"];
}

- (RMCustomImageView*) addFromGalleryView
{
    RMCustomImageView* addFromGallery = [[RMCustomImageView alloc] initWithImage:[self galleryPhotoImage]];
    
    if (!imagePicker) {
        imagePicker = [[UIImagePickerController alloc] init];
        [imagePicker setDelegate:self];
    }
    
    [addFromGallery setUserInteractionEnabled:YES];
    [addFromGallery setContentMode:UIViewContentModeCenter];
    
    CGRect scrollViewFrame = self.scrollView.frame;
    CGRect addFromGalleryFrame = addFromGallery.frame;
    
    if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPhone) {
        if (!popoverController) {
            popoverController = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
        }
    }
    [addFromGallery setTouchesBegan:^{
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            [self presentModalViewController:imagePicker animated:YES];
        } else {
            if (![popoverController isPopoverVisible]) {
                [popoverController presentPopoverFromRect:CGRectMake(scrollViewFrame.origin.x + addFromGalleryFrame.origin.x,
                                                                     scrollViewFrame.origin.y + addFromGalleryFrame.origin.y,
                                                                     addFromGalleryFrame.size.width,
                                                                     addFromGalleryFrame.size.height)
                                                   inView:self.view
                                 permittedArrowDirections:UIPopoverArrowDirectionLeft
                                                 animated:YES];
            } else {
                [popoverController dismissPopoverAnimated:YES];
            }
        }
    }];
    return addFromGallery;
}

- (CGFloat) photoSelectionScoreFontSize
{
    return 14.0;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *) Picker {
    
    [Picker dismissModalViewControllerAnimated:YES];
    [[Picker parentViewController] dismissModalViewControllerAnimated:YES];
}


- (int) shadowRadius
{
    return 1;
}

- (CGSize) shadowOffset
{
    return CGSizeMake(1, 2);
}

- (void) applyBorderAndShadow:(UIView*) view
{
    view.layer.borderColor = [UIColor whiteColor].CGColor;
    view.layer.borderWidth = 2.0f;
    [view.layer setShadowColor:[UIColor blackColor].CGColor];
    [view.layer setShadowOffset:CGSizeMake(0.0, 5.0)];
    view.layer.masksToBounds = NO;
    
    view.layer.shadowOffset = [self shadowOffset];
    view.layer.shadowRadius = [self shadowRadius];
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOpacity = 0.6;
    
    [view.layer setShadowPath:[[UIBezierPath bezierPathWithRect:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)] CGPath]];
    
}

- (void) restart
{
    touchedPhoto = lastTouchedPhoto;
    [self performSegueWithIdentifier:@"StartGame" sender:self];
    touchedPhoto = nil;
}

- (void)imagePickerController:(UIImagePickerController *) Picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage* image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self createAndSavePhotoFromImage:image];
    NSLog(@"didFinishPicking");
    
    [Picker dismissModalViewControllerAnimated:YES];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [[Picker parentViewController] dismissModalViewControllerAnimated:YES];
    } else {
        [popoverController dismissPopoverAnimated:YES];
    }
}

- (void) createAndSavePhotoFromImage:(UIImage*)image
{
    NSError* error;
    NSString* imageName = [NSString stringWithFormat:@"%.0f.jpg",([NSDate timeIntervalSinceReferenceDate]*1000)];
    NSLog(@"imageName: %@",imageName);
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *folderPath = [documentsDirectory stringByAppendingPathComponent:USER_GALLERY_NAME];
    
    [[NSFileManager defaultManager] createDirectoryAtPath:folderPath
                              withIntermediateDirectories:NO
                                               attributes:nil
                                                    error:&error];
      
    NSString* imagePath = [folderPath stringByAppendingPathComponent:imageName];
    
    [UIImageJPEGRepresentation(image, 1.0) writeToFile:imagePath atomically:YES];
    
    Photo* photo = [Photo createPhotoWithFileName:imageName andGallery:currentGallery];
    [photos addObject:photo];
    [self refreshPhotos];
}

- (void) processImageThreads
{
    for(NSThread* thread in imageThreads){
        [thread start];
    }
    imageThreads = [[NSMutableArray alloc] init];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self processImageThreads];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    RMInGameViewController* inGameView = [segue destinationViewController];
    [inGameView setImage:[[(RMImage*)touchedPhoto.image owner] getImage]];
    touchedPhoto = nil;
    
}

- (IBAction)difficultyChanged:(id)sender {  
    
    UISegmentedControl* control = (UISegmentedControl*)sender;
    if([control selectedSegmentIndex] == 0){
        setCurrentDifficulty(EASY);
    }
    else if ([control selectedSegmentIndex] == 1){
        setCurrentDifficulty(NORMAL);
    }
    else if([control selectedSegmentIndex] == 2){
        setCurrentDifficulty(HARD);
    }
    
    [self refreshPhotos];

}

static int __lastScroll = 0;

+(int)getLastScroll
{
    return __lastScroll;
}

+(void)setLastScroll:(int)scroll{
    __lastScroll = scroll;
}


- (void)viewDidUnload {
    [self setDifficultySegmentedButtons:nil];
    [self setGalleryNameLabel:nil];
    [super viewDidUnload];
}

- (void) darken
{
    UIView* view = [[UIView alloc] init];
    view.frame = self.view.frame;
    [view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"game_bg.jpg"]]];
    view.tag = 1001;
    [self.view addSubview:view];
}
- (void) lighten
{
    UIView* view = [self.view viewWithTag:1001];
    [view removeFromSuperview];
}

@end


