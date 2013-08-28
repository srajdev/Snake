//
//  Snake_3ViewController.m
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


#import "Snake_3ViewController.h"
#import "SnakeClassicAppDelegate.h"
#import "FlurryAnalytics.h"
#import "HighScores.h"
#import "HighScoreRecord.h"


@implementation Snake_3ViewController

@synthesize displayLink;
@synthesize mainmenu;
@synthesize gameover;
@synthesize currentView;
@synthesize bonusCounter;
@synthesize time;


@synthesize fullWallTimer;

@synthesize holeTimer;

@synthesize squareTimer;

@synthesize gameOverTimer;
@synthesize countTimer;
@synthesize bonusTimer;
@synthesize comeFromPause;
// Action that takes place when the right button is pressed. It moves the snake right.
-(IBAction)rightPressed{

	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];

	delegate.snakeHeadX = game.snake.head_x;
	delegate.snakeHeadY = game.snake.head_y;
	
	delegate.snakeTailX = game.snake.tail_x;
	delegate.snakeTailY	= game.snake.tail_y;
	
	delegate.snakeHeadDirection = game.snake.headDirection;
	delegate.snakeTailDirection	= game.snake.tailDirection;
	
	delegate.snakeBends = game.snake.bends;
	delegate.snakeBendDirection = game.snake.bend_direction;
	
	delegate.snakeFoodX = game.food.food_x;
	delegate.snakeFoodY = game.food.food_y;	
	
	
	delegate.delegateScore = game.score;
	
	//delegate.displayLink = self.displayLink;

	
	[game moveSnakeRight];
	score_label.text = [NSString stringWithFormat:@"%d",game.score];
}

// Action that takes place when the up button is pressed. It moves the snake up.

-(IBAction)upPressed{
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	delegate.snakeHeadX = game.snake.head_x;
	delegate.snakeHeadY = game.snake.head_y;
	
	delegate.snakeTailX = game.snake.tail_x;
	delegate.snakeTailY	= game.snake.tail_y;
	
	delegate.snakeHeadDirection = game.snake.headDirection;
	delegate.snakeTailDirection	= game.snake.tailDirection;
	
	delegate.snakeBends = game.snake.bends;
	delegate.snakeBendDirection = game.snake.bend_direction;
	
	delegate.snakeFoodX = game.food.food_x;
	delegate.snakeFoodY = game.food.food_y;
	
	delegate.delegateScore = game.score;
	
	//delegate.displayLink = self.displayLink;
	[game moveSnakeUp];
	score_label.text = [NSString stringWithFormat:@"%d",game.score];
}

// Action that takes place when the left button is pressed. It moves the snake left.

-(IBAction)leftPressed{
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	delegate.snakeHeadX = game.snake.head_x;
	delegate.snakeHeadY = game.snake.head_y;
	
	delegate.snakeTailX = game.snake.tail_x;
	delegate.snakeTailY	= game.snake.tail_y;
	
	delegate.snakeHeadDirection = game.snake.headDirection;
	delegate.snakeTailDirection	= game.snake.tailDirection;
	
	delegate.snakeBends = game.snake.bends;
	delegate.snakeBendDirection = game.snake.bend_direction;
	
	delegate.snakeFoodX = game.food.food_x;
	delegate.snakeFoodY = game.food.food_y;
	
	delegate.delegateScore = game.score;
	
	//delegate.displayLink = self.displayLink;
	[game moveSnakeLeft];
	score_label.text = [NSString stringWithFormat:@"%d",game.score];
}


// Action that takes place when the down button is pressed. It moves the snake down.
-(IBAction)downPressed{
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	delegate.snakeHeadX = game.snake.head_x;
	delegate.snakeHeadY = game.snake.head_y;
	
	delegate.snakeTailX = game.snake.tail_x;
	delegate.snakeTailY	= game.snake.tail_y;
	
	delegate.snakeHeadDirection = game.snake.headDirection;
	delegate.snakeTailDirection	= game.snake.tailDirection;
	
	delegate.snakeBends = game.snake.bends;
	delegate.snakeBendDirection = game.snake.bend_direction;
	
	
	delegate.snakeFoodX = game.food.food_x;
	delegate.snakeFoodY = game.food.food_y;
	
	delegate.delegateScore = game.score;
	
	//delegate.displayLink = self.displayLink;
	[game moveSnakeDown];
	score_label.text = [NSString stringWithFormat:@"%d",game.score];
}

