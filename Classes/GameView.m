//
//  GameView.m
//  Snake_2
//
//  Created by Swapan Rajdev on 7/31/10.
//  Copyright 2010 Zing! Apps. All rights reserved.
//

#import "GameView.h"

#import "snakeType.h"
#import "foodType.h"

#import "SnakeClassicAppDelegate.h"

#include <AudioToolbox/AudioToolbox.h>
#import "GKAchievementHandler.h"



@implementation GameView

@synthesize snake;
@synthesize food;
@synthesize gameOver;
@synthesize snakeColor;
@synthesize score;
@synthesize addFoodScore;
@synthesize addBonusFoodScore;
@synthesize walls;
@synthesize vibrate;

@synthesize sound;
@synthesize snakeLayer;
@synthesize snakeBackgroundLayer;
@synthesize masterLayer;
@synthesize foodLayer;
@synthesize bonusFoodLayer;
@synthesize wallLayer;
@synthesize foodEaten;
@synthesize foodValue;

@synthesize headColor;
@synthesize tailColor;
@synthesize speed;



// Function to setup the food layers used to draw the food
-(void)setupLayers{

	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	//Master layer to keep all the other layers withing
	
    if(IS_IPHONE_5){
        masterLayer = [CALayer layer];
    masterLayer.frame = CGRectMake(0,0,320,568);
    masterLayer.position = CGPointMake((320/2),(568/2)); // Center of portrait screen, as an example
        masterLayer.name = @"myLayer";
        masterLayer.delegate = delegate;

    }
    else{
        masterLayer = [CALayer layer];
	masterLayer.frame = CGRectMake(0,0,320,480);
	masterLayer.position = CGPointMake((320/2),(480/2)); // Center of portrait screen, as an example
        masterLayer.name = @"myLayer";
        masterLayer.delegate = delegate;

    }
	[self.layer addSublayer:masterLayer];
	
	
	
	// Bonus food layer to draw the bonus food
	bonusFoodLayer = [CALayer layer];
	bonusFoodLayer.frame = CGRectMake(0, 0, 10, 10);
	bonusFoodLayer.position = CGPointMake(food.bonus_food_x + 2.5, food.bonus_food_y + 2.5);
	UIImage *bonusFoodImage = [UIImage imageNamed:@"apple_green.png"];
	bonusFoodLayer.contents = (id)bonusFoodImage.CGImage;
	bonusFoodLayer.name = @"BonusFoodLayer";
	bonusFoodLayer.delegate = delegate;
	[masterLayer addSublayer:bonusFoodLayer];
	
	// Food layer to draw the actual food.
	foodLayer = [CALayer layer];
	
	foodLayer.frame = CGRectMake(0, 0, 10, 10);
	foodLayer.position = CGPointMake(food.food_x + 2.5, food.food_y + 2.5);
	UIImage *foodImage = [UIImage imageNamed:@"apple_red.png"];
	foodLayer.contents = (id)foodImage.CGImage;
	foodLayer.name = @"FoodLayer";
	foodLayer.delegate = delegate;
	[masterLayer addSublayer:foodLayer];
	
	if(IS_IPHONE_5){
        wallLayer = [CALayer layer];
        wallLayer.frame = CGRectMake(0, 0, 320, 568);
        wallLayer.position = CGPointMake((320/2), (568/2));
        wallLayer.name = @"WallLayer";
        wallLayer.delegate = delegate.activeGame;
        [masterLayer addSublayer:wallLayer];
    }
    else{
        wallLayer = [CALayer layer];
        wallLayer.frame = CGRectMake(0, 0, 320, 480);
        wallLayer.position = CGPointMake((320/2), (480/2));
        wallLayer.name = @"WallLayer";
        wallLayer.delegate = delegate.activeGame;
        [masterLayer addSublayer:wallLayer];
    }
}



-(id)initWithCoder:(NSCoder *)coder{
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
// If statement to check is there was any paused game before	
if (delegate.gameStatus != kGamePause || delegate.inTransition == YES/*delegate.gameMode == kExtremeMode*/) { // if there is no paused game

	
	snakeType *snaketobe = [[snakeType alloc] init]; 
	
	foodType *foodtobe = [[foodType alloc] init];
	
	if(self = [super initWithCoder:coder]){
		self.food = foodtobe;
		
		self.snake = snaketobe;
		if (delegate.gameMode == kExtremeMode) {
			self.score = delegate.delegateScore;
		}
		else {
			self.score = 0;
		}
		
		self.addFoodScore = 0;
		self.addBonusFoodScore = 0;
		self.walls = delegate.isWallOn;
		self.vibrate = delegate.isVibrateOn;
		self.sound = delegate.isSoundOn;
		self.foodEaten = 0;
        self.speed = delegate.speed;
		[self setupLayers];
	}
	
	[snaketobe release];
	[foodtobe release];
}
else {  // If there is a paused game
	
	snakeType *snaketobe = [[snakeType alloc] init]; 
	
	snaketobe.head_x = delegate.snakeHeadX;
	snaketobe.head_y = delegate.snakeHeadY;
	
	snaketobe.tail_x = delegate.snakeTailX;
	snaketobe.tail_y = delegate.snakeTailY;
	
	snaketobe.headDirection = delegate.snakeHeadDirection;
	snaketobe.tailDirection = delegate.snakeTailDirection;
	
	snaketobe.snakeColor = delegate.snakeColor;
		
	snaketobe.bends = delegate.snakeBends;
	snaketobe.bend_direction = delegate.snakeBendDirection;
	
	
	foodType *foodtobe = [[foodType alloc] init];
	
	foodtobe.food_x = delegate.snakeFoodX;
	foodtobe.food_y = delegate.snakeFoodY;
	
	foodtobe.bonus_food_x = -10;
	foodtobe.bonus_food_y = -10;
	
	if (self = [super initWithCoder:coder]) {
		
		self.food = foodtobe;
		
		self.snake = snaketobe;
		
		self.score = delegate.delegateScore;
		
		self.walls = delegate.isWallOn;
		self.vibrate = delegate.isVibrateOn;
		self.sound = delegate.isSoundOn;
		self.speed = delegate.speed;
        
            [self setupLayers];
		
	}
		
	[snaketobe release];
	[foodtobe release];
	
}
	
	
	if (delegate.snakeColor == [UIColor orangeColor]) {
		snakeColor = [[UIColor alloc] initWithRed:1 green:0.568 blue:0 alpha:1];
	}
	else if (delegate.snakeColor == [UIColor greenColor]){
		snakeColor = [[UIColor alloc] initWithRed:0.219 green:0.654 blue:0 alpha:1];
		
		
	}
	else if (delegate.snakeColor == [UIColor blackColor]){
		snakeColor = [[UIColor alloc] initWithRed:1 green:0.843 blue:0.0 alpha:1];
		
	}
	else if (delegate.snakeColor == [UIColor blueColor]){
		snakeColor = [[UIColor alloc] initWithRed:0 green:0.68 blue:0.67 alpha:1];
		
	}
	
	
	headColor = [[UIColor alloc] initWithRed:0.027 green:0.027 blue:0.027 alpha:0.4];
	
	[wallLayer setNeedsDisplay];
	[self setNeedsDisplay];
	
	return (self);
}
	



// DrawRect function to draw the snake

