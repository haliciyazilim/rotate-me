//
//  TypeDefs.h
//  RotateMe
//
//  Created by Yunus Eren Guzel on 2/4/13.
//  Copyright (c) 2013 Yunus Eren Guzel. All rights reserved.
//

#ifndef RotateMe_TypeDefs_h
#define RotateMe_TypeDefs_h

typedef void (^ IteratorBlock)();

typedef enum DIFFICULTY {
    EASY = 1,
    NORMAL = 2,
    HARD = 3
} DIFFICULTY;
DIFFICULTY difficultyFromString(NSString* string);
NSString* stringOfDifficulty(DIFFICULTY difficulty);
void setCurrentDifficulty(DIFFICULTY difficulty);
DIFFICULTY getCurrentDifficulty();

typedef enum GAME_STATE {
    GAME_STATE_STOPPED,
    GAME_STATE_PLAYING,
    GAME_STATE_PAUSED,
    GAME_STATE_RESTARTING
} GAME_STATE;

GAME_STATE getCurrentGameState();
void setCurrentGameState(GAME_STATE);

typedef enum APPLICATION_STATE {
    APPLICATION_STATE_WILL_RESIGN_ACTIVE,
    APPLICATION_STATE_ACTIVE
} APPLICATION_STATE;

APPLICATION_STATE getCurrentApplicationState();
void setCurrentApplicationState(APPLICATION_STATE);


#endif