// Action that takes place when the pause button is pressed. This function pauses
// the game and takes the user to the main menu screen

-(IBAction)pauseGame{
	
	

	[self pauseGameNow];
	
}

-(void) pauseGameNow{
	
	[FlurryAnalytics logEvent:@"Pause"];
	

	
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	if (delegate.gameStatus != kGameOver && delegate.time != 0) {
		
		[countTimer invalidate];
	
		
		comeFromPause = YES;
//	displayLink.paused = YES;
	
	delegate.gameStatus = kGamePause;
	
 //	mainmenu = [[main_menu alloc] initWithNibName:@"main_menu" bundle:nil];
	
	delegate.snakeHeadX = game.snake.head_x;
	delegate.snakeHeadY = game.snake.head_y;
	
	delegate.snakeTailX = game.snake.tail_x;
	delegate.snakeTailY	= game.snake.tail_y;
	
	delegate.snakeHeadDirection = game.snake.headDirection;
	delegate.snakeTailDirection	= game.snake.tailDirection;
	
	delegate.snakeBends = game.snake.bends;
	delegate.snakeBendDirection = game.snake.bend_direction;
	
	delegate.snakeFoodX = game.food.food_x;
	delegate.snakeFoodY = game.food.food_y;
	
	delegate.delegateScore = game.score;
	
	delegate.displayLink = self.displayLink;
	
	delegate.activeGame = self;
		
	[bonusTimer invalidate];
		
		[displayLink invalidate];
		
		if (delegate.mainmenu.adView != NULL) {
			[delegate.mainmenu.adView doNotIgnoreNewAdRequests];
			[delegate.mainmenu.adView requestFreshAd];
		}
		
		
	
	[delegate switchView:self.view toview:delegate.mainmenu.view delay:NO remove:NO display:displayLink curlup:NO curldown:YES];
		
		
	
	}
	
}

-(void)awakeFromNib{

	
}
	


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Function to generate Bonus food at regular time intervals.

-(void)generateBonusFood:(NSTimer *)theTimer1{
	
	
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];

	if (delegate.gameStatus != kGamePause) {
		
	
	
	
	[game generateBonusFood];
	[game.bonusFoodLayer setNeedsDisplay];
		
	}
	
	
	[NSTimer scheduledTimerWithTimeInterval: 5.0
									 target:self
								   selector:@selector(invalidateBonusFood:)
								   userInfo:nil
									repeats:NO];
	
	[pool release];
}

// Function to invalidate bonus food once time runs out.

-(void)invalidateBonusFood:(NSTimer *)thetTimer2{

	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
		
	[game invalidateBonusFood];
	[game.bonusFoodLayer setNeedsDisplay];
	
	[pool release];
}


// Function that is called when the game is over.

-(void)gameOver:(CADisplayLink *)displayLinkSent{
	
	[FlurryAnalytics logEvent:@"Game Over"];
	
	[displayLinkSent invalidate];
	
	[fullWallTimer invalidate];
	
	[holeTimer invalidate];
	
	[squareTimer invalidate];
	
	//[gameOverTimer invalidate];
	
	[countTimer invalidate];
	
	
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	delegate.gameStatus = kGameOver;
	
	[delegate.displayLink invalidate];
	AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
	
	[NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(loadGameOver:) userInfo:nil repeats:NO];
	
	
	
}

// Function that loads the game over screen. This takes place for a short period of time 
// giving the user time to reflect on how the game got over.

-(void)loadGameOver:(NSTimer *)theTimer{

	
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
		delegate.gameStatus = kGameOver;
	
	delegate.snakeHeadX = game.snake.head_x;
	 delegate.snakeHeadY = game.snake.head_y;
	 
	 delegate.snakeTailX = game.snake.tail_x;
	 delegate.snakeTailY	= game.snake.tail_y;
	 
	 delegate.snakeHeadDirection = game.snake.headDirection;
	 delegate.snakeTailDirection	= game.snake.tailDirection;
	 
	 delegate.snakeBends = game.snake.bends;
	 delegate.snakeBendDirection = game.snake.bend_direction;
	 
	 delegate.snakeFoodX = game.food.food_x;
	 delegate.snakeFoodY = game.food.food_y;
	 
	 delegate.delegateScore = game.score;
	

	
	[delegate switchView:self.view toview:delegate.gameOverMenu.view delay:YES remove:YES display:nil curlup:NO curldown:YES];
	
	
	
	[pool release];
	
	
	
}


