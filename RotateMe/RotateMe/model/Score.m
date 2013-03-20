//
//  Score.m
//  RotateMe
//
//  Created by Yunus Eren Guzel on 2/4/13.
//  Copyright (c) 2013 Yunus Eren Guzel. All rights reserved.
//

#import "Score.h"
#import "PhotoManagedObject.h"
@implementation Score
@dynamic elapsedSeconds;
@dynamic difficulty;
@dynamic photo;
- (NSString*) toText
{
    int minutes = self.elapsedSeconds / 60;
    int seconds = self.elapsedSeconds % 60;
    NSString* minutesString = minutes < 10 ? [NSString stringWithFormat:@"0%d",minutes] : [NSString stringWithFormat:@"%d",minutes];
    
    NSString* secondsString = seconds < 10 ? [NSString stringWithFormat:@"0%d",seconds] : [NSString stringWithFormat:@"%d",seconds];
    
    return [NSString stringWithFormat:@"%@:%@",minutesString,secondsString];
}

+ (void) cleanAllScores
{
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSMutableArray* scores = [[RMDatabaseManager sharedInstance] entitiesWithRequest:request forName:@"Score"];
    for(Score* score in scores){
        [[RMDatabaseManager sharedInstance] deleteObject:score];
    }
}
@end