-(void)drawRect:(CGRect)rect{
	
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
 
	 /* DRAW SNAKE */
	
	CGContextBeginPath(context);
	
	CGContextSetLineWidth(context, 12.0);
	
	CGContextSetLineCap(context, kCGLineCapRound);
	
	CGContextSetStrokeColorWithColor(context, self.snakeColor.CGColor);
	
	CGContextSetLineJoin(context, kCGLineJoinRound);
	
	CGContextMoveToPoint(context, snake.tail_x,snake.tail_y);

	for (int i = 0; i < [snake.bends count]; i++) {
		
		NSData *bend_dir_value = [snake.bend_direction objectAtIndex:i];
		Direction bend_dir = *(Direction*)[bend_dir_value bytes];
		
		
		NSData *bend_value = [snake.bends objectAtIndex:i];
		CGPoint bend_point = *(CGPoint*)[bend_value bytes];
		
		if (bend_dir == kEastIn || bend_dir == kWestIn || bend_dir == kNorthIn || bend_dir == kSouthIn) {
			CGContextMoveToPoint(context, bend_point.x, bend_point.y);
		
		}
		else {
		
			CGContextAddLineToPoint(context, bend_point.x, bend_point.y);
			
		}
	}

    if(IS_IPHONE_5){
        
        if (delegate.isWallOn && delegate.fieldMode == kFullWall && snake.headDirection == kEastDirection && snake.head_x > 310) {
			CGContextAddLineToPoint(context, snake.head_x - 10, snake.head_y);
		}
		else if(delegate.isWallOn && delegate.fieldMode == kFullWall && snake.headDirection == kWestDirection && snake.head_x < 10){
			CGContextAddLineToPoint(context, snake.head_x + 10, snake.head_y );
		}
		else if(delegate.isWallOn && delegate.fieldMode == kFullWall && snake.headDirection == kNorthDirection && snake.head_y < 10){
			CGContextAddLineToPoint(context, snake.head_x, snake.head_y + 10);
		}
		else if(delegate.isWallOn && delegate.fieldMode == kFullWall && snake.headDirection == kSouthDirection && snake.head_y > 380){
			CGContextAddLineToPoint(context, snake.head_x, snake.head_y - 10);
		}
        
        else if (delegate.isWallOn && delegate.fieldMode == kHoleWall  && snake.headDirection == kEastDirection && snake.head_x > 310 && (snake.head_y <174 || snake.head_y > 216)) {
            CGContextAddLineToPoint(context, snake.head_x - 10, snake.head_y);
        }
        else if(delegate.isWallOn && delegate.fieldMode == kHoleWall  && snake.headDirection == kWestDirection && snake.head_x < 10 && (snake.head_y <174 || snake.head_y > 216)){
            CGContextAddLineToPoint(context, snake.head_x + 10, snake.head_y );
        }
        else if(delegate.isWallOn && delegate.fieldMode == kHoleWall  && snake.headDirection == kNorthDirection && (snake.head_y < 10 || (snake.head_y < 174 && (snake.head_x >310 || snake.head_x<10))) && (snake.head_x <140 || snake.head_x > 180)){
            CGContextAddLineToPoint(context, snake.head_x, snake.head_y + 10);
        }
        else if(delegate.isWallOn && delegate.fieldMode == kHoleWall && snake.headDirection == kSouthDirection && (snake.head_y > 380 || (snake.head_y > 216 && (snake.head_x >310 || snake.head_x<10))) && (snake.head_x <140 || snake.head_x > 180)){
            CGContextAddLineToPoint(context, snake.head_x, snake.head_y - 10);
        }
        
        
        else if (delegate.isWallOn && delegate.fieldMode == kSquareWall  && snake.headDirection == kEastDirection && (snake.head_x > 310 || (snake.head_x > 130 && snake.head_x <140) || (snake.head_x >180 && snake.head_x <190)) && (snake.head_y <174 || snake.head_y > 216)) {
            CGContextAddLineToPoint(context, snake.head_x - 10, snake.head_y);
        }
        else if(delegate.isWallOn && delegate.fieldMode == kSquareWall  && snake.headDirection == kWestDirection && ( snake.head_x < 10 || (snake.head_x > 130 && snake.head_x <140) || (snake.head_x >180 && snake.head_x <190)) && (snake.head_y <174 || snake.head_y > 216)){
            CGContextAddLineToPoint(context, snake.head_x + 10, snake.head_y );
        }
        else if(delegate.isWallOn && delegate.fieldMode == kSquareWall  && snake.headDirection == kNorthDirection && (snake.head_y < 10 || (snake.head_y < 174 && (snake.head_x >310 || snake.head_x<10 || snake.head_x == 135 || snake.head_x == 185))) && (snake.head_x <140 || snake.head_x > 180)){
            CGContextAddLineToPoint(context, snake.head_x, snake.head_y + 10);
        }
        else if(delegate.isWallOn && delegate.fieldMode == kSquareWall && snake.headDirection == kSouthDirection && (snake.head_y > 380 || (snake.head_y > 216 && (snake.head_x >310 || snake.head_x<10 || snake.head_x == 135 || snake.head_x == 185))) && (snake.head_x <140 || snake.head_x > 180)){
            CGContextAddLineToPoint(context, snake.head_x, snake.head_y - 10);
        }
        
        
		else {
			CGContextAddLineToPoint(context, snake.head_x, snake.head_y);
		}

    }else{
	

		if (delegate.isWallOn && delegate.fieldMode == kFullWall && snake.headDirection == kEastDirection && snake.head_x > 310) {
			CGContextAddLineToPoint(context, snake.head_x - 10, snake.head_y);
		}
		else if(delegate.isWallOn && delegate.fieldMode == kFullWall && snake.headDirection == kWestDirection && snake.head_x < 10){
			CGContextAddLineToPoint(context, snake.head_x + 10, snake.head_y );
		}
		else if(delegate.isWallOn && delegate.fieldMode == kFullWall && snake.headDirection == kNorthDirection && snake.head_y < 10){
			CGContextAddLineToPoint(context, snake.head_x, snake.head_y + 10);
		}
		else if(delegate.isWallOn && delegate.fieldMode == kFullWall && snake.headDirection == kSouthDirection && snake.head_y > 290){
			CGContextAddLineToPoint(context, snake.head_x, snake.head_y - 10);
		}
	
	else if (delegate.isWallOn && delegate.fieldMode == kHoleWall  && snake.headDirection == kEastDirection && snake.head_x > 310 && (snake.head_y <129 || snake.head_y > 171)) {
		CGContextAddLineToPoint(context, snake.head_x - 10, snake.head_y);
	}
	else if(delegate.isWallOn && delegate.fieldMode == kHoleWall  && snake.headDirection == kWestDirection && snake.head_x < 10 && (snake.head_y <129 || snake.head_y > 171)){
		CGContextAddLineToPoint(context, snake.head_x + 10, snake.head_y );
	}
	else if(delegate.isWallOn && delegate.fieldMode == kHoleWall  && snake.headDirection == kNorthDirection && (snake.head_y < 10 || (snake.head_y < 129 && (snake.head_x >310 || snake.head_x<10))) && (snake.head_x <140 || snake.head_x > 180)){
		CGContextAddLineToPoint(context, snake.head_x, snake.head_y + 10);
	}
	else if(delegate.isWallOn && delegate.fieldMode == kHoleWall && snake.headDirection == kSouthDirection && (snake.head_y > 290 || (snake.head_y > 171 && (snake.head_x >310 || snake.head_x<10))) && (snake.head_x <140 || snake.head_x > 180)){
		CGContextAddLineToPoint(context, snake.head_x, snake.head_y - 10);
	}
	
	
	else if (delegate.isWallOn && delegate.fieldMode == kSquareWall  && snake.headDirection == kEastDirection && (snake.head_x > 310 || (snake.head_x > 130 && snake.head_x <140) || (snake.head_x >180 && snake.head_x <190)) && (snake.head_y <129 || snake.head_y > 171)) {
		CGContextAddLineToPoint(context, snake.head_x - 10, snake.head_y);
	}
	else if(delegate.isWallOn && delegate.fieldMode == kSquareWall  && snake.headDirection == kWestDirection && ( snake.head_x < 10 || (snake.head_x > 130 && snake.head_x <140) || (snake.head_x >180 && snake.head_x <190)) && (snake.head_y <129 || snake.head_y > 171)){
		CGContextAddLineToPoint(context, snake.head_x + 10, snake.head_y );
	}
	else if(delegate.isWallOn && delegate.fieldMode == kSquareWall  && snake.headDirection == kNorthDirection && (snake.head_y < 10 || (snake.head_y < 129 && (snake.head_x >310 || snake.head_x<10 || snake.head_x == 135 || snake.head_x == 185))) && (snake.head_x <140 || snake.head_x > 180)){
		CGContextAddLineToPoint(context, snake.head_x, snake.head_y + 10);
	}
	else if(delegate.isWallOn && delegate.fieldMode == kSquareWall && snake.headDirection == kSouthDirection && (snake.head_y > 290 || (snake.head_y > 171 && (snake.head_x >310 || snake.head_x<10 || snake.head_x == 135 || snake.head_x == 185))) && (snake.head_x <140 || snake.head_x > 180)){
		CGContextAddLineToPoint(context, snake.head_x, snake.head_y - 10);
	}
	
	
		else {
			CGContextAddLineToPoint(context, snake.head_x, snake.head_y);
		}
	
	}
	

	CGContextStrokePath(context);
	
	/* ---- END OF DRAW SNAKE ----- */
	
	
	/* --- Snake Head --- */
	
	CGContextBeginPath(context);
	
	CGContextSetLineWidth(context, 6.0);
	
	CGContextSetStrokeColorWithColor(context, headColor.CGColor);
	
    if(IS_IPHONE_5) {
        if (delegate.isWallOn && delegate.fieldMode == kFullWall && snake.head_x > 310 && snake.headDirection == kEastDirection) {
            CGContextAddEllipseInRect(context, CGRectMake(snake.head_x -16, snake.head_y - 3,9 , 6));
        }
        else if(delegate.isWallOn && delegate.fieldMode == kFullWall && snake.head_x < 10 && snake.headDirection == kWestDirection){
            CGContextAddEllipseInRect(context, CGRectMake(snake.head_x +7, snake.head_y - 3,9 , 6));
            
        }
        else if(delegate.isWallOn && delegate.fieldMode == kFullWall && snake.head_y > 380 && snake.headDirection == kSouthDirection){
            CGContextAddEllipseInRect(context, CGRectMake(snake.head_x - 3, snake.head_y - 16,6 , 9));
            
        }
        else if(delegate.isWallOn && delegate.fieldMode == kFullWall && snake.head_y < 10 && snake.headDirection == kNorthDirection){
            CGContextAddEllipseInRect(context, CGRectMake(snake.head_x - 3, snake.head_y +7,6 , 9));
        }
        else if (delegate.isWallOn && delegate.fieldMode == kHoleWall  && snake.headDirection == kEastDirection && snake.head_x > 310 && (snake.head_y <174 || snake.head_y > 216)) {
            CGContextAddEllipseInRect(context, CGRectMake(snake.head_x -16, snake.head_y - 3,9 , 6));
        }
        else if(delegate.isWallOn && delegate.fieldMode == kHoleWall  && snake.headDirection == kWestDirection && snake.head_x < 10 && (snake.head_y <174 || snake.head_y > 216)){
            CGContextAddEllipseInRect(context, CGRectMake(snake.head_x +7, snake.head_y - 3,9 , 6));
        }
        else if(delegate.isWallOn && delegate.fieldMode == kHoleWall  && snake.headDirection == kNorthDirection && (snake.head_y < 10 || (snake.head_y < 174 && (snake.head_x >310 || snake.head_x<10))) && (snake.head_x <140 || snake.head_x > 180)){
            CGContextAddEllipseInRect(context, CGRectMake(snake.head_x - 3, snake.head_y +7,6 , 9));
        }
        else if(delegate.isWallOn && delegate.fieldMode == kHoleWall && snake.headDirection == kSouthDirection && (snake.head_y > 380 || (snake.head_y > 216 && (snake.head_x >310 || snake.head_x<10))) && (snake.head_x <140 || snake.head_x > 180)){
            CGContextAddEllipseInRect(context, CGRectMake(snake.head_x - 3, snake.head_y - 16,6 , 9));
        }
        
        
        else if (delegate.isWallOn && delegate.fieldMode == kSquareWall  && snake.headDirection == kEastDirection && (snake.head_x > 310 || (snake.head_x > 130 && snake.head_x <140) || (snake.head_x >180 && snake.head_x <190)) && (snake.head_y <174 || snake.head_y > 216)) {
            CGContextAddEllipseInRect(context, CGRectMake(snake.head_x -16, snake.head_y - 3,9 , 6));
        }
        else if(delegate.isWallOn && delegate.fieldMode == kSquareWall  && snake.headDirection == kWestDirection && ( snake.head_x < 10 || (snake.head_x > 130 && snake.head_x <140) || (snake.head_x >180 && snake.head_x <190)) && (snake.head_y <174 || snake.head_y > 216)){
            CGContextAddEllipseInRect(context, CGRectMake(snake.head_x +7, snake.head_y - 3,9 , 6));
        }
        else if(delegate.isWallOn && delegate.fieldMode == kSquareWall  && snake.headDirection == kNorthDirection && (snake.head_y < 10 || (snake.head_y < 174 && (snake.head_x >310 || snake.head_x<10 || snake.head_x == 135 || snake.head_x == 185))) && (snake.head_x <140 || snake.head_x > 180)){
            CGContextAddEllipseInRect(context, CGRectMake(snake.head_x - 3, snake.head_y +7,6 , 9));
        }
        else if(delegate.isWallOn && delegate.fieldMode == kSquareWall && snake.headDirection == kSouthDirection && (snake.head_y > 380 || (snake.head_y > 216 && (snake.head_x >310 || snake.head_x<10 || snake.head_x == 135 || snake.head_x == 185))) && (snake.head_x <140 || snake.head_x > 180)){
            CGContextAddEllipseInRect(context, CGRectMake(snake.head_x - 3, snake.head_y - 16,6 , 9));
        }
        
        else if (snake.headDirection == kEastDirection) {
            CGContextAddEllipseInRect(context, CGRectMake(snake.head_x - 6, snake.head_y - 3,9 , 6));
        }
        else if(snake.headDirection == kWestDirection){
            CGContextAddEllipseInRect(context, CGRectMake(snake.head_x -3, snake.head_y - 3,9 , 6));
            
        }
        else if(snake.headDirection == kSouthDirection){
            CGContextAddEllipseInRect(context, CGRectMake(snake.head_x - 3, snake.head_y - 6,6 , 9));
            
        }
        else if(snake.headDirection == kNorthDirection){
            CGContextAddEllipseInRect(context, CGRectMake(snake.head_x - 3, snake.head_y - 3,6 , 9));	
        }
    }else{
	
	if (delegate.isWallOn && delegate.fieldMode == kFullWall && snake.head_x > 310 && snake.headDirection == kEastDirection) {
		CGContextAddEllipseInRect(context, CGRectMake(snake.head_x -16, snake.head_y - 3,9 , 6));
	}
	else if(delegate.isWallOn && delegate.fieldMode == kFullWall && snake.head_x < 10 && snake.headDirection == kWestDirection){
		CGContextAddEllipseInRect(context, CGRectMake(snake.head_x +7, snake.head_y - 3,9 , 6));	
		
	}
	else if(delegate.isWallOn && delegate.fieldMode == kFullWall && snake.head_y > 290 && snake.headDirection == kSouthDirection){
		CGContextAddEllipseInRect(context, CGRectMake(snake.head_x - 3, snake.head_y - 16,6 , 9));
		
	}
	else if(delegate.isWallOn && delegate.fieldMode == kFullWall && snake.head_y < 10 && snake.headDirection == kNorthDirection){
		CGContextAddEllipseInRect(context, CGRectMake(snake.head_x - 3, snake.head_y +7,6 , 9));	
	}
	else if (delegate.isWallOn && delegate.fieldMode == kHoleWall  && snake.headDirection == kEastDirection && snake.head_x > 310 && (snake.head_y <129 || snake.head_y > 171)) {
		CGContextAddEllipseInRect(context, CGRectMake(snake.head_x -16, snake.head_y - 3,9 , 6));
	}
	else if(delegate.isWallOn && delegate.fieldMode == kHoleWall  && snake.headDirection == kWestDirection && snake.head_x < 10 && (snake.head_y <129 || snake.head_y > 171)){
		CGContextAddEllipseInRect(context, CGRectMake(snake.head_x +7, snake.head_y - 3,9 , 6));	
	}
	else if(delegate.isWallOn && delegate.fieldMode == kHoleWall  && snake.headDirection == kNorthDirection && (snake.head_y < 10 || (snake.head_y < 129 && (snake.head_x >310 || snake.head_x<10))) && (snake.head_x <140 || snake.head_x > 180)){
		CGContextAddEllipseInRect(context, CGRectMake(snake.head_x - 3, snake.head_y +7,6 , 9));	
	}
	else if(delegate.isWallOn && delegate.fieldMode == kHoleWall && snake.headDirection == kSouthDirection && (snake.head_y > 290 || (snake.head_y > 171 && (snake.head_x >310 || snake.head_x<10))) && (snake.head_x <140 || snake.head_x > 180)){
		CGContextAddEllipseInRect(context, CGRectMake(snake.head_x - 3, snake.head_y - 16,6 , 9));
	}
	else if (delegate.isWallOn && delegate.fieldMode == kSquareWall  && snake.headDirection == kEastDirection && (snake.head_x > 310 || (snake.head_x > 130 && snake.head_x <140) || (snake.head_x >180 && snake.head_x <190)) && (snake.head_y <129 || snake.head_y > 171)) {
		CGContextAddEllipseInRect(context, CGRectMake(snake.head_x -16, snake.head_y - 3,9 , 6));
	}
	else if(delegate.isWallOn && delegate.fieldMode == kSquareWall  && snake.headDirection == kWestDirection && ( snake.head_x < 10 || (snake.head_x > 130 && snake.head_x <140) || (snake.head_x >180 && snake.head_x <190)) && (snake.head_y <129 || snake.head_y > 171)){
		CGContextAddEllipseInRect(context, CGRectMake(snake.head_x +7, snake.head_y - 3,9 , 6));	
	}
	else if(delegate.isWallOn && delegate.fieldMode == kSquareWall  && snake.headDirection == kNorthDirection && (snake.head_y < 10 || (snake.head_y < 129 && (snake.head_x >310 || snake.head_x<10 || snake.head_x == 135 || snake.head_x == 185))) && (snake.head_x <140 || snake.head_x > 180)){
		CGContextAddEllipseInRect(context, CGRectMake(snake.head_x - 3, snake.head_y +7,6 , 9));	
	}
	else if(delegate.isWallOn && delegate.fieldMode == kSquareWall && snake.headDirection == kSouthDirection && (snake.head_y > 290 || (snake.head_y > 171 && (snake.head_x >310 || snake.head_x<10 || snake.head_x == 135 || snake.head_x == 185))) && (snake.head_x <140 || snake.head_x > 180)){
		CGContextAddEllipseInRect(context, CGRectMake(snake.head_x - 3, snake.head_y - 16,6 , 9));
	}
	else if (snake.headDirection == kEastDirection) {
		CGContextAddEllipseInRect(context, CGRectMake(snake.head_x - 6, snake.head_y - 3,9 , 6));
	}
	else if(snake.headDirection == kWestDirection){
		CGContextAddEllipseInRect(context, CGRectMake(snake.head_x -3, snake.head_y - 3,9 , 6));	
		
	}
	else if(snake.headDirection == kSouthDirection){
		CGContextAddEllipseInRect(context, CGRectMake(snake.head_x - 3, snake.head_y - 6,6 , 9));
		
	}
	else if(snake.headDirection == kNorthDirection){
		CGContextAddEllipseInRect(context, CGRectMake(snake.head_x - 3, snake.head_y - 3,6 , 9));	
	}
	
	}
	
			CGContextStrokePath(context);
	
	if ([self onSnake:CGPointMake(snake.head_x, snake.head_y) check_food:NO] == NO) {
		
	
	
	CGContextBeginPath(context);
	
	CGContextSetLineWidth(context, 1.5);
	
	CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
	

        if(IS_IPHONE_5){
            if (delegate.isWallOn && delegate.fieldMode == kFullWall && snake.head_x > 310 && snake.headDirection == kEastDirection) {
                
            }
            else if(delegate.isWallOn && delegate.fieldMode == kFullWall && snake.head_x < 10 && snake.headDirection == kWestDirection){
                
                
            }
            else if(delegate.isWallOn && delegate.fieldMode == kFullWall && snake.head_y > 380 && snake.headDirection == kSouthDirection){
                
                
            }
            else if(delegate.isWallOn && delegate.fieldMode == kFullWall && snake.head_y < 10 && snake.headDirection == kNorthDirection){
                
            }
            else if (delegate.isWallOn && delegate.fieldMode == kHoleWall  && snake.headDirection == kEastDirection && snake.head_x > 310 && (snake.head_y <174 || snake.head_y > 216)) {
                
            }
            else if(delegate.isWallOn && delegate.fieldMode == kHoleWall  && snake.headDirection == kWestDirection && snake.head_x < 10 && (snake.head_y <174 || snake.head_y > 216)){
                
            }
            else if(delegate.isWallOn && delegate.fieldMode == kHoleWall  && snake.headDirection == kNorthDirection && (snake.head_y < 10 || (snake.head_y < 174 && (snake.head_x >310 || snake.head_x<10))) && (snake.head_x <140 || snake.head_x > 180)){
                
            }
            else if(delegate.isWallOn && delegate.fieldMode == kHoleWall && snake.headDirection == kSouthDirection && (snake.head_y > 380 || (snake.head_y > 216 && (snake.head_x >310 || snake.head_x<10))) && (snake.head_x <140 || snake.head_x > 180)){
                
            }
            else if (delegate.isWallOn && delegate.fieldMode == kSquareWall  && snake.headDirection == kEastDirection && (snake.head_x > 310 || (snake.head_x > 130 && snake.head_x <140) || (snake.head_x >180 && snake.head_x <190)) && (snake.head_y <174 || snake.head_y > 216)) {
                
            }
            else if(delegate.isWallOn && delegate.fieldMode == kSquareWall  && snake.headDirection == kWestDirection && ( snake.head_x < 10 || (snake.head_x > 130 && snake.head_x <140) || (snake.head_x >180 && snake.head_x <190)) && (snake.head_y <174 || snake.head_y > 216)){
                
            }
            else if(delegate.isWallOn && delegate.fieldMode == kSquareWall  && snake.headDirection == kNorthDirection && (snake.head_y < 10 || (snake.head_y < 174 && (snake.head_x >310 || snake.head_x<10 || snake.head_x == 135 || snake.head_x == 185))) && (snake.head_x <140 || snake.head_x > 180)){
                
            }
            else if(delegate.isWallOn && delegate.fieldMode == kSquareWall && snake.headDirection == kSouthDirection && (snake.head_y > 378 || (snake.head_y > 216 && (snake.head_x >310 || snake.head_x<10 || snake.head_x == 135 || snake.head_x == 185))) && (snake.head_x <140 || snake.head_x > 180)){
                
            }
            else if (snake.headDirection == kEastDirection) {
                CGContextAddEllipseInRect(context, CGRectMake(snake.head_x, snake.head_y - 3 ,1.5 , 1.5));
                CGContextAddEllipseInRect(context, CGRectMake(snake.head_x , snake.head_y + 2 ,1.5 , 1.5	));
            }
            else if(snake.headDirection == kWestDirection){
                CGContextAddEllipseInRect(context, CGRectMake(snake.head_x, snake.head_y - 3 ,1.5 , 1.5));
                CGContextAddEllipseInRect(context, CGRectMake(snake.head_x , snake.head_y + 2 ,1.5 , 1.5	));
            }
            
            else if (snake.headDirection == kSouthDirection){
                CGContextAddEllipseInRect(context, CGRectMake(snake.head_x -3 , snake.head_y  ,1.5 , 1.5));
                CGContextAddEllipseInRect(context, CGRectMake(snake.head_x + 2, snake.head_y ,1.5 , 1.5	));
            }
            else if (snake.headDirection == kNorthDirection){
                CGContextAddEllipseInRect(context, CGRectMake(snake.head_x -3 , snake.head_y  ,1.5 , 1.5));
                CGContextAddEllipseInRect(context, CGRectMake(snake.head_x + 2, snake.head_y ,1.5 , 1.5	));
            }
            
        }
        
        else{
            
        
		if (delegate.isWallOn && delegate.fieldMode == kFullWall && snake.head_x > 310 && snake.headDirection == kEastDirection) {
			
		}
		else if(delegate.isWallOn && delegate.fieldMode == kFullWall && snake.head_x < 10 && snake.headDirection == kWestDirection){
			
			
		}
		else if(delegate.isWallOn && delegate.fieldMode == kFullWall && snake.head_y > 290 && snake.headDirection == kSouthDirection){
			
			
		}
		else if(delegate.isWallOn && delegate.fieldMode == kFullWall && snake.head_y < 10 && snake.headDirection == kNorthDirection){
			
		}
		else if (delegate.isWallOn && delegate.fieldMode == kHoleWall  && snake.headDirection == kEastDirection && snake.head_x > 310 && (snake.head_y <129 || snake.head_y > 171)) {
			
		}
		else if(delegate.isWallOn && delegate.fieldMode == kHoleWall  && snake.headDirection == kWestDirection && snake.head_x < 10 && (snake.head_y <129 || snake.head_y > 171)){
			
		}
		else if(delegate.isWallOn && delegate.fieldMode == kHoleWall  && snake.headDirection == kNorthDirection && (snake.head_y < 10 || (snake.head_y < 129 && (snake.head_x >310 || snake.head_x<10))) && (snake.head_x <140 || snake.head_x > 180)){
			
		}
		else if(delegate.isWallOn && delegate.fieldMode == kHoleWall && snake.headDirection == kSouthDirection && (snake.head_y > 290 || (snake.head_y > 171 && (snake.head_x >310 || snake.head_x<10))) && (snake.head_x <140 || snake.head_x > 180)){
			
		}
		
		
		else if (delegate.isWallOn && delegate.fieldMode == kSquareWall  && snake.headDirection == kEastDirection && (snake.head_x > 310 || (snake.head_x > 130 && snake.head_x <140) || (snake.head_x >180 && snake.head_x <190)) && (snake.head_y <129 || snake.head_y > 171)) {
			
		}
		else if(delegate.isWallOn && delegate.fieldMode == kSquareWall  && snake.headDirection == kWestDirection && ( snake.head_x < 10 || (snake.head_x > 130 && snake.head_x <140) || (snake.head_x >180 && snake.head_x <190)) && (snake.head_y <129 || snake.head_y > 171)){
			
		}
		else if(delegate.isWallOn && delegate.fieldMode == kSquareWall  && snake.headDirection == kNorthDirection && (snake.head_y < 10 || (snake.head_y < 129 && (snake.head_x >310 || snake.head_x<10 || snake.head_x == 135 || snake.head_x == 185))) && (snake.head_x <140 || snake.head_x > 180)){
			
		}
		else if(delegate.isWallOn && delegate.fieldMode == kSquareWall && snake.headDirection == kSouthDirection && (snake.head_y > 290 || (snake.head_y > 171 && (snake.head_x >310 || snake.head_x<10 || snake.head_x == 135 || snake.head_x == 185))) && (snake.head_x <140 || snake.head_x > 180)){
			
		}
		else if (snake.headDirection == kEastDirection) {
		CGContextAddEllipseInRect(context, CGRectMake(snake.head_x, snake.head_y - 3 ,1.5 , 1.5));
		CGContextAddEllipseInRect(context, CGRectMake(snake.head_x , snake.head_y + 2 ,1.5 , 1.5	));
	}
	else if(snake.headDirection == kWestDirection){
		CGContextAddEllipseInRect(context, CGRectMake(snake.head_x, snake.head_y - 3 ,1.5 , 1.5));
		CGContextAddEllipseInRect(context, CGRectMake(snake.head_x , snake.head_y + 2 ,1.5 , 1.5	));	
	}
	
	else if (snake.headDirection == kSouthDirection){
		CGContextAddEllipseInRect(context, CGRectMake(snake.head_x -3 , snake.head_y  ,1.5 , 1.5));
		CGContextAddEllipseInRect(context, CGRectMake(snake.head_x + 2, snake.head_y ,1.5 , 1.5	));
	}
	else if (snake.headDirection == kNorthDirection){
		CGContextAddEllipseInRect(context, CGRectMake(snake.head_x -3 , snake.head_y  ,1.5 , 1.5));
		CGContextAddEllipseInRect(context, CGRectMake(snake.head_x + 2, snake.head_y ,1.5 , 1.5	));
	}
	
        }
	
	
	CGContextStrokePath(context);
		
	}
	
	if ([self onSnake:CGPointMake(snake.head_x, snake.head_y) check_food:NO] == NO) {
		
		
		CGContextBeginPath(context);
		
		CGContextSetLineWidth(context, 0.5);
		
		CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
		
		if(IS_IPHONE_5){
            if (delegate.isWallOn && delegate.fieldMode == kFullWall && snake.head_x > 310 && snake.headDirection == kEastDirection) {
                
            }
            else if(delegate.isWallOn && delegate.fieldMode == kFullWall && snake.head_x < 10 && snake.headDirection == kWestDirection){
                
                
            }
            else if(delegate.isWallOn && delegate.fieldMode == kFullWall && snake.head_y > 380 && snake.headDirection == kSouthDirection){
                
                
            }
            else if(delegate.isWallOn && delegate.fieldMode == kFullWall && snake.head_y < 10 && snake.headDirection == kNorthDirection){
                
            }
            else if (delegate.isWallOn && delegate.fieldMode == kHoleWall  && snake.headDirection == kEastDirection && snake.head_x > 310 && (snake.head_y <174 || snake.head_y > 216)) {
                
            }
            else if(delegate.isWallOn && delegate.fieldMode == kHoleWall  && snake.headDirection == kWestDirection && snake.head_x < 10 && (snake.head_y <174 || snake.head_y > 216)){
                
            }
            else if(delegate.isWallOn && delegate.fieldMode == kHoleWall  && snake.headDirection == kNorthDirection && (snake.head_y < 10 || (snake.head_y < 174 && (snake.head_x >310 || snake.head_x<10))) && (snake.head_x <140 || snake.head_x > 180)){
                
            }
            else if(delegate.isWallOn && delegate.fieldMode == kHoleWall && snake.headDirection == kSouthDirection && (snake.head_y > 380 || (snake.head_y > 216 && (snake.head_x >310 || snake.head_x<10))) && (snake.head_x <140 || snake.head_x > 180)){
                
            }
            
            
            else if (delegate.isWallOn && delegate.fieldMode == kSquareWall  && snake.headDirection == kEastDirection && (snake.head_x > 310 || (snake.head_x > 130 && snake.head_x <140) || (snake.head_x >180 && snake.head_x <190)) && (snake.head_y <174 || snake.head_y > 216)) {
                
            }
            else if(delegate.isWallOn && delegate.fieldMode == kSquareWall  && snake.headDirection == kWestDirection && ( snake.head_x < 10 || (snake.head_x > 130 && snake.head_x <140) || (snake.head_x >180 && snake.head_x <190)) && (snake.head_y <173 || snake.head_y > 215)){
                
            }
            else if(delegate.isWallOn && delegate.fieldMode == kSquareWall  && snake.headDirection == kNorthDirection && (snake.head_y < 10 || (snake.head_y < 174 && (snake.head_x >310 || snake.head_x<10 || snake.head_x == 135 || snake.head_x == 185))) && (snake.head_x <140 || snake.head_x > 180)){
                
            }
            else if(delegate.isWallOn && delegate.fieldMode == kSquareWall && snake.headDirection == kSouthDirection && (snake.head_y > 380 || (snake.head_y > 216 && (snake.head_x >310 || snake.head_x<10 || snake.head_x == 135 || snake.head_x == 185))) && (snake.head_x <140 || snake.head_x > 180)){
                
            }
            else if (snake.headDirection == kEastDirection) {
                CGContextAddEllipseInRect(context, CGRectMake(snake.head_x+ 0.5, snake.head_y - 2.5 ,0.75 , 0.75));
                CGContextAddEllipseInRect(context, CGRectMake(snake.head_x +0.5, snake.head_y + 2.5 ,0.75 , 0.75	));
            }
            else if(snake.headDirection == kWestDirection){
                CGContextAddEllipseInRect(context, CGRectMake(snake.head_x+ 0.5, snake.head_y - 2.5 ,0.75 , 0.75));
                CGContextAddEllipseInRect(context, CGRectMake(snake.head_x  +0.5, snake.head_y + 2.5 ,0.75 , 0.75	));
            }
            
            else if (snake.headDirection == kSouthDirection){
                CGContextAddEllipseInRect(context, CGRectMake(snake.head_x -2.5 , snake.head_y +0.5  ,0.75 , 0.75));
                CGContextAddEllipseInRect(context, CGRectMake(snake.head_x + 2.5, snake.head_y+0.5 ,0.75 , 0.75	));
            }
            else if (snake.headDirection == kNorthDirection){
                CGContextAddEllipseInRect(context, CGRectMake(snake.head_x -2.5 , snake.head_y +0.5  ,0.75 , 0.75));
                CGContextAddEllipseInRect(context, CGRectMake(snake.head_x + 2.5, snake.head_y+0.5 ,0.75 , 0.75	));
            }
            
        }
        else{
		if (delegate.isWallOn && delegate.fieldMode == kFullWall && snake.head_x > 310 && snake.headDirection == kEastDirection) {
			
		}
		else if(delegate.isWallOn && delegate.fieldMode == kFullWall && snake.head_x < 10 && snake.headDirection == kWestDirection){
			
			
		}
		else if(delegate.isWallOn && delegate.fieldMode == kFullWall && snake.head_y > 290 && snake.headDirection == kSouthDirection){
			
			
		}
		else if(delegate.isWallOn && delegate.fieldMode == kFullWall && snake.head_y < 10 && snake.headDirection == kNorthDirection){
			
		}
		else if (delegate.isWallOn && delegate.fieldMode == kHoleWall  && snake.headDirection == kEastDirection && snake.head_x > 310 && (snake.head_y <129 || snake.head_y > 171)) {
			
		}
		else if(delegate.isWallOn && delegate.fieldMode == kHoleWall  && snake.headDirection == kWestDirection && snake.head_x < 10 && (snake.head_y <129 || snake.head_y > 171)){
			
		}
		else if(delegate.isWallOn && delegate.fieldMode == kHoleWall  && snake.headDirection == kNorthDirection && (snake.head_y < 10 || (snake.head_y < 129 && (snake.head_x >310 || snake.head_x<10))) && (snake.head_x <140 || snake.head_x > 180)){
			
		}
		else if(delegate.isWallOn && delegate.fieldMode == kHoleWall && snake.headDirection == kSouthDirection && (snake.head_y > 290 || (snake.head_y > 171 && (snake.head_x >310 || snake.head_x<10))) && (snake.head_x <140 || snake.head_x > 180)){
			
		}
		
		
		else if (delegate.isWallOn && delegate.fieldMode == kSquareWall  && snake.headDirection == kEastDirection && (snake.head_x > 310 || (snake.head_x > 130 && snake.head_x <140) || (snake.head_x >180 && snake.head_x <190)) && (snake.head_y <129 || snake.head_y > 171)) {
			
		}
		else if(delegate.isWallOn && delegate.fieldMode == kSquareWall  && snake.headDirection == kWestDirection && ( snake.head_x < 10 || (snake.head_x > 130 && snake.head_x <140) || (snake.head_x >180 && snake.head_x <190)) && (snake.head_y <129 || snake.head_y > 171)){
			
		}
		else if(delegate.isWallOn && delegate.fieldMode == kSquareWall  && snake.headDirection == kNorthDirection && (snake.head_y < 10 || (snake.head_y < 129 && (snake.head_x >310 || snake.head_x<10 || snake.head_x == 135 || snake.head_x == 185))) && (snake.head_x <140 || snake.head_x > 180)){
			
		}
		else if(delegate.isWallOn && delegate.fieldMode == kSquareWall && snake.headDirection == kSouthDirection && (snake.head_y > 290 || (snake.head_y > 171 && (snake.head_x >310 || snake.head_x<10 || snake.head_x == 135 || snake.head_x == 185))) && (snake.head_x <140 || snake.head_x > 180)){
			
		}
		else if (snake.headDirection == kEastDirection) {
			CGContextAddEllipseInRect(context, CGRectMake(snake.head_x+ 0.5, snake.head_y - 2.5 ,0.75 , 0.75));
			CGContextAddEllipseInRect(context, CGRectMake(snake.head_x +0.5, snake.head_y + 2.5 ,0.75 , 0.75	));
		}
		else if(snake.headDirection == kWestDirection){
			CGContextAddEllipseInRect(context, CGRectMake(snake.head_x+ 0.5, snake.head_y - 2.5 ,0.75 , 0.75));
			CGContextAddEllipseInRect(context, CGRectMake(snake.head_x  +0.5, snake.head_y + 2.5 ,0.75 , 0.75	));	
		}
		
		else if (snake.headDirection == kSouthDirection){
			CGContextAddEllipseInRect(context, CGRectMake(snake.head_x -2.5 , snake.head_y +0.5  ,0.75 , 0.75));
			CGContextAddEllipseInRect(context, CGRectMake(snake.head_x + 2.5, snake.head_y+0.5 ,0.75 , 0.75	));
		}
		else if (snake.headDirection == kNorthDirection){
			CGContextAddEllipseInRect(context, CGRectMake(snake.head_x -2.5 , snake.head_y +0.5  ,0.75 , 0.75));
			CGContextAddEllipseInRect(context, CGRectMake(snake.head_x + 2.5, snake.head_y+0.5 ,0.75 , 0.75	));
		}
		
		}
		
		
		CGContextStrokePath(context);
		
	}
	
	
	/* --- DRAW TAIL --- */
	
	CGContextBeginPath(context);
	
	
	
	//CGContextSetStrokeColorWithColor(context, headColor.CGColor);
	
	
	if (snake.tailDirection == kEastDirection) {
		
		CGContextAddArc(context, snake.tail_x, snake.tail_y, 6.0, M_PI/2, (M_PI + M_PI/2), 0);
	}
	else if (snake.tailDirection == kWestDirection) {
		CGContextAddArc(context, snake.tail_x, snake.tail_y, 6.0, M_PI/2, (M_PI + M_PI/2), 1);
	}
	else if(snake.tailDirection == kSouthDirection){
	CGContextAddArc(context, snake.tail_x, snake.tail_y, 6.0, 0, M_PI, 1);	
		
	}
	else if(snake.tailDirection == kNorthDirection){
		CGContextAddArc(context, snake.tail_x, snake.tail_y, 6.0, 0, M_PI, 0);
	}

	
	CGContextSetRGBFillColor(context, 0.027, 0.027, 0.027, 0.4);
	
	
	CGContextFillPath(context);
	
	
	CGContextBeginPath(context);
	
	if(snake.tailDirection == kEastDirection){
		CGContextMoveToPoint(context, snake.tail_x, snake.tail_y - 6);

		CGContextAddLineToPoint(context, snake.tail_x + 2, snake.tail_y - 6);
		CGContextAddLineToPoint(context, snake.tail_x+ 2, snake.tail_y + 6);
	
		CGContextAddLineToPoint(context, snake.tail_x, snake.tail_y + 6);
	
		CGContextAddLineToPoint(context, snake.tail_x, snake.tail_y - 6);
	}
	else if(snake.tailDirection == kWestDirection){
		
		CGContextMoveToPoint(context, snake.tail_x, snake.tail_y - 6);
		
		CGContextAddLineToPoint(context, snake.tail_x - 2, snake.tail_y - 6);
		CGContextAddLineToPoint(context, snake.tail_x - 2, snake.tail_y + 6);
		
		CGContextAddLineToPoint(context, snake.tail_x, snake.tail_y + 6);
		
		CGContextAddLineToPoint(context, snake.tail_x, snake.tail_y - 6);
		
	}
	else if(snake.tailDirection == kNorthDirection){
		
		CGContextMoveToPoint(context, snake.tail_x - 6, snake.tail_y );
		
		CGContextAddLineToPoint(context, snake.tail_x - 6, snake.tail_y - 2);
		CGContextAddLineToPoint(context, snake.tail_x + 6, snake.tail_y - 2);
		
		CGContextAddLineToPoint(context, snake.tail_x + 6, snake.tail_y );
		
		CGContextAddLineToPoint(context, snake.tail_x - 6, snake.tail_y);
		
	}
	else if(snake.tailDirection == kSouthDirection){
		
		CGContextMoveToPoint(context, snake.tail_x - 6, snake.tail_y );
		
		CGContextAddLineToPoint(context, snake.tail_x - 6, snake.tail_y + 2);
		CGContextAddLineToPoint(context, snake.tail_x + 6, snake.tail_y + 2);
		
		CGContextAddLineToPoint(context, snake.tail_x + 6, snake.tail_y );
		
		CGContextAddLineToPoint(context, snake.tail_x - 6, snake.tail_y);
		
	}
	
	CGContextSetRGBFillColor(context, 0.027, 0.027, 0.027, 0.4);
	
	
	CGContextFillPath(context);
	
	
}