// Function that moves the snake at regluar intervals of time. 
// Uses a CADisplaylink to move the snake.
-(void)moveSnake:(CADisplayLink *)sender{
	

	
		SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
if (delegate.gameStatus != kGamePause) {
	
	if (game.snake.headDirection == kEastDirection) {
		[game moveTimerSnakeRight];
		if (delegate.isWallOn) {
			score_label.center = CGPointMake(280, 20);
		}
		else {
			score_label.center = CGPointMake(284, 10);
		}

		score_label.text = [NSString stringWithFormat:@"%d",game.score];
	
		
	}
	else if (game.snake.headDirection == kWestDirection){
		[game moveTimerSnakeLeft];
		if (delegate.isWallOn) {
			score_label.center = CGPointMake(280, 20);
		}
		else {
			score_label.center = CGPointMake(284, 10);
		}
		score_label.text = [NSString stringWithFormat:@"%d",game.score];
		
	}
	else if (game.snake.headDirection == kNorthDirection){
		[game moveTimerSnakeUp];
		if (delegate.isWallOn) {
			score_label.center = CGPointMake(280, 20);
		}
		else {
			score_label.center = CGPointMake(284, 10);
		}
		score_label.text = [NSString stringWithFormat:@"%d",game.score];
		
	}
	else {
		[game moveTimerSnakeDown];
		if (delegate.isWallOn) {
			score_label.center = CGPointMake(280, 20);
		}
		else {
			score_label.center = CGPointMake(284, 10);
		}
		score_label.text = [NSString stringWithFormat:@"%d",game.score];
		
	}
	
	if (game.gameOver == YES) {
		
		[self gameOver:sender];
		
		
	}

	delegate.snakeHeadX = game.snake.head_x;
	delegate.snakeHeadY = game.snake.head_y;
	
	delegate.snakeTailX = game.snake.tail_x;
	delegate.snakeTailY	= game.snake.tail_y;
	
	delegate.snakeHeadDirection = game.snake.headDirection;
	delegate.snakeTailDirection	= game.snake.tailDirection;
	
	delegate.snakeBends = game.snake.bends;
	delegate.snakeBendDirection = game.snake.bend_direction;
	
	delegate.snakeFoodX = game.food.food_x;
	delegate.snakeFoodY = game.food.food_y;
	
	
	
	delegate.delegateScore = game.score;
	
//	delegate.displayLink = self.displayLink;
}
			
}


- (void)viewDidLoad {
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	if (delegate.isWallOn) {
		score_label.center = CGPointMake(280, 20);
		time_label.center = CGPointMake(10, 20);
	}
	else {
		score_label.center = CGPointMake(284, 10);
		time_label.center = CGPointMake(0, 10);
	}
	
	
}

- (void) viewDidAppear:(BOOL)animated {

	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	
	if (delegate.theme == kClassicTheme) {
		background.image = [UIImage imageNamed:@"_0000_gameplay_classic.png"];
	}
	else if (delegate.theme == kTheme1){
	
		background.image = [UIImage imageNamed:@"_0003_gameplay_theme1.png"];
		
	}
	else if (delegate.theme == kTheme2){
		
		background.image = [UIImage imageNamed:@"_0001_gameplay_theme2.png"];
		
	}
	else if (delegate.theme == kTheme3){
		
		background.image = [UIImage imageNamed:@"_0002_gameplay_theme3.png"];
		
	}

	
	
	

	
	comeFromPause = NO;
		[self startGame];
	
	
	

	
	
	
}

// Alert that takes the user to the store if a level is locked
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	
	if(buttonIndex == 0)
	{
		
		[FlurryAnalytics logEvent:@"extreme/Unlock pressed in popup"];
		SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
		
		[delegate switchView:self.view toview:delegate.storeView.view delay:NO remove:NO display:nil curlup:YES curldown:NO];
		
		
		
	}
}

