//
//  snakeType.h
//  
//
//  Created by Swapan Rajdev on 7/31/10.
//  Copyright 2010 Zing! Apps. All rights reserved.
//
//  Description: This object keeps a track of all the various data required for the snake.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "constants.h"


@interface snakeType : NSObject {

	CGFloat head_x;
	CGFloat head_y;
	
	CGFloat tail_x;
	CGFloat tail_y;
	
	Direction headDirection;
	
	Direction tailDirection;
	
	UIColor *snakeColor;
	
	NSMutableArray *bends;
	
	NSMutableArray *bend_direction;
	
	int i;
	
	
}

@property CGFloat head_x;
@property CGFloat head_y;

@property int i;



@property CGFloat tail_x;
@property CGFloat tail_y;

@property Direction headDirection;
@property Direction tailDirection;

@property (nonatomic,retain) UIColor *snakeColor;  

@property (nonatomic,retain) NSMutableArray *bends; 

@property (nonatomic,retain) NSMutableArray *bend_direction;


-(void)moveSnakeEast;
-(void)moveSnakeWest;
-(void)moveSnakeNorth;
-(void)moveSnakeSouth;


-(void)updateTail;

-(void)moveSnakeTimerEast;
-(void)moveSnakeTimerWest;
-(void)moveSnakeTimerNorth;
-(void)moveSnakeTimerSouth;

@end