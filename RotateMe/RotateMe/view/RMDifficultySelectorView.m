//
//  RMDifficultySelectorView.m
//  RotateMe
//
//  Created by Yunus Eren Guzel on 3/7/13.
//  Copyright (c) 2013 Yunus Eren Guzel. All rights reserved.
//

#import "RMDifficultySelectorView.h"
#import "TypeDefs.h"
#import "RMPhotoSelectionViewController.h"
@implementation RMDifficultySelectorView
{
    NSArray* buttons;
}
- (id) init
{
    if(self = [super init]){
        self.frame = CGRectMake(0, 0, 3 * [self buttonSize].width, [self buttonSize].height);
        
        self.easyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.normalButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.hardButton = [UIButton buttonWithType:UIButtonTypeCustom];
        buttons = [NSArray arrayWithObjects:self.easyButton, self.normalButton, self.hardButton, nil];
        
        [self setButtonImages];
        [self stylizeButtons];
        
        DIFFICULTY difficulty = getCurrentDifficulty();
        [self unselectButtons];
        switch (difficulty) {
            case EASY:
                [self.easyButton setSelected:YES];
                break;
            case NORMAL:
                [self.normalButton setSelected:YES];
                break;
            case HARD:
                [self.hardButton setSelected:YES];
                break;
            default:
                break;
        }
    }
    return self;
}

- (void) setButtonImages
{
    
    [self.easyButton setImage:[UIImage imageNamed:@"level_01_ipad.png"] forState:UIControlStateNormal];
    [self.easyButton setImage:[UIImage imageNamed:@"level_01_selected_ipad.png"] forState:UIControlStateSelected];
    [self.easyButton setImage:[UIImage imageNamed:@"level_01_selected_ipad.png"] forState:UIControlStateHighlighted];
    [self.easyButton setImage:[UIImage imageNamed:@"level_01_selected_ipad.png"] forState:UIControlStateHighlighted|UIControlStateSelected];
    
    [self.normalButton setImage:[UIImage imageNamed:@"level_02_ipad.png"] forState:UIControlStateNormal];
    [self.normalButton setImage:[UIImage imageNamed:@"level_02_selected_ipad.png"] forState:UIControlStateSelected];
    [self.normalButton setImage:[UIImage imageNamed:@"level_02_selected_ipad.png"] forState:UIControlStateHighlighted];
    [self.normalButton setImage:[UIImage imageNamed:@"level_02_selected_ipad.png"] forState:UIControlStateHighlighted|UIControlStateSelected];
    
    [self.hardButton setImage:[UIImage imageNamed:@"level_03_ipad.png"] forState:UIControlStateNormal];
    [self.hardButton setImage:[UIImage imageNamed:@"level_03_selected_ipad.png"] forState:UIControlStateSelected];
    [self.hardButton setImage:[UIImage imageNamed:@"level_03_selected_ipad.png"] forState:UIControlStateHighlighted];
    [self.hardButton setImage:[UIImage imageNamed:@"level_03_selected_ipad.png"] forState:UIControlStateHighlighted|UIControlStateSelected];
    
}

- (void) unselectButtons
{
    for(UIButton* button in buttons){
        [button setSelected:NO];
    }
}

- (void) stylizeButtons
{
    int index = 0;
    for(UIButton* button in buttons) {
        button.tag = 100 + index;
        [button addTarget:self action:@selector(switchDifficultyForButton:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(index * [self buttonSize].width, 0 , [self buttonSize].width, [self buttonSize].height);
        [self addSubview:button];
        [button setContentMode:UIViewContentModeCenter];
        index++;
    }
}

- (CGSize) buttonSize
{
    return CGSizeMake(40,50);
}

- (void) switchDifficultyForButton:(UIButton*)button
{
    [self unselectButtons];
    [button setSelected:YES];
    
    if(button == self.easyButton){
        setCurrentDifficulty(EASY);
    } else
    if(button == self.normalButton){
        setCurrentDifficulty(NORMAL);
    } else
    if(button == self.hardButton){
        setCurrentDifficulty(HARD);
    }
    [[RMPhotoSelectionViewController lastInstance] refreshPhotos];
}

@end
