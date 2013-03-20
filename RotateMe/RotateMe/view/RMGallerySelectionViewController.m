//
//  RMGallerySelectionViewController.m
//  RotateMe
//
//  Created by Yunus Eren Guzel on 2/6/13.
//  Copyright (c) 2013 Yunus Eren Guzel. All rights reserved.
//

#import "RMGallerySelectionViewController.h"
#import "Gallery.h"
#import "RMGallerySelectionItemView.h"
#import "RMPhotoSelectionViewController.h"
#import "Config.h"
#import "RotateMeIAPHelper.h"
#import "Photo.h"
#import "RMSettingsView.h"
#import "RotateMeIAPHelper.h"
#import "MoreGamesView.h"

@interface RMGallerySelectionViewController ()

@end

@implementation RMGallerySelectionViewController
{
    Gallery* touchedGallery;
    BOOL isFirstLoad;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(configureViews)
                                                 name:kPhotoNotificationPhotoCreated
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(configureViews)
                                                 name:kPhotoNotificationPhotoDeleted
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(configureViews)
                                                 name:IAPHelperProductPurchasedNotification
                                               object:nil];
    
    [self configureViews];
    [self setBackground];
    isFirstLoad = YES;
    touchedGallery = nil;
    // Do any additional setup after loading the view.
    [self.view setUserInteractionEnabled:YES];
    [self.scrollView setUserInteractionEnabled:YES];
    
    
//    NSURL* url = [NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id592099228?mt=8&ign-mpt=uo%3D4"];
//    [[UIApplication sharedApplication] openURL:url];
    
//    NSString *appId = @"592099228"; //like 999999999
//    NSString *link = [@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=" stringByAppendingString:appId];
//    
//    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:link]];
    
    
    
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

- (CGSize) scrollViewItemSize{
    return CGSizeMake(250,150);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    RMPhotoSelectionViewController* photoSelectionViewController = [segue destinationViewController];
    [photoSelectionViewController setGallery:touchedGallery];
    touchedGallery = nil;
}

- (int) rowCount
{
    return 1;
}

- (CGFloat) leftMargin
{
    return 30.0;
}

-(CGFloat) topMargin
{
    return 30.0;
}
- (void) configureViews {
    NSArray* allGaleries = [Gallery allGalleries];
    int index = 0;
    
    
    for(UIView* view in [self.scrollView subviews]){
        if(view.tag == GALLERY_SELECTION_GALLERY_ITEM_TAG){
            [view removeFromSuperview];
        }
    }
    int scrollViewWidth = 0;
    for(Gallery* gallery in allGaleries){
        RMGallerySelectionItemView* galleryItem = [self generateGallerySelectionItemViewWithGallery:gallery animate:YES];
        [self.scrollView addSubview:galleryItem];
        galleryItem.tag = GALLERY_SELECTION_GALLERY_ITEM_TAG;
        galleryItem.frame = CGRectMake(
                                       [self leftMargin] + [self scrollViewItemSize].width * (index / [self rowCount]),
                                       [self topMargin] + [self scrollViewItemSize].height * (index % [self rowCount]),
                                       [self scrollViewItemSize].width,
                                       [self scrollViewItemSize].height);
        [galleryItem setUserInteractionEnabled:YES];
        scrollViewWidth += [self scrollViewItemSize].width;
        [galleryItem setTouchesBegan:^{
            if(touchedGallery != nil)
                return;
            if(gallery.isPurchased){
                touchedGallery = gallery;
                [self performSegueWithIdentifier:@"OpenPhotoSelection" sender:self];
            }else{
                [self openInAppPurchaseForGallery:gallery];
            }
        }];
        index++;
    }
    
    [self.scrollView setContentSize:CGSizeMake(scrollViewWidth / [self rowCount] + [self leftMargin], [self scrollViewItemSize].height * [self rowCount] + [self topMargin])];
    
    touchedGallery = nil;

}

- (void) openInAppPurchaseForGallery:(Gallery*)gallery
{
    [[RotateMeIAPHelper sharedInstance] showProduct:gallery onViewController:self];
    
}



- (RMGallerySelectionItemView*) generateGallerySelectionItemViewWithGallery:(Gallery*)gallery animate:(BOOL)animate
{
    return [[RMGallerySelectionItemView alloc] initWithGallery:gallery animate:YES];
}

- (void)viewDidUnload {
    [self setScrollView:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [super viewDidUnload];
}

-(void)viewDidDisappear:(BOOL)animated
{
    isFirstLoad = NO;
}

- (IBAction)openSettings:(id)sender {
    RMSettingsView* settings = [[RMSettingsView alloc] init];
    [self.view addSubview:settings];
}
@end
