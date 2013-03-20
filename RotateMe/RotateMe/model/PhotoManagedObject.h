//
//  PhotoManagedObject.h
//  RotateMe
//
//  Created by Yunus Eren Guzel on 2/7/13.
//  Copyright (c) 2013 Yunus Eren Guzel. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "Gallery.h"
@interface PhotoManagedObject : NSManagedObject

@property NSString* filename;
@property Gallery* gallery;
@property NSSet* score;
@end
