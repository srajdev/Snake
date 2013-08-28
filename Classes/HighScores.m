//
//  HighScores.m
//  MyGame
//
//  Created by Swapan Rajdev on 8/18/10.
//  Copyright 2010 Zing! Apps. All rights reserved.
//
//  Description: This object is a full record of all the high scores for the game


#import "HighScores.h"

#import <CommonCrypto/CommonDigest.h>


@implementation HighScores

const int HIGH_SCORE_COUNT = 10;



// Class function to Add a new high score to the list

+ (void)addNewHighScore:(HighScoreRecord *)score{

	NSMutableArray *locals = [HighScores getLocalHighScores];
	
	int totalScore = [score.totalScore intValue];
	
	if(locals.count < HIGH_SCORE_COUNT){
		[locals addObject:score];
		NSMutableArray *sortedLocals = [HighScores sortHighScoreDictionaryArray:locals];
		[HighScores saveLocalHighScore:sortedLocals];
		[sortedLocals release];
	}
	else {
		NSUInteger lastIndx = HIGH_SCORE_COUNT -1 ;
		HighScoreRecord *lastRecord = [locals objectAtIndex:lastIndx];
		if (totalScore > [lastRecord.totalScore intValue]) {
			[locals addObject:score];
			NSMutableArray *sortedLocals = [HighScores sortHighScoreDictionaryArray:locals];
			[sortedLocals removeLastObject];
			
			[HighScores saveLocalHighScore:sortedLocals];
			
			[sortedLocals release];
		}
		
	}

	
}





// Function to get the High Score file path
+ (NSString *)highScoresFilePath{
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);

	NSString *documentsDirectory = [paths objectAtIndex:0];
	
	
	return [documentsDirectory stringByAppendingPathComponent:@"HighScoresFiles"];
}


// Function to get all the high scores.

+ (NSMutableArray *)getLocalHighScores{

	NSData *data = [[NSMutableData alloc] initWithContentsOfFile:[HighScores highScoresFilePath]];
	NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
	
	[data release];
	NSArray *highScores = [unarchiver decodeObjectForKey:@"HighScores"];
	
	[unarchiver release];
	
	return [[[NSMutableArray alloc] initWithArray:highScores copyItems:NO] autorelease];
	
	
	
	
	[highScores release];
	
	
}


// Function to save a high score
+ (void)saveLocalHighScore:(NSArray *)highScoreArray{
	
	NSMutableData *data = [[NSMutableData alloc] init];
	NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
	
	[archiver encodeObject:highScoreArray forKey:@"HighScores"];
	[archiver finishEncoding];
	
	
	[data writeToFile:[HighScores highScoresFilePath] atomically:YES];
	
	[archiver release];
	[data release];
	
	
}

// Function to sort all the high score
+ (NSMutableArray *)sortHighScoreDictionaryArray:(NSMutableArray *)highScoreArray{

	NSString *SORT_KEY = @"totalScore";
	NSSortDescriptor *scoreDescriptor = [[[NSSortDescriptor alloc] initWithKey:SORT_KEY ascending:NO 
																	  selector:@selector(compare:)] autorelease];
	
	NSArray *sortDescriptors = [NSArray arrayWithObjects:scoreDescriptor,nil];
	
	
	NSArray *sortedArray = [highScoreArray sortedArrayUsingDescriptors:sortDescriptors];
	
	
	
	return [[NSMutableArray alloc] initWithArray:sortedArray copyItems:NO];
	
	
	
	
}





@end
