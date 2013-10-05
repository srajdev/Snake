//
//  Snake_3ViewController.h
//  
//
//  Created by Swapan Rajdev on 7/31/10.
//  Copyright Zing! Apps 2010. All rights reserved.
//
//  Update V2: Added functionality to play in extreme mode. Which is a time challenge.
//			   Thus there is extra functionality to use a timer for each different level
//
//  Description: This view controller is used to show the whole view of the game.
//				 This view controller contains:
//				 GameView: the actual view where the snake moves
//               The different buttons that the user has to controll the snake. 

#import <UIKit/UIKit.h>
#import "GameView.h"
#import "snakeType.h"
#import "foodType.h"
#import "constants.h"
#import "main_menu.h"
#import "GameOver.h"


#import <QuartzCore/CADisplayLink.h>

@interface Snake_3ViewController : UIViewController <UIAlertViewDelegate> {
	
	IBOutlet GameView *game;
	IBOutlet UILabel *score_label;
	
	IBOutlet UILabel *time_label;

	
	CADisplayLink *displayLink;
	
	main_menu *mainmenu;
	
	GameView *currentView;
	
	GameOver *gameover;
	
	
	int bonusCounter;
	
	int time;
	
	
	
	NSTimer	*fullWallTimer;
	
	NSTimer	*holeTimer;
	
	NSTimer	*squareTimer;
	
	NSTimer	*gameOverTimer;
	
	NSTimer	*countTimer;
	
	BOOL comeFromPause;
	
	
	NSTimer	*bonusTimer;
	
	
	
	IBOutlet UIImageView *background;
    IBOutlet UIImageView *snakeLogo;
    IBOutlet UIButton *leftButton;
	IBOutlet UIButton *rightButton;
    IBOutlet UIButton *topButton;
    IBOutlet UIButton *bottomButton;
	IBOutlet UIButton *pauseButton;

}

@property 	int bonusCounter;

@property (nonatomic,retain) CADisplayLink *displayLink;
@property (nonatomic,retain) main_menu *mainmenu;
@property (nonatomic,retain) GameOver *gameover;
@property (nonatomic,retain) 	GameView *currentView;

@property int time;
@property (nonatomic,retain) NSTimer	*fullWallTimer;

@property (nonatomic,retain) NSTimer	*holeTimer;

@property (nonatomic,retain) NSTimer	*squareTimer;

@property (nonatomic,retain) NSTimer	*gameOverTimer;

@property (nonatomic,retain) NSTimer	*countTimer;

@property (nonatomic,retain) NSTimer	*bonusTimer;

@property BOOL comeFromPause;

@property (nonatomic,retain) IBOutlet UIButton *leftButton;
@property (nonatomic,retain) IBOutlet UIButton *rightButton;
@property (nonatomic,retain) IBOutlet UIButton *topButton;
@property (nonatomic,retain) IBOutlet UIButton *bottomButton;
@property (nonatomic,retain) IBOutlet UIButton *pauseButton;

-(IBAction)rightPressed;
-(IBAction)leftPressed;
-(IBAction)upPressed;
-(IBAction)downPressed;

-(void)generateBonusFood:(NSTimer *)theTimer;

-(void)moveSnake:(CADisplayLink *)sender;

-(IBAction)pauseGame;

-(void)gameOver:(CADisplayLink *)displayLinkSent;

-(void)startLoop:(NSTimer *)theTimer;

-(void)loadGameOver:(NSTimer *)theTimer;

-(void) loadFullGame :(NSTimer *)theTimer;

-(void) loadHoleGame :(NSTimer *)theTimer;

-(void) loadSquareGame :(NSTimer *)theTimer;

-(void) extremeOver :(NSTimer *)theTimer;

-(void) countTime :(NSTimer *)theTimer;

-(void) startGame ;

-(void) startTime;

-(void) pauseGameNow;

-(void) showAlert1 :(NSTimer *)theTimer;

-(void) showAlert2 :(NSTimer *)theTimer;

-(void) showAlert3 :(NSTimer *)theTimer;

//-(void)saveGame;

//-(void)drawSnake:(CGContextRef)context;

//-(void)drawBackgroundSnake:(CGContextRef)context;

@end

