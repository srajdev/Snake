//
//  HighScores.h
//  
//
//  Created by Swapan Rajdev on 8/18/10.
//  Copyright 2010 Zing! Apps. All rights reserved.
//
//  Description: This object is a full record of all the high scores for the game

#import <Foundation/Foundation.h>
#import "HighScoreRecord.h"


@interface HighScores : NSObject {

}

+ (void)addNewHighScore:(HighScoreRecord *)score;
+ (void)saveLocalHighScore:(NSArray *)highScoreArray;

+ (NSString *)highScoresFilePath;
+ (NSMutableArray *)getLocalHighScores;

+ (NSMutableArray *)sortHighScoreDictionaryArray:(NSMutableArray *)highScoreArray;


@end