// Function to set the status of the game to Game Over
-(void)gameIsOver{
	
	self.gameOver = YES;
	
	
	
}

// Function to check if the snake did hit the walls

-(BOOL)didSnakeHitWall{
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];	
	
	if (delegate.fieldMode == kFullWall) {
        
	    if (IS_IPHONE_5) {
            if (snake.headDirection == kEastDirection && snake.head_x > 305) {
                return YES;
            }
            else
                if(snake.headDirection == kWestDirection && snake.head_x < 15){
                return YES;
            }
            else if(snake.headDirection == kNorthDirection && snake.head_y < 15){
                return YES;
            }
            else if(snake.headDirection == kSouthDirection && snake.head_y > 375){
                return YES;
            }
            else {
                return NO;
            }
        }
        else{
         
		if (snake.headDirection == kEastDirection && snake.head_x > 305) {
			return YES;
		}
		else if(snake.headDirection == kWestDirection && snake.head_x < 15){
			return YES;
		}
		else if(snake.headDirection == kNorthDirection && snake.head_y < 15){
			return YES;
		}
        else if(snake.headDirection == kSouthDirection && snake.head_y > 285){
			return YES;
		}
        
		else {
			return NO;
		}
    }
	}
	
	
	if (delegate.fieldMode == kHoleWall) {
		if(IS_IPHONE_5) {
            if (snake.head_x > 305 && (snake.head_y < 174 || snake.head_y > 216 )) {
                return YES;
            }
            else if (snake.head_x < 15 && (snake.head_y < 174 || snake.head_y > 216 ) ){
                return YES;
            }
            else if( snake.head_y < 15 && (snake.head_x <140 || snake.head_x > 182)){
                return YES;
            }
            else if(snake.head_y > 375 && (snake.head_x <140 || snake.head_x > 182)){
                return YES;
            }
            else {
                return NO;
            }
            
        }
        else{
		if (snake.head_x > 305 && (snake.head_y < 129 || snake.head_y > 171 )) {
			return YES;
		}
		else if (snake.head_x < 15 && (snake.head_y < 129 || snake.head_y > 171 ) ){
			return YES;
		}
		else if( snake.head_y < 15 && (snake.head_x <139 || snake.head_x > 181)){
			return YES;
		}
		else if(snake.head_y > 285 && (snake.head_x <139 || snake.head_x > 181)){
			return YES;
		}
		else {
			return NO;
            }
        }
	}
	
	
	if (delegate.fieldMode == kSquareWall) {
		
        if(IS_IPHONE_5) {
            if (snake.head_x > 305 && (snake.head_y < 174 || snake.head_y > 216 )) {
                return YES;
            }
            else if (snake.head_x < 15 && (snake.head_y < 174 || snake.head_y > 216 ) ){
                return YES;
            }
            else if( snake.head_y < 15 && (snake.head_x <139 || snake.head_x > 181)){
                return YES;
            }
            else if(snake.head_y > 375 && (snake.head_x <139 || snake.head_x > 181)){
                return YES;
            }
            else if(snake.head_x > 130 && snake.head_x < 140 && (snake.head_y < 174 || snake.head_y > 216)){
                return YES;
            }
            else if(snake.head_x > 180 && snake.head_x < 190 && (snake.head_y < 174 || snake.head_y > 216)){
                return YES;
            }
            else {
                return NO;
            }
            
        }
        else{
		if (snake.head_x > 305 && (snake.head_y < 129 || snake.head_y > 171 )) {
			return YES;
		}
		else if (snake.head_x < 15 && (snake.head_y < 129 || snake.head_y > 171 ) ){
			return YES;
		}
		else if( snake.head_y < 15 && (snake.head_x <139 || snake.head_x > 181)){
			return YES;
		}
		else if(snake.head_y > 285 && (snake.head_x <139 || snake.head_x > 181)){
			return YES;
		}
		else if(snake.head_x > 130 && snake.head_x < 140 && (snake.head_y < 129 || snake.head_y > 171)){
			return YES;
		}
		else if(snake.head_x > 180 && snake.head_x < 190 && (snake.head_y < 129 || snake.head_y > 171)){
			return YES;
		}
		else {
			return NO;
		}
        
        }
    }
}



