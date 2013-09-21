//  Constants.h
//
//  Created by Swapan Rajdev on 9/2/10.
//  Copyright Zing! Apps 2010. All rights reserved.
//
//  Description: File to define all the constants 



/* Direction enum defines all the possible directions the snake can move in
 
 There are a few extra directions used to take care of snake going through the screen
 and entering on the other side 
 */
typedef enum{
	kEastDirection = 0,
	kWestDirection,
	kNorthDirection,
	kSouthDirection,
	kEastOut,
	kNorthOut,
	kSouthOut,
	kWestout,
	kEastIn,
	kNorthIn,
	kSouthIn,
	kWestIn
	
} Direction;

/*GameStatus enum defines all the different states of the game*/

typedef enum{
	kGameStart = 0, //0
	kGameActive, //1
	kGamePause, //2
	kGameOver //3
} GameStatus;


typedef enum{
	kClassicMode = 0, //0
	kExtremeMode, //1
} GameMode;


typedef enum{
	kNoWall = 0, //0
	kFullWall, //1
	kHoleWall, //2
	kSquareWall //3
} FieldMode;


typedef enum{
	kClassicTheme = 0, //0
	kTheme1, //1
	kTheme2, //2
	kTheme3 //3
} ThemeMode;


typedef enum{
	kBeach = 0, //0
	kGarden, //1
	kNight, //2
	kHole, //3
	kSquare //4
} creditPressed;


typedef enum{
	kGamePlay = 0,
	kUnlockItems,
	kFAQ
} help;


typedef enum{
	kFromHelp = 0,
	kFromGameMode,
	kFromStore
} toHelp;





#define SNAKE_INCREMENT 10.0;   // pixels by which the snake increments

#define GAME_Y_BOUND 320.0; 
#define GAME_X_BOUND 320.0;

#define kSampleAppKey @"cfb6b6dd6df4492fa149e090f85e85ce" // adWhirl Key

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define NEWGAME_BUTTON_X 86;
#define NEWGAME_BUTTON_Y 140;

#define RESUMEGAME_BUTTON_X 86;
#define RESUMEGAME_BUTTON_Y 191;

#define OPTIONGAME_BUTTON_X 86;
#define OPTIONGAME_BUTTON_Y 244;

#define HELP_BUTTON_X 8;
#define HELP_BUTTON_Y 395;

#define CHECKACHIEVEMENT_BUTTON_X 272;
#define CHECKACHIEVEMENT_BUTTON_Y 389;

