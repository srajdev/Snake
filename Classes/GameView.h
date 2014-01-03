//
//  GameView.h
//  
//
//  Created by Swapan Rajdev on 7/31/10.
//  Copyright 2010 Zing! Apps All rights reserved.
//
//  Description: This UIView is the view where the snake game is played.
//               This is the area where the snake moves, and the food is shown

#import <UIKit/UIKit.h>
#include <AudioToolbox/AudioToolbox.h>

#include <AVFoundation/AVFoundation.h>

#include <QuartzCore/QuartzCore.h>
#include <GameKit/GameKit.h>





@class snakeType;
@class foodType;


@interface GameView : UIView <AVAudioPlayerDelegate> {
	
	snakeType *snake;
	foodType *food;
	
	BOOL gameOver;
	UIColor *snakeColor;
	int score;
	
	int addFoodScore;
	int addBonusFoodScore;
	
	int foodValue;
	
	BOOL walls;
	
	BOOL vibrate;
	
	BOOL sound;
	
//	AVAudioPlayer *player;
	
//	AVAudioPlayer *bonusfoodplayer;
	
	
	
	CALayer *masterLayer;
	CALayer *snakeLayer;
	CALayer *snakeBackgroundLayer;
	
	CALayer *foodLayer;
	
	CALayer *bonusFoodLayer;
	
	CALayer *wallLayer;
	
	int foodEaten;
	
	UIColor *headColor;
	
	UIColor *tailColor;
	
	
	
	

}



@property (nonatomic,retain) snakeType *snake;
@property (nonatomic,retain) foodType *food;
@property BOOL gameOver;
@property (nonatomic,retain) UIColor *snakeColor;
@property (nonatomic,retain) 	UIColor *headColor;
@property (nonatomic,retain) 	UIColor *tailColor;
@property int score;

@property (nonatomic,retain) CALayer *snakeLayer;
@property (nonatomic,retain) CALayer *snakeBackgroundLayer;
@property (nonatomic,retain) CALayer *masterLayer;
@property (nonatomic,retain) CALayer *foodLayer;
@property (nonatomic,retain) CALayer *bonusFoodLayer;
@property (nonatomic,retain) CALayer *wallLayer;

@property int foodValue;
@property int speed;


@property int addFoodScore;
@property int addBonusFoodScore;
@property BOOL walls;

@property BOOL vibrate;
@property BOOL sound;


@property int foodEaten;


-(void)moveSnakeRight;
-(void)moveSnakeUp;
-(void)moveSnakeLeft;
-(void)moveSnakeDown;

-(void)moveTimerSnakeRight;
-(void)moveTimerSnakeUp;
-(void)moveTimerSnakeLeft;
-(void)moveTimerSnakeDown;

-(BOOL)wasFoodEaten;

-(BOOL)wasBonusFoodEaten;

-(BOOL)inbetween_A_B:(CGPoint) a pointtwo:(CGPoint) b pointinbetween:(CGPoint) c;

-(BOOL)onSnake:(CGPoint)aPoint check_food:(BOOL)food_yes;

-(void)invalidateBonusFood;

-(void)generateBonusFood;

-(void)gameIsOver;

-(BOOL)didSnakeHitWall;








@end