// Function to move the snake Right whent a button is pressed
-(void)moveSnakeRight{
    
    
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	CGPoint head_dead = CGPointMake(snake.head_x , snake.head_y);
	
	
	if (delegate.isWallOn && [self didSnakeHitWall]) {
		self.gameOver=YES;
		
	}
	else{
	
	if ([self onSnake:head_dead check_food:NO] ) {  // If snake hit itself
		self.gameOver = YES;
		
		
	}
	else{
	
		if (snake.headDirection != kEastDirection && 
			snake.headDirection != kWestDirection)
		{
            
			if ([self wasFoodEaten])  // if food was eaten
			{
            
				[snake moveSnakeEast];
				
				
				if (delegate.isSoundOn) {
					[delegate play];
				}
				if (delegate.isVibrateOn) {
					AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
				}
				
				
			
				[food generateRandomFood];
				
				CGPoint food_value =  CGPointMake(food.food_x + 2.5, food.food_y + 2.5);
				while ([self onSnake:food_value check_food:YES]) {
							
					[food generateRandomFood];
					food_value =  CGPointMake(food.food_x + 2.5, food.food_y + 2.5);
				}
				
				[self setNeedsDisplay];
				[foodLayer setNeedsDisplay];
				
				foodEaten = 2;
                
               
				
			}
			else if([self wasBonusFoodEaten]) // if bonus food was eaten
			{
				[snake moveSnakeEast];
				
				
				if (delegate.isSoundOn) {
					[delegate bonusPlay];
					
				}
				if (delegate.isVibrateOn) {
					AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
				}
				
				
				food.bonus_food_x = -10;
				food.bonus_food_y = -10;
			
				[self setNeedsDisplay];
				[bonusFoodLayer setNeedsDisplay];
				
				foodEaten = 2;
				
			}
			else if (foodEaten == 2 || foodEaten == 3 ) {
				
				[snake moveSnakeEast];
				
				foodEaten ++ ;
				
				
				[self setNeedsDisplay];
				
			}
			else {
				[snake moveSnakeEast];
				[snake updateTail];
				
				[self setNeedsDisplay];
			}

			 
		}
	}
	}
	
	
}