-(void) startGame{
	
	
	UIColor *backgroundImage =[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"snake check.png"]];
	
	game.backgroundColor = backgroundImage;
	
	[backgroundImage release];
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	
	
	if (delegate.appLaunch == NO && delegate.comeFromResume == NO && delegate.inTransition == YES && delegate.gameMode == kExtremeMode  && delegate.fieldMode == kFullWall) {
		game.snake.head_x = 235.0;
		game.snake.head_y = 145.0;
        int abc = delegate.bonusFoodNumber;
	}
	
	if (delegate.appLaunch == NO && delegate.comeFromResume == NO && delegate.inTransition == YES && delegate.gameMode == kExtremeMode  && delegate.fieldMode == kHoleWall) {
		game.snake.head_x = 275.0;
		game.snake.head_y = 145.0;
	}
	
	if (delegate.appLaunch == NO && delegate.comeFromResume == NO && delegate.inTransition == YES && delegate.gameMode == kExtremeMode && delegate.fieldMode == kSquareWall) {
		game.snake.head_x = 295.0;
		game.snake.head_y = 145.0;
		game.snake.tail_x = 25.0;
		game.snake.tail_y = 145.0;
	}
	
	if(delegate.appLaunch == YES){
		
		
	}
	else {
		
		if (delegate.theme == kClassicTheme) {
			background.image = [UIImage imageNamed:@"_0000_gameplay_classic.png"];
		}
		else if (delegate.theme == kTheme1){
			
			background.image = [UIImage imageNamed:@"_0003_gameplay_theme1.png"];
			
		}
		else if (delegate.theme == kTheme2){
			
			background.image = [UIImage imageNamed:@"_0001_gameplay_theme2.png"];
			
		}
		else if (delegate.theme == kTheme3){
			
			background.image = [UIImage imageNamed:@"_0002_gameplay_theme3.png"];
			
		}

	
		
		if ((delegate.fieldMode == kHoleWall && delegate.holeUnlocked == NO)) {
			//UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Field Locked" message:@"To continue you need to unlock the field Hole in the Wall." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Unlock",nil];
			
			//[alert show];
			[FlurryAnalytics logEvent:@"extreme/pop to unlock hitw shown"];
			[NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(showAlert2:) userInfo:nil repeats:NO];
		}
		else if ((delegate.fieldMode == kSquareWall && delegate.squareUnlocked == NO)) {
			//UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Field Locked" message:@"To continue you need to unlock the field 4square." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Unlock",nil];
			
			//[alert show];
			[FlurryAnalytics logEvent:@"extreme/pop to unlock 4sq shown"];
			[NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(showAlert3:) userInfo:nil repeats:NO];
		}
		else {
			currentView = game;
	
	
	
	bonusCounter = 1;
	
	
	
	
	
	
	
	
	
	
	
	score_label.text = [NSString stringWithFormat:@"%d",game.score];
	
	
	
	if (delegate.inTransition == YES && delegate.gameMode == kExtremeMode  && delegate.fieldMode == kFullWall) {
		game.snake.head_x = 235.0;
		game.snake.head_y = 145.0;
	}
	
	if (delegate.inTransition == YES && delegate.gameMode == kExtremeMode  && delegate.fieldMode == kHoleWall) {
		game.snake.head_x = 275.0;
		game.snake.head_y = 145.0;
	}
	
	if (delegate.inTransition == YES && delegate.gameMode == kExtremeMode && delegate.fieldMode == kSquareWall) {
		game.snake.head_x = 295.0;
		game.snake.head_y = 145.0;
		game.snake.tail_x = 25.0;
		game.snake.tail_y = 145.0;
	}
		
	
	 [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(startLoop:) userInfo:nil repeats:NO];
	
	
		

	
	bonusTimer = [NSTimer scheduledTimerWithTimeInterval: 13
									 target:self
								   selector:@selector(generateBonusFood:)
								   userInfo:nil
									repeats:YES];
	
	
	
	
	
	if (delegate.gameMode == kExtremeMode) {
		time_label.text = [NSString stringWithFormat:@"%d", delegate.time];
	
	}

	
	
	
	
	}
	}
	
	
   // [super viewDidLoad];
}



-(void) showAlert1 :(NSTimer *)theTimer{
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Field Locked" message:@"To continue you need to unlock the fields Hole in the Wall and 4square." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Unlock",nil];
	
	[alert show];
	
	[theTimer invalidate];
	
	
	
}

// Alert to show the user when Hole in the wall field is locked
-(void) showAlert2 :(NSTimer *)theTimer{
	
	
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Field Locked" message:@"To continue you need to unlock the field Hole in the Wall." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Unlock",nil];
	
	[alert show];
	
	[theTimer invalidate];
	
	
	
}
// Alert to show the user when 4square field is locked
-(void) showAlert3 :(NSTimer *)theTimer{
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Field Locked" message:@"To continue you need to unlock the field 4square." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Unlock",nil];
	
	[alert show];
	
	[theTimer invalidate];
	
	
	
}


