//
//  AdManager.h
//  Equify
//
//  Created by Eren Halici on 27.03.2013.
//  Copyright (c) 2013 Halıcı. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdManager : NSObject

typedef void (^CallbackBlock) (void);

+ (AdManager *)sharedInstance;

- (void)showAdOnView:(UIView*)view
           withBlock:(CallbackBlock)callbackBlock;

@end