// Function to move the snake Up when the up button is pressed

-(void)moveSnakeUp{
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	CGPoint head_dead = CGPointMake(snake.head_x, snake.head_y);
	if (delegate.isWallOn && [self didSnakeHitWall]) {
		self.gameOver=YES;
		
	}
	else{
	if ([self onSnake:head_dead check_food:NO]) {
		self.gameOver = YES;
		
	}
	else
	{
		
		if (snake.headDirection != kNorthDirection && 
			snake.headDirection != kSouthDirection)
		{
			if ([self wasFoodEaten]) {
				
				[snake moveSnakeNorth];
				
				
				
				if (delegate.isSoundOn) {
					[delegate play];
				}
				if (delegate.isVibrateOn) {
					AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
				}
				
				
				
				[food generateRandomFood];
				CGPoint food_value =  CGPointMake(food.food_x + 2.5, food.food_y + 2.5);
				while ([self onSnake:food_value check_food:YES]) {
					
					[food generateRandomFood];
					food_value =  CGPointMake(food.food_x + 2.5, food.food_y + 2.5);
				}
				[self setNeedsDisplay];
				[foodLayer setNeedsDisplay];
				foodEaten = 2;
				
			}
			else if([self wasBonusFoodEaten])
			{
				[snake moveSnakeNorth];
				
				if (delegate.isSoundOn) {
					[delegate bonusPlay];
				}
				if (delegate.isVibrateOn) {
					AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
				}
				
				
				
				food.bonus_food_x = -10;
				food.bonus_food_y = -10;
				
				[self setNeedsDisplay];
				[bonusFoodLayer setNeedsDisplay];
				
				foodEaten = 2;
							}
			else if (foodEaten == 2 || foodEaten == 3) {
				
				[snake moveSnakeNorth];
				
				foodEaten ++ ;
				
				
				
				[self setNeedsDisplay];
				
			}
			else {
				
				[snake moveSnakeNorth];
				[snake updateTail];
				
				[self setNeedsDisplay];
			}
			
		}
	}
	}
		
}