// Function that keeps track of how much time the level has been played
// in the extreme mode. And changes level when the time has expiered 
-(void) countTime :(NSTimer *)theTimer{

	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	delegate.time -= 1;
	
	time_label.text = [NSString stringWithFormat:@"%.2d", delegate.time];
	
	if (delegate.time == 0 ) {
		[theTimer invalidate];
		
		delegate.inTransition = YES;
		
		displayLink.paused = YES;
		//[delegate.displayLink invalidate];
		
		
		if(delegate.gameMode == kExtremeMode && delegate.fieldMode == kNoWall)
		{
			
			
			fullWallTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(loadFullGame:) userInfo:nil repeats:NO];
			
		}
		
		if(delegate.gameMode == kExtremeMode && delegate.fieldMode == kFullWall)
		{
			
			
			holeTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(loadHoleGame:) userInfo:nil repeats:NO];
			
		}
		
		if(delegate.gameMode == kExtremeMode && delegate.fieldMode == kHoleWall)
		{
			
			
			squareTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(loadSquareGame:) userInfo:nil repeats:NO];
			
		}
		
		if (delegate.gameMode == kExtremeMode && delegate.fieldMode == kSquareWall) {
			delegate.gameStatus = kGameOver;
			delegate.inTransition = NO;
			[self gameOver:delegate.displayLink];
			delegate.extremeSuccess = 1;
		}
		
	}
	
}


// Function to start the actual game. Intialize the Display link and call the function to keep moving the snake.
-(void)startLoop:(NSTimer *)theTimer{
	

	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	
	
	if ((delegate.comeFromResume == NO && delegate.gameStatus == kGameActive) || delegate.inTransition == YES) {
		delegate.time = 45;
		
		
	}
	else {
		delegate.comeFromResume = NO;
	}
	

	if ((delegate.gameMode == kExtremeMode && delegate.gameStatus == kGameActive) || delegate.inTransition == YES) {
		time_label.text = [NSString stringWithFormat:@"%.2d", delegate.time];
		
		countTimer = nil;
		
		countTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countTime:) userInfo:nil repeats:YES];
		
	}
	
	
	//if (delegate.gameMode == kExtremeMode) {
	
	if (delegate.inTransition == YES) {
	
		

		[self.currentView.wallLayer setNeedsDisplay];
		delegate.gameStatus = kGameActive;
		
		delegate.displayLink.paused = NO;
	}
	
	delegate.inTransition = NO;
	
	
	displayLink = nil;
	
	
	displayLink = [NSClassFromString(@"CADisplayLink") displayLinkWithTarget:self selector:@selector(moveSnake:)];
	
	
	if (delegate.speed == 1) {
		
		[displayLink setFrameInterval:10.5];
		
	}
	else if (delegate.speed == 2){

		[displayLink setFrameInterval:9.0];
		
	}
	else if (delegate.speed == 3){

		[displayLink setFrameInterval:7.5];
		
	}
	else if (delegate.speed == 4){

		[displayLink setFrameInterval:6.0];
		
	}
	else if (delegate.speed == 5){

		[displayLink setFrameInterval:4.5];
		
	}
	
	
	
	
	
	
	delegate.displayLink = displayLink;
	
	//if (comeFromPause == YES) {
	//	comeFromPause = NO;
		
//	}
//	else {
		[displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
		
//	}
	
	
	
	
	
	[pool release];

	
	
	
	
}

// Function that starts the time when the extreme mode starts
-(void) startTime{
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	displayLink.paused = NO;
	
	time_label.text = [NSString stringWithFormat:@"%.2d", delegate.time];
	
	countTimer = nil;
	
	countTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countTime:) userInfo:nil repeats:YES];
	

	delegate.comeFromResume = NO;
	
	
}


// Function to load the Box level of the game in extreme mode
-(void) loadFullGame :(NSTimer *)theTimer{
	

	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	if (delegate.gameStatus != kGameOver) {
		
		displayLink.paused = YES;
	
		[delegate.displayLink invalidate];
	
		delegate.activeGame = delegate.fullWallGame;
	
		delegate.gameStatus = kGamePause;
		delegate.isWallOn = YES;
		delegate.fieldMode = kFullWall;
	
		[delegate switchView:self.view toview:delegate.fullWallGame.view delay:YES remove:YES display:nil curlup:NO curldown:NO];

	}
	
	
}

