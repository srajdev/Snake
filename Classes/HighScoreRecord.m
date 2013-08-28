//
//  HighScoreRecord.m
//  
//
//  Created by Swapan Rajdev on 8/18/10.
//  Copyright 2010 Zing! Apps. All rights reserved.
// 
//  Description: This object presents a record to be stored as the high score.

#import "HighScoreRecord.h"


@implementation HighScoreRecord


@synthesize name;
@synthesize totalScore;
@synthesize rank;
@synthesize mode;

// Function to initialize a record with Name and score

-(id)initWithScore:(NSString *)playerName TotalScore:(NSNumber *)score{
	

	if (self = [super init]) {
		name = playerName;
		totalScore = score;
	}
	
	return self;
	
}

-(id)initWithScore:(NSString *)playerName TotalScore:(NSNumber *)score gameMode:(NSString *)gameMode{
	
	
	if (self = [super init]) {
		name = playerName;
		totalScore = score;
		mode = gameMode;
	}
	
	return self;
	
}

// Function to compare 2 scores
-(NSComparisonResult) compare:(id)other{

	return [self.totalScore compare:other];
	
}

#pragma mark NSCoding

// Function to encode the record to store
-(void)encodeWithCoder:(NSCoder *)encoder{


	
	 [encoder encodeObject:name forKey:@"Name"];
	 [encoder encodeObject:totalScore forKey:@"TotalScore"];
	[encoder encodeObject:mode forKey:@"GameMode"];
}



-(id)initWithCoder:(NSCoder *)decoder{

	
	if(self = [super init]){
		
		self.name = [decoder decodeObjectForKey:@"Name"];
		self.totalScore = [decoder decodeObjectForKey:@"TotalScore"];
		self.mode = [decoder decodeObjectForKey:@"GameMode"];
	}
	
	
	return self;
}


#pragma mark NSCopying

-(id)copyWithZone:(NSZone *)zone{

	HighScoreRecord *copy = [[[self class] allocWithZone:zone] init];
	name = [self.name copy];
	totalScore = [self.totalScore copy];
	mode = [self.mode copy];
	
	return copy;
	
}

-(void)dealloc{

	[name release];
	[totalScore release];
	[mode release];
	
	[super dealloc];
	
}

@end