// Function to move the snake left when the left button is pressed

-(void)moveSnakeLeft{
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	CGPoint head_dead = CGPointMake(snake.head_x , snake.head_y);
	
	if (delegate.isWallOn && [self didSnakeHitWall]) {
		self.gameOver=YES;
		
	}
	else{
	if ([self onSnake:head_dead check_food:NO]) {
		self.gameOver = YES;
		
	}
	else {
		if(snake.headDirection != kWestDirection && 
		   snake.headDirection != kEastDirection)
		{
			if ([self wasFoodEaten]) {
				
				[snake moveSnakeWest];
				
				
				if (delegate.isSoundOn) {
					[delegate play];
				}
				if (delegate.isVibrateOn) {
					AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
				}
				
				
				

				[food generateRandomFood];
				CGPoint food_value =  CGPointMake(food.food_x + 2.5, food.food_y + 2.5);
				while ([self onSnake:food_value check_food:YES]) {
					
					[food generateRandomFood];
					food_value =  CGPointMake(food.food_x + 2.5, food.food_y + 2.5);
				}
				[self setNeedsDisplay];
				[foodLayer setNeedsDisplay];
				
				foodEaten = 2;
				
			}
			else if([self wasBonusFoodEaten])
			{
				[snake moveSnakeWest];
				
				
				if (delegate.isSoundOn) {
					[delegate bonusPlay];
				}
				if (delegate.isVibrateOn) {
					AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
				}
				
				
				food.bonus_food_x = -10;
				food.bonus_food_y = -10;
				[self setNeedsDisplay];
				[bonusFoodLayer setNeedsDisplay];
				
				foodEaten = 2;
				
			}
			else if (foodEaten == 2 || foodEaten == 3) {
				
				[snake moveSnakeWest];
				
				foodEaten ++ ;
				
				
				
				[self setNeedsDisplay];
				
			}
			else {
				
				[snake moveSnakeWest];
				[snake updateTail];
				
				[self setNeedsDisplay];
				
			}			 
		}
		
	}
		
	}
		

}