// Function to load the Hole in the wall level of the game in extreme mode
-(void) loadHoleGame :(NSTimer *)theTimer{
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	if (delegate.gameStatus != kGameOver) {
		displayLink.paused = YES;
	
		[delegate.displayLink invalidate];
	
		delegate.activeGame = delegate.holeWallGame;
	
		delegate.gameStatus = kGamePause;
		delegate.isWallOn = YES;
		delegate.fieldMode = kHoleWall;
	
		[delegate switchView:self.view toview:delegate.holeWallGame.view delay:YES remove:YES display:nil curlup:NO curldown:NO];
	}
}


// Function to load the 4square level of the game in extreme mode
-(void) loadSquareGame :(NSTimer *)theTimer{
	
	
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	if (delegate.gameStatus != kGameOver) {
		displayLink.paused = YES;
	
		[delegate.displayLink invalidate];
	
		delegate.activeGame = delegate.squareWallGame;
	
		delegate.gameStatus = kGamePause;
		delegate.isWallOn = YES;
		delegate.fieldMode = kSquareWall;
	
		[delegate switchView:self.view toview:delegate.squareWallGame.view delay:YES remove:YES display:nil curlup:NO curldown:NO];
	
	

	
		
	}
	
}


// Function that is called when the extreme mode is over. That is when time is up for all levels

-(void) extremeOver :(NSTimer *)theTimer{
	

	[self gameOver:nil];
	
	
	
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
	
	
	
	
	
    [super didReceiveMemoryWarning];
	
	
		
	
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}



// Function to draw the walls of the game if the walls were selected to be On.

-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)context{
	
	
	
	
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	UIColor *wallColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
	
	CGContextBeginPath(context);
	
	
	
	
	
	CGContextSetLineJoin(context, kCGLineJoinMiter);
	CGContextSetShadowWithColor(context, CGSizeMake(0.0, 0.0), 0, 0);
	
	
	if (delegate.isWallOn == YES ) {
		CGContextSetLineWidth(context, 10.0);
		
		
		CGContextSetStrokeColorWithColor(context,wallColor.CGColor);
		
		
		
		if (delegate.fieldMode == kFullWall) {
		
			CGContextMoveToPoint(context, 0,5);
		
		
			CGContextAddLineToPoint(context, 315, 5);
		
			CGContextAddLineToPoint(context, 315, 295);
		
			CGContextAddLineToPoint(context, 5, 295);
			
			CGContextAddLineToPoint(context, 5, 5);  

			CGContextStrokePath(context);  
		}
		
		if (delegate.fieldMode == kHoleWall) {
		
	 
			CGContextMoveToPoint(context, 0,5);
			CGContextAddLineToPoint(context, 139, 5);
			CGContextMoveToPoint(context, 181,5);
			CGContextAddLineToPoint(context, 315, 5);
			CGContextAddLineToPoint(context, 315, 129);
			CGContextMoveToPoint(context, 315,171);
			CGContextAddLineToPoint(context, 315, 295);
			CGContextAddLineToPoint(context, 181, 295);
			CGContextMoveToPoint(context, 139,295);
			CGContextAddLineToPoint(context, 5, 295);
			CGContextAddLineToPoint(context, 5, 171);
			CGContextMoveToPoint(context, 5,129);
			CGContextAddLineToPoint(context, 5, 5);
			CGContextStrokePath(context);  
		}
		
		
		if (delegate.fieldMode == kSquareWall) {
		
			CGContextMoveToPoint(context, 0,5);
			CGContextAddLineToPoint(context, 135, 5);
			CGContextAddLineToPoint(context, 135, 129);
			
			CGContextMoveToPoint(context, 185,129);
			CGContextAddLineToPoint(context, 185, 5);
			CGContextAddLineToPoint(context, 315, 5);
			CGContextAddLineToPoint(context, 315, 129);
		
			CGContextMoveToPoint(context, 315,171);
			CGContextAddLineToPoint(context, 315, 295);
			CGContextAddLineToPoint(context, 185, 295);
			CGContextAddLineToPoint(context, 185, 171);
	
			CGContextMoveToPoint(context, 135,171);
			CGContextAddLineToPoint(context, 135, 295);		
			CGContextAddLineToPoint(context, 5, 295);
			CGContextAddLineToPoint(context, 5, 171);
		
			CGContextMoveToPoint(context, 5,129);
			CGContextAddLineToPoint(context, 5, 5);
			
			CGContextStrokePath(context);
		}
	}
	
	
	
	
}

- (void)dealloc {
	

    [super dealloc];
}



@end
