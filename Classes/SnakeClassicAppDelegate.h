//
//  SnakeClassicAppDelegate.h
//  SnakeClassic
//
//  Created by Swapan Rajdev on 9/2/10.
//  Copyright Zing! Apps 2010. All rights reserved.
//
//   Update V2.2.1: While submitting V2.2, a sound file was missing which was causing the app to crash.
//					Adding the sound file to make sure the app does not crash
//
//   Update V2.2: Updates and fixes.
//
//   Updated: V 2.1.1: Fixed a small bug that was causing crash in certain devices.
//
//
//
//   Updated V2.1: Bug fixes. Added full screen ad in free version
//                
//
//   There are 2 versions of this code being submitted. 
//   1. UNLOCKED VERSION - Snake Classic Unlocked (As part of V2 update)
//   2. LOCKED VERSION - Snake Classic
//
//	Updated V2: Added extra functionality. Added themes and mazes (Fields)
//				 We now have a LOCKED and UNLOCKED version
//			     UNLOCKED version has all the themes and mazes available and no Ads
//				 In the LOCKED version the user has to unlock the themes and fields by downloading apps
//               Also added extreme mode, unlock features, help page
//
//
//
//   Description: This is the App delegate for the Snake Game
//   Update V1.1: Added facebook and twitter integration.
//				: Global and facebook highscores
//   

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import <QuartzCore/CADisplayLink.h>
#import <QuartzCore/QuartzCore.h>
#include <AudioToolbox/AudioToolbox.h>

#import "constants.h"
#include <AVFoundation/AVFoundation.h>
#include "FBConnect.h"
#import "Session.h"
#import "UserInfo.h"
#import "GameModeViewController.h"
#import "FieldModeViewController.h"
#import "StoreViewController.h"
#import "UseCreditsViewController.h"
#import "UnlockViewController.h"
#import "EarnCreditsViewController.h"
#import "HelpPageViewController.h"
#import "helpDetailViewController.h"
#import <GameKit/GameKit.h>


@class snakeType;
@class foodType;

@class main_menu;
@class Snake_3ViewController;
@class HighScoreViewController;
@class Options;
@class Difficulty;
@class GameOver;
@class GlobalViewController;
@class EarnCreditsViewController;

@interface SnakeClassicAppDelegate : NSObject <UIApplicationDelegate, AVAudioPlayerDelegate, FBSessionDelegate,
UserInfoLoadDelegate, FBDialogDelegate> {
    
    UIWindow *window;
	
	main_menu *mainmenu;
	
	main_menu *reusmeMenu;
	
	HighScoreViewController *scoreMenu;
	GlobalViewController *globalScore;
	
	Options *optionMenu;
	
	Difficulty *difficultyMenu;
	GameOver *gameOverMenu;
	
	GameModeViewController *gameModeMenu;
	
	FieldModeViewController *fieldModeMenu;
	
	
	
	Snake_3ViewController *activeGame;
	
	GameStatus gameStatus;
	
	AVAudioPlayer *player;
	
	CFURLRef		soundFileURLRef;
	SystemSoundID	soundFileObject;

	
	AVAudioPlayer *bonusfoodplayer;
	
	int foodNumber;
	int bonusFoodNumber;
	
	int extremeSuccess;
	int missedInExtreme;
	
	
	float snakeHeadX;
	float snakeHeadY;
	
	float snakeTailX;
	float snakeTailY;
	
	Direction	snakeHeadDirection;
	Direction snakeTailDirection;
	
	//NSArray *snakeBends;
	//NSArray *snakeBendDirection;
	
	NSMutableArray *snakeBends;
	NSMutableArray *snakeBendDirection;
	
	float snakeFoodX;
	float snakeFoodY;
	
	
	
	
	CADisplayLink *displayLink;
	
	int speed;
	
	UIColor *snakeColor;
	
	
	NSString *playerName;
	
	int delegateScore;
	
	BOOL isVibrateOn;
	
	BOOL isSoundOn;
	
	BOOL isWallOn;
	
	NSMutableArray *globalScores;
	
	BOOL FBLoggedIn;
	
	BOOL TwitterLoggedIn;
	
	
	Facebook *facebook;
	NSArray *permissions;
	
	Session *_session;
	UserInfo *_userInfo;
	
	bool loginFromScore;
	bool loginFromOver;
	
	GameMode gameMode;
	
	FieldMode fieldMode;
	
	ThemeMode theme;
	
	Snake_3ViewController *fullWallGame;
	
	Snake_3ViewController *holeWallGame;
	
	Snake_3ViewController *squareWallGame;
	
	StoreViewController *storeView;
	
	UnlockViewController *unlockView;
	
	EarnCreditsViewController *earnView;
	
	
	UseCreditsViewController *useCreditsView;
	
	HelpPageViewController *helpPage;
	
	helpDetailViewController *helpDetail;
	int time;
	
	BOOL comeFromResume;
	
	BOOL inTransition;
	
	
	BOOL holeUnlocked;
	BOOL squareUnlocked;
	BOOL nightUnlocked;
	BOOL gardenUnlocked;
	BOOL beachUnlocked;
	
	BOOL maxOpen;
	BOOL maxBox;
	BOOL maxHole;
	BOOL maxSquare;
	
	
	int totalbalance;
	int userBalance;
	
	creditPressed creditsInfo;
	
	
	BOOL appLaunch;
	
	help helpMode;
	
	toHelp pageFrom;
	
	BOOL morethanOnce;
	
	BOOL isconnected;
	
	
	
	NSString *device_Token;
	
	int take_over;
	
	int take_over_menu;
	
	int take_count;
	

	bool earn_from_menu;
	
	int unlockFromAnother;
	
	NSMutableDictionary *achievementsDictionary;
    
    BOOL GCTest;
    
    BOOL GCConnected;

    NSMutableArray *achievementsToSubmit;
	

	
	

    
@private
    NSManagedObjectContext *managedObjectContext_;
    NSManagedObjectModel *managedObjectModel_;
    NSPersistentStoreCoordinator *persistentStoreCoordinator_;
}