// Function to move the snake down when the down button is pressed

-(void)moveSnakeDown{
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	CGPoint head_dead = CGPointMake(snake.head_x , snake.head_y);
	
	if (delegate.isWallOn && [self didSnakeHitWall]) {
		self.gameOver=YES;
		
	}
	else{
	if ([self onSnake:head_dead check_food:NO]) {
		self.gameOver = YES;
		
	}
	
	else {
		if (snake.headDirection != kSouthDirection && 
			snake.headDirection != kNorthDirection) {
			if ([self wasFoodEaten]) {
				[snake moveSnakeSouth];
				
				
				if (delegate.isSoundOn) {
					[delegate play];
				}
				if (delegate.isVibrateOn) {
					AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
				}
				
				[food generateRandomFood];
				CGPoint food_value =  CGPointMake(food.food_x + 2.5, food.food_y + 2.5);
				while ([self onSnake:food_value check_food:YES]) {
					
					[food generateRandomFood];
					food_value =  CGPointMake(food.food_x + 2.5, food.food_y + 2.5);
				}
				[self setNeedsDisplay];
				[foodLayer setNeedsDisplay];
				
				foodEaten = 2;
				
			}
			else if([self wasBonusFoodEaten])
			{
				[snake moveSnakeSouth];
				
				if (delegate.isSoundOn) {
					[delegate bonusPlay];
				}
				if (delegate.isVibrateOn) {
					AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
				}
				
				food.bonus_food_x = -10;
				food.bonus_food_y = -10;
				
				[self setNeedsDisplay];
				[bonusFoodLayer setNeedsDisplay];
				
				foodEaten = 2;
				
			}
			else if (foodEaten == 2 || foodEaten == 3) {
				
				[snake moveSnakeSouth];
				
				foodEaten ++ ;
				
				
				[self setNeedsDisplay];
				
			}
			else {
				[snake moveSnakeSouth];
				[snake updateTail];
				
				[self setNeedsDisplay];
			}
			
			
		}
	}
		
	}
	
		

}


// Function to move the snake right at every regular interval
// The difference in this function is that there are no bends as the snake moves
// with time.

-(void)moveTimerSnakeRight{
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	CGPoint head_dead = CGPointMake(snake.head_x , snake.head_y);
	
if (delegate.isWallOn && [self didSnakeHitWall]) {
	self.gameOver=YES;
	
}
else{
		
	if ([self onSnake:head_dead check_food:NO]) {
		self.gameOver = YES;
		
	}
	
	else {
		
		if (snake.headDirection != kWestDirection)
		{
			if ([self wasFoodEaten] ) {
				
				
				[snake moveSnakeTimerEast];
				
				if (delegate.isSoundOn) {
					[delegate play];
				}
				if (delegate.isVibrateOn) {
					AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
				}
				
				
				[food generateRandomFood];
				CGPoint food_value =  CGPointMake(food.food_x + 2.5, food.food_y + 2.5);
				while ([self onSnake:food_value check_food:YES]) {
					
					[food generateRandomFood];
					food_value =  CGPointMake(food.food_x + 2.5, food.food_y + 2.5);
				}
					foodEaten = 2 ;
				
				[self setNeedsDisplay];
				[foodLayer setNeedsDisplay];
				
				
				
			}
			else if([self wasBonusFoodEaten])
			{
				[snake moveSnakeEast];
				
				
				
				if (delegate.isSoundOn) {
					[delegate bonusPlay];
				}
				if (delegate.isVibrateOn) {
					AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
				}
				
				foodEaten = 2;
				
				
				food.bonus_food_x = -10;
				food.bonus_food_y = -10;
				
				[self setNeedsDisplay];

				[bonusFoodLayer setNeedsDisplay];
				
							}
			else if (foodEaten == 2 || foodEaten == 3) {
				
				[snake moveSnakeTimerEast];
				
				foodEaten ++ ;
				
				
				
				[self setNeedsDisplay];
				
			}
			else {
				
				[snake moveSnakeTimerEast];
				[snake updateTail];
				
				
				[self setNeedsDisplay];
				
			}
			
		}
	}
}

}

// Function to move the snake up at every regular interval
// The difference in this function is that there are no bends as the snake moves
// with time.

-(void)moveTimerSnakeUp{
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	CGPoint head_dead = CGPointMake(snake.head_x, snake.head_y);
	
	if (delegate.isWallOn && [self didSnakeHitWall]) {
		self.gameOver=YES;
		
	}
	else{
	if ([self onSnake:head_dead check_food:NO]) {
		self.gameOver = YES;
		
	}
	
	else {
		
		
		if (snake.headDirection != kSouthDirection)
		{
			
			if ([self wasFoodEaten]) {
				
				[snake moveSnakeTimerNorth];
				
				
				if (delegate.isSoundOn) {
					[delegate play];
				}
				if (delegate.isVibrateOn) {
					AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
				}
				
				
				
				[food generateRandomFood];
				CGPoint food_value =  CGPointMake(food.food_x + 2.5, food.food_y + 2.5);
				while ([self onSnake:food_value check_food:YES]) {
					
					[food generateRandomFood];
					food_value =  CGPointMake(food.food_x + 2.5, food.food_y + 2.5);
				}
				[self setNeedsDisplay];
				[foodLayer setNeedsDisplay];
				
				foodEaten = 2;
				
			}
			else if([self wasBonusFoodEaten])
			{
				[snake moveSnakeNorth];
				
				if (delegate.isSoundOn) {
					[delegate bonusPlay];
				}
				if (delegate.isVibrateOn) {
					AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
				}
				
				
				food.bonus_food_x = -10;
				food.bonus_food_y = -10;
				
				[self setNeedsDisplay];
				[bonusFoodLayer setNeedsDisplay];
				
				foodEaten = 2;
				
			}
			else if (foodEaten == 2 || foodEaten == 3) {
				
				[snake moveSnakeTimerNorth];
				
				foodEaten ++ ;
				
				
				
				[self setNeedsDisplay];
				
			}
			else {
				
				
				[snake moveSnakeTimerNorth];
				[snake updateTail];
				
				[self setNeedsDisplay];
			}
			
		}
	}
	}
}

// Function to move the snake left at every regular interval
// The difference in this function is that there are no bends as the snake moves
// with time.


-(void)moveTimerSnakeLeft{
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	CGPoint head_dead = CGPointMake(snake.head_x , snake.head_y);
	
	if (delegate.isWallOn && [self didSnakeHitWall]) {
		self.gameOver=YES;
		
	}
	else{
	if ([self onSnake:head_dead check_food:NO]) {
		self.gameOver = YES;
		
	}
	
	else {
		
		
		if(snake.headDirection != kEastDirection)
		{
			if ([self wasFoodEaten]) {
				[snake moveSnakeTimerWest];
				
				if (delegate.isSoundOn) {
					[delegate play];
				}
				if (delegate.isVibrateOn) {
					AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
				}
				
				
				
				[food generateRandomFood];
				CGPoint food_value =  CGPointMake(food.food_x + 2.5, food.food_y + 2.5);
				while ([self onSnake:food_value check_food:YES]) {
					
					[food generateRandomFood];
					food_value =  CGPointMake(food.food_x + 2.5, food.food_y + 2.5);
				}
				[self setNeedsDisplay];
				[foodLayer setNeedsDisplay];
				
				foodEaten = 2;
				
			}
			else if([self wasBonusFoodEaten])
			{
				[snake moveSnakeWest];
				
				if (delegate.isSoundOn) {
					[delegate bonusPlay];
				}
				if (delegate.isVibrateOn) {
					AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
				}
				
				
				
				food.bonus_food_x = -10;
				food.bonus_food_y = -10;
				
				[self setNeedsDisplay];

				[bonusFoodLayer setNeedsDisplay];
				
				foodEaten = 2;
							}
			else if (foodEaten == 2 || foodEaten == 3) {
				
				[snake moveSnakeTimerWest];
				
				foodEaten ++ ;
				
				[self setNeedsDisplay];
				
			}
			else {
				[snake moveSnakeTimerWest];
				[snake updateTail];
				
				[self setNeedsDisplay];
			}
			
		}
	}
	}
}

// Function to move the snake down at every regular interval
// The difference in this function is that there are no bends as the snake moves
// with time.

