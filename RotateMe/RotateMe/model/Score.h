//
//  Score.h
//  RotateMe
//
//  Created by Yunus Eren Guzel on 2/4/13.
//  Copyright (c) 2013 Yunus Eren Guzel. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "TypeDefs.h"

@class PhotoManagedObject;

@interface Score : NSManagedObject
@property int elapsedSeconds;
@property PhotoManagedObject* photo;
@property DIFFICULTY difficulty;
- (NSString*) toText;
+ (void) cleanAllScores;
@end