@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;


@property (nonatomic,retain) AVAudioPlayer *player;

@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@property (nonatomic,retain) AVAudioPlayer *bonusfoodplayer;


@property int delegateScore;
@property BOOL isWallOn;

@property (nonatomic,retain) CADisplayLink *displayLink;
@property (nonatomic ,retain) main_menu *mainmenu;
@property (nonatomic,retain) main_menu *resumeMenu;
@property (nonatomic,retain) GameModeViewController *gameModeMenu;
@property (nonatomic,retain) FieldModeViewController *fieldModeMenu;
@property (nonatomic,retain) StoreViewController *storeView;
@property (nonatomic,retain) UseCreditsViewController *useCreditsView;
@property (nonatomic,retain) UnlockViewController *unlockView;
@property (nonatomic,retain) EarnCreditsViewController *earnView;
@property (nonatomic,retain) HelpPageViewController *helpPage;
@property (nonatomic,retain) helpDetailViewController *helpDetail;





@property (nonatomic,retain) Snake_3ViewController *activeGame;

@property (nonatomic ,retain) UIColor *snakeColor;

@property int speed;

@property int foodNumber;
@property int bonusFoodNumber;
@property int extremeSuccess;
@property int missedInExtreme;




@property GameStatus gameStatus;

@property creditPressed creditsInfo;

@property float snakeHeadX;
@property float snakeHeadY;

@property float snakeTailX;
@property float snakeTailY;

@property Direction snakeHeadDirection;
@property Direction snakeTailDirection;

//@property (nonatomic,retain) NSArray *snakeBends;
//@property(nonatomic,retain) NSArray *snakeBendDirection;

@property (nonatomic,retain) NSMutableArray *snakeBends;
@property(nonatomic,retain) NSMutableArray *snakeBendDirection;

@property  float snakeFoodX;
@property float snakeFoodY;

@property (nonatomic,retain) NSString *playerName;

@property BOOL isVibrateOn;

@property BOOL isSoundOn;

@property (nonatomic,retain) HighScoreViewController *scoreMenu;
@property (nonatomic,retain) Options *optionMenu;
@property (nonatomic,retain) Difficulty *difficultyMenu;
@property (nonatomic,retain) GameOver *gameOverMenu;



@property (nonatomic,retain) NSMutableArray *globalScores;

@property BOOL FBLoggedIn;
@property 	BOOL TwitterLoggedIn;

@property 	bool loginFromScore;
@property bool loginFromOver;
@property (nonatomic,retain) UserInfo *_userInfo;
@property (nonatomic,retain) Facebook *facebook;

@property GameMode gameMode;
@property FieldMode fieldMode;
@property ThemeMode theme;
@property (nonatomic,retain)	Snake_3ViewController *fullWallGame;

@property (nonatomic,retain) 	Snake_3ViewController *holeWallGame;

@property (nonatomic,retain) 	Snake_3ViewController *squareWallGame;

@property BOOL comeFromResume;

@property int time;

@property BOOL inTransition;

@property BOOL holeUnlocked;
@property BOOL squareUnlocked;
@property BOOL nightUnlocked;
@property BOOL gardenUnlocked;
@property BOOL beachUnlocked;

@property BOOL maxOpen;
@property BOOL maxBox;
@property BOOL maxHole;
@property BOOL maxSquare;

@property int totalbalance;
@property int userBalance;

@property BOOL appLaunch;

@property help helpMode;

@property BOOL morethanOnce;

@property BOOL isconnected;


@property toHelp pageFrom;

@property int take_over;
@property int take_over_menu;

@property int take_count;

@property int unlockFromAnother;

@property bool earn_from_menu;

@property(nonatomic, retain) NSMutableDictionary *achievementsDictionary;

@property (nonatomic,retain) NSString *device_Token;

@property BOOL GCTest;

@property BOOL GCConnected;

@property (nonatomic, retain) NSMutableArray *achievementsToSubmit;


-(void) play;
-(void)bonusPlay;


-(void)drawFood:(CALayer *)layer;
-(void)drawBonusFood:(CALayer *)layer;




-(void)switchView:(UIView *)view1 toview:(UIView *)view2 delay:(BOOL)doDelay 
		   remove:(BOOL)doRemove display:(CADisplayLink *)link curlup:(BOOL)curlUp curldown:(BOOL)curlDown;

- (void) login;
- (void) logout;

-(void) insertToken;
-(void) showAlert;

- (BOOL) connectedToNetwork;

- (void)authenticateLocalPlayer;

-(void)unlockFBAchievement;

- (void) loadAchievements;

- (GKAchievement*) getAchievementForIdentifier: (NSString*) identifier;

- (void) reportAchievementIdentifier: (NSString*) identifier percentComplete: (float) percent;

-(void) clearAchievements;

-(BOOL) isGameCenterAPIAvailable;

- (void)dataAvailable;

//- (void)dataUnavailable;



//-(void)addHighScore:(int)score;

- (NSString *)applicationDocumentsDirectory;

@end