-(void)moveTimerSnakeDown{
    
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	CGPoint head_dead = CGPointMake(snake.head_x, snake.head_y);
	
	if (delegate.isWallOn && [self didSnakeHitWall]) {
		self.gameOver=YES;
		
	}
	else{
	if ([self onSnake:head_dead check_food:NO]) {
		self.gameOver = YES;
		
	}
	
	
	else {
		
		
		if (snake.headDirection != kNorthDirection) {
			if ([self wasFoodEaten]) {
				
				[snake moveSnakeTimerSouth];
				
				if (delegate.isSoundOn) {
					[delegate play];
				}
				if (delegate.isVibrateOn) {
					AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
				}
				
				
				
				
				[food generateRandomFood];
				CGPoint food_value =  CGPointMake(food.food_x + 2.5, food.food_y + 2.5);
				while ([self onSnake:food_value check_food:YES]) {
					
					[food generateRandomFood];
					food_value =  CGPointMake(food.food_x + 2.5, food.food_y + 2.5);
				}
				[self setNeedsDisplay];
				[foodLayer setNeedsDisplay];
				
				foodEaten = 2;
				
			}
			else if([self wasBonusFoodEaten])
			{
				[snake moveSnakeSouth];
				
				if (delegate.isSoundOn) {
					[delegate bonusPlay];
				}
				if (delegate.isVibrateOn) {
					AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
				}
				
				
				
				food.bonus_food_x = -10;
				food.bonus_food_y = -10;
				
				[self setNeedsDisplay];
				[bonusFoodLayer setNeedsDisplay];
				
				foodEaten = 2;
				
			}
			else if (foodEaten == 2 || foodEaten == 3) {
				
				[snake moveSnakeTimerSouth];
				
				foodEaten ++ ;
				
				
				
				[self setNeedsDisplay];
				
			}
			else {
				[snake moveSnakeTimerSouth];
				[snake updateTail];
				
				[self setNeedsDisplay];
				
			}
		}
	}
	}

}


//Function to check if the food was eaten


-(BOOL)wasFoodEaten{
    
	CGFloat foodCenter_x = food.food_x + 2.5;
	CGFloat foodCenter_y = food.food_y + 2.5;
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	if (snake.head_x == foodCenter_x && snake.head_y == foodCenter_y) {
		
		if (delegate.isWallOn == NO){
			
			foodValue = 100 + (delegate.foodNumber * 10);
			
		}
		else if(delegate.isWallOn == YES && delegate.fieldMode == kFullWall){
		
			foodValue = 100 + (delegate.foodNumber * 15);
			
			
		}
		else if(delegate.isWallOn == YES && delegate.fieldMode == kHoleWall){
			
			foodValue = 100 + (delegate.foodNumber * 20);
			
			
		}
		else if(delegate.isWallOn == YES && delegate.fieldMode == kSquareWall){
			
			foodValue = 100 + (delegate.foodNumber * 25);
			
			
		}
		
		self.score += foodValue;
		delegate.foodNumber ++;

        
		if (delegate.GCTest) {
          
		GKAchievement *achievement = [delegate getAchievementForIdentifier:@"Super_Snake"];
		
		
		if (achievement.percentComplete < 100.0 && delegate.foodNumber == 50 && delegate.GCConnected) {
			
            
			[delegate reportAchievementIdentifier:@"Super_Snake" percentComplete:100];
			
			[[GKAchievementHandler defaultHandler] notifyAchievementTitle:@"Super Snake" andMessage:@"Congratulations!"];	
		}
		
		
		GKAchievement *achievement_2 = [delegate getAchievementForIdentifier:@"Super_Sharp_Snake"];
		
		if (achievement_2.percentComplete < 100.0 && delegate.foodNumber == 100 && delegate.GCConnected) {
			
			[delegate reportAchievementIdentifier:@"Super_Sharp_Snake" percentComplete:100];
			[[GKAchievementHandler defaultHandler] notifyAchievementTitle:@"Super Duper Snake" andMessage:@"Congratulations!"];	
		}
		}
		
		foodEaten = 1;
		return (YES);
		
		
		
	}
	else {	
		return (NO);
	}
}

// Function to check if bonus food was eaten
-(BOOL)wasBonusFoodEaten{
	CGFloat foodCenter_x = food.bonus_food_x + 2.5;
	CGFloat foodCenter_y = food.bonus_food_y + 2.5;
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	if (snake.head_x == foodCenter_x && snake.head_y == foodCenter_y) {
		
		if (delegate.isWallOn == NO){
			
			foodValue = 100 + (delegate.foodNumber  * 10);
			
		}
		else if(delegate.isWallOn == YES){
			
			foodValue = 100 + (delegate.foodNumber * 15);
			
			
		}
		delegate.bonusFoodNumber ++;
		
		self.score += 2*foodValue;
		
		if (delegate.GCTest) {
        
		GKAchievement *achievement = [delegate getAchievementForIdentifier:@"Bonus_Champ"];
		
		
		if (achievement.percentComplete < 100.0 && delegate.bonusFoodNumber == 10 && delegate.GCConnected) {
			
			[delegate reportAchievementIdentifier:@"Bonus_Champ" percentComplete:100];
			[[GKAchievementHandler defaultHandler] notifyAchievementTitle:@"Bonus Champion" andMessage:@"Congratulations!"];	
		}
		
		}
		
		return (YES);
		
		
	}
	else {
		return (NO);
	}
}	



// Function used in other functions to see if a point is in between 2 points
-(BOOL)inbetween_A_B:(CGPoint)a pointtwo:(CGPoint)b pointinbetween:(CGPoint)c{
	
	if (c.x>=a.x && c.x <= b.x && c.y >= a.y && c.y <= b.y) {
		return (YES);
		}
	else {
		return (NO);
	}

	
}


// Function to check if anything is on the snake.
// Used to check if snake hit itself or if the food is on the snake.

-(BOOL)onSnake:(CGPoint)aPoint check_food:(BOOL)food_yes{
	
	CGPoint tail = CGPointMake(snake.tail_x, snake.tail_y);
	CGPoint head = CGPointMake(snake.head_x - 10 , snake.head_y);
	
	

	
	
	if ([snake.bends count] >= 1)
	{
	
		NSData *bend_value = [snake.bends objectAtIndex:0];
		CGPoint bend_point = *(CGPoint*)[bend_value bytes];
	
		if(snake.tailDirection == kEastDirection || snake.tailDirection == kSouthDirection)
		{
			if([self inbetween_A_B:tail pointtwo:bend_point pointinbetween:aPoint])
				return (YES);
			
		}
		else
		{
			if([self inbetween_A_B:bend_point pointtwo:tail pointinbetween:aPoint])
				return (YES);
		}

		if ([snake.bends count] > 1) 
		{
	
			for (int i=0; i<[snake.bends count] - 1; i++) 
			{
				NSData *bend_value = [snake.bends objectAtIndex:i];
				CGPoint bend_point = *(CGPoint*)[bend_value bytes];
		
				NSData *bend_value_1 = [snake.bends objectAtIndex:(i+1)];
				CGPoint bend_point_1 = *(CGPoint*)[bend_value_1 bytes];
		
				NSData *bend_dir = [snake.bend_direction objectAtIndex:i];
				Direction bend_dir_value = *(Direction*)[bend_dir bytes];
		
				if(bend_dir_value == kEastDirection || bend_dir_value == kSouthDirection 
				   || bend_dir_value == kEastIn || bend_dir_value == kSouthIn)
				{
					if([self inbetween_A_B:bend_point pointtwo:bend_point_1 pointinbetween:aPoint])
						return (YES);	
				}
				else
				{
					if([self inbetween_A_B:bend_point_1 pointtwo:bend_point pointinbetween:aPoint])
						return (YES);
				}
			}
		}
		
		if (food_yes) {
			
			
			NSData *bend_value_head = [snake.bends lastObject];
			CGPoint bend_point_head = *(CGPoint*)[bend_value_head bytes];
		
			NSData *bend_dir_head = [snake.bend_direction lastObject];
			Direction bend_dir_value_head = *(Direction*)[bend_dir_head bytes];
		
			if(bend_dir_value_head == kEastDirection || bend_dir_value_head == kSouthDirection || bend_dir_value_head == kEastIn || bend_dir_value_head == kSouthIn)
			{
				if([self inbetween_A_B:bend_point_head pointtwo:head pointinbetween:aPoint])
					return (YES);	
			}
			else
			{
				if([self inbetween_A_B:head pointtwo:bend_point_head pointinbetween:aPoint])
					return (YES);
			}
		}
		
		
		
	
	}
	else if(food_yes)
	{
		if (snake.tailDirection == kEastDirection || snake.tailDirection == kSouthDirection) 
		{
			if ([self inbetween_A_B:tail pointtwo:head pointinbetween:aPoint]) 
			{
				return(YES);
			}
		}
		else {
			if ([self inbetween_A_B:head pointtwo:tail pointinbetween:aPoint]) 
			{
				return(YES);
			}
		}

	}
				
	return(NO);

}


// Function to generate Bonus food when bonus food needs to be displayed.
-(void)generateBonusFood{
	
	[food generateBonusFood];
	
	if (food.bonus_food_x == food.food_x && food.bonus_food_y == food.food_y) {
		[food generateBonusFood];
	}
	
	CGPoint food_value =  CGPointMake(food.bonus_food_x + 2.5, food.bonus_food_y + 2.5);
	while ([self onSnake:food_value check_food:YES]) {
		
		
		
		[food generateBonusFood];

		
		food_value =  CGPointMake(food.bonus_food_x + 2.5, food.bonus_food_y + 2.5);
	}	
	
	
	
}

// Function to invalidate the bonus food once the time runs out

-(void)invalidateBonusFood{
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	while(food.bonus_food_x != -10 || food.bonus_food_y != -10){
		
		delegate.bonusFoodNumber = 0;
		
		if (delegate.gameMode == kExtremeMode) {
			delegate.missedInExtreme = 1;
		}
		
		food.bonus_food_x = -10;
		food.bonus_food_y = -10;
	
	}
}
	
			

- (void)dealloc {
	
    [super dealloc];
}


@end
