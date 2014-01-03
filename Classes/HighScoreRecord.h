//
//  HighScoreRecord.h
//  
//
//  Created by Swapan Rajdev on 8/18/10.
//  Copyright 2010 Zing! Apps. All rights reserved.
//  
//  Description: This object presents a record to be stored as the high score.

#import <Foundation/Foundation.h>
#import "FlurryAdDelegate.h"

@interface HighScoreRecord : NSObject <NSCoding, FlurryAdDelegate, NSCopying>{
	
	NSString *name;
	NSNumber *totalScore;
	NSInteger rank;
	NSString *mode;

}

-(id)initWithScore:(NSString *)playerName TotalScore:(NSNumber *)score gameMode:(NSString *)gameMode;
-(id)initWithScore:(NSString *)playerName TotalScore:(NSNumber *)score;

@property (nonatomic,retain) NSString *name;
@property (nonatomic,retain) NSNumber *totalScore;
@property (nonatomic,readwrite) NSInteger rank;
@property (nonatomic,retain) NSString *mode;

-(NSComparisonResult) compare:(id)other;

@end
