//
//  TypeDefs.m
//  RotateMe
//
//  Created by Yunus Eren Guzel on 2/4/13.
//  Copyright (c) 2013 Yunus Eren Guzel. All rights reserved.
//

#import "TypeDefs.h"
#import "Config.h"

DIFFICULTY difficultyFromString(NSString* string){
    if([string compare:@"easy"] == 0){
        return EASY;
    }
    else if([string compare:@"normal"] == 0){
        return NORMAL;
    }
    else if([string compare:@"hard"] == 0){
        return HARD;
    }
    return -1;
}
NSString* stringOfDifficulty(DIFFICULTY difficulty){
    switch (difficulty) {
        case EASY:
            return @"easy";
        case NORMAL:
            return @"normal";
        case HARD:
            return @"hard";
        default:
            return nil;
    }
}

static DIFFICULTY CURRENT_DIFFICULTY = EASY;
void setCurrentDifficulty(DIFFICULTY difficulty){
    CURRENT_DIFFICULTY = difficulty;
    [[NSUserDefaults standardUserDefaults] setObject:stringOfDifficulty(difficulty) forKey:NSUSER_DIFFICULTY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
DIFFICULTY getCurrentDifficulty(){
    DIFFICULTY difficulty;
    NSString* result = [[NSUserDefaults standardUserDefaults] stringForKey:NSUSER_DIFFICULTY];
    if(result == nil){
        setCurrentDifficulty(CURRENT_DIFFICULTY);
        result = [[NSUserDefaults standardUserDefaults] stringForKey:NSUSER_DIFFICULTY];
    }
    difficulty = difficultyFromString(result);
    return difficulty;
}