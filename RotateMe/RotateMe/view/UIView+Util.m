//
//  UIView+Util.m
//  RotateMe
//
//  Created by Yunus Eren Guzel on 2/5/13.
//  Copyright (c) 2013 Yunus Eren Guzel. All rights reserved.
//

#import "UIView+Util.h"

@implementation UIView (Util)

- (NSArray*) viewsByTag:(int)tag
{
    NSMutableArray* subviews = [[NSMutableArray alloc] init];
    for(UIView* subView in self.subviews){
        if(subView.tag == tag){
           [subviews addObject:subView];
        }
    }
    return (NSArray*)subviews;
}

@end
