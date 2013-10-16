//
//  SnakeClassicAppDelegate.m
//  SnakeClassic
//
//  Created by Swapan Rajdev on 9/2/10.
//  Copyright Zing! Apps 2010. All rights reserved.
//
//   Update V2.2.1: While submitting V2.2, a sound file was missing which was causing the  app to crash.
//					Adding the sound file to make sure the app does not crash
//
//   Update V2.2: Updates and fixes.
//
//   Updated: V 2.1.1: Fixed a small bug that was causing crash in certain devices.
//
//
//   Description: The is the App delegate for the Snake game.
//   Update V1.1: Added facebook and twitter integration.
//				: Global and facebook highscores
//
//
//   Updated V2.1: Bug fixes. Added full screen ad in free version


#import "SnakeClassicAppDelegate.h"

#import "main_menu.h"
#import "snakeType.h"
#import "foodType.h"
#import "Snake_3ViewController.h"
//#import "FlurryAnalytics.h"
//#import "FlurryAppCircle.h"
//#import "FlurryClips.h"
#import "HighScoreViewController.h"
#import "Options.h"
#import "Difficulty.h"
#import "GameOver.h"
#import "SystemConfiguration/SCNetworkReachability.h"
#import <GameKit/GameKit.h>
#import "GKAchievementHandler.h"

#import "sys/socket.h"
#import "netinet/in.h"
#import "SystemConfiguration/SystemConfiguration.h"



@implementation SnakeClassicAppDelegate

@synthesize window;
@synthesize mainmenu;
@synthesize resumeMenu;
@synthesize speed;
@synthesize snakeColor;
@synthesize gameStatus;
@synthesize displayLink;
@synthesize delegateScore;
@synthesize isWallOn;


@synthesize activeGame;



@synthesize snakeHeadX;
@synthesize snakeHeadY;

@synthesize snakeTailX;
@synthesize snakeTailY;

@synthesize snakeHeadDirection;
@synthesize snakeTailDirection;

@synthesize snakeBends;
@synthesize snakeBendDirection;

@synthesize snakeFoodX;
@synthesize snakeFoodY;

@synthesize playerName;

@synthesize foodNumber;
@synthesize bonusFoodNumber;
@synthesize extremeSuccess;
@synthesize missedInExtreme;





@synthesize isVibrateOn;

@synthesize isSoundOn;

@synthesize scoreMenu;
@synthesize optionMenu;
@synthesize difficultyMenu;
@synthesize gameOverMenu;
@synthesize player;

@synthesize soundFileURLRef;
@synthesize soundFileObject;

@synthesize bonusfoodplayer;


@synthesize globalScores;
@synthesize FBLoggedIn;
@synthesize TwitterLoggedIn;
@synthesize facebook;
@synthesize loginFromScore;
@synthesize loginFromOver;
@synthesize _userInfo;
@synthesize gameMode;
@synthesize fieldMode;

@synthesize gameModeMenu;
@synthesize fieldModeMenu;

@synthesize fullWallGame;

@synthesize holeWallGame;

@synthesize squareWallGame;
@synthesize theme;
@synthesize time;

@synthesize comeFromResume;
@synthesize inTransition;

@synthesize  storeView;

@synthesize holeUnlocked;
@synthesize squareUnlocked;
@synthesize nightUnlocked;
@synthesize gardenUnlocked;
@synthesize beachUnlocked;

@synthesize  maxOpen;
@synthesize  maxBox;
@synthesize  maxHole;
@synthesize  maxSquare;


@synthesize  useCreditsView;
@synthesize unlockView;
@synthesize helpPage;
@synthesize helpDetail;

@synthesize earnView;
@synthesize creditsInfo;

@synthesize userBalance;

@synthesize totalbalance;
@synthesize appLaunch;
@synthesize helpMode;
@synthesize pageFrom;

@synthesize morethanOnce;
@synthesize isconnected;

@synthesize  device_Token;

@synthesize take_over;

@synthesize take_over_menu;

@synthesize take_count;

@synthesize earn_from_menu;


@synthesize unlockFromAnother;

@synthesize achievementsDictionary;

@synthesize GCTest;

@synthesize GCConnected;

@synthesize achievementsToSubmit;




static NSString* kFBAppId = @"158392174179755";

-(void)play{
	
	[self.player play];
	
	//AudioServicesPlaySystemSound (soundFileObject);
	
}

-(void)bonusPlay{
	
	[self.bonusfoodplayer play];
	
}
- (void)dataAvailable{
    
    //NSLog(@"data is available");
    
}



- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken { 
	
  //  NSString *str = [NSString 
	//				 stringWithFormat:@"Device Token=%@",deviceToken];
	
	device_Token = [NSString 
					stringWithFormat:@"%@",deviceToken];
	
	
    
	
	[self insertToken];
	
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err { 
	
    //NSString *str = [NSString stringWithFormat: @"Error: %@", err];
   
	
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
	
    for (id key in userInfo) {
        //NSLog(@"key: %@, value: %@", key, [userInfo objectForKey:key]);
    }    
	
}



- (BOOL) connectedToNetwork
{
	// Create zero addy
	struct sockaddr_in zeroAddress;
	bzero(&zeroAddress, sizeof(zeroAddress));
	zeroAddress.sin_len = sizeof(zeroAddress);
	zeroAddress.sin_family = AF_INET;
    
	SCNetworkReachabilityFlags flags;
    //Recover reachability flags;
	SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
	
	
	BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
	CFRelease(defaultRouteReachability);
	
	if (!didRetrieveFlags)
	{		return NO;
	}

    
	BOOL isReachable = flags & kSCNetworkFlagsReachable;
	BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
	return (isReachable && !needsConnection) ? YES : NO;


 }

#pragma mark -
#pragma mark Application lifecycle



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
	
	
    [[UIApplication sharedApplication] 
	 registerForRemoteNotificationTypes:
	 (UIRemoteNotificationTypeAlert | 
	  UIRemoteNotificationTypeBadge | 
	  UIRemoteNotificationTypeSound) ];
	
	
	take_over = 0;
	take_over_menu = 0;
	earn_from_menu = NO;
	

	
	GCTest = [self isGameCenterAPIAvailable];
    GCConnected = NO;
    
    if (GCTest) {
        
        [self authenticateLocalPlayer];
    }
	
//	GSAdSlotDescription * slot2 = [GSAdSlotDescription descriptionWithSize:kGSAdSizeIPhoneFullScreen name:@"fullscreenSlot"];
	
	achievementsDictionary = [[NSMutableDictionary alloc] init];
	
	//[self loadAchievements];
	
	
	
	NSString *applicationID = @"6cb1c347-cd2b-4b24-8fcd-ccf728144e92";
//	[GSAdEngine startupWithAppID:applicationID adSlotDescriptions:[NSArray arrayWithObject:slot2]];
	
	
	
	unlockFromAnother = 0;
	
	gameMode = kClassicMode;
	fieldMode = kNoWall;
	
	
	

	
	
		appLaunch = YES;
	inTransition = NO;
	
    // Override point for customization after application launch.
	
	[application setStatusBarHidden:YES];
		
	
    [window makeKeyAndVisible];
	
	permissions =  [[NSArray arrayWithObjects: 
					 @"read_stream", @"offline_access",nil] retain];
	
	facebook = [[Facebook alloc] init];
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	[[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryAmbient error: nil];
	
	NSString *path = [[NSBundle mainBundle] pathForResource:@"food" ofType:@"WAV"];
	
	NSURL *file = [[NSURL alloc] initFileURLWithPath:path];
	
	AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:file error:nil];
	
	[file release];
	
	self.player = audioPlayer;
	
	
	[audioPlayer release];
	
	[player prepareToPlay];
	
	
	[player setDelegate:self];

	
	
	
	NSString *bonuspath = [[NSBundle mainBundle] pathForResource:@"bonus" ofType:@"WAV"];
	
	NSURL *bonusfile = [[NSURL alloc] initFileURLWithPath:bonuspath];
	
	AVAudioPlayer *bonusaudioplayer = [[AVAudioPlayer alloc] initWithContentsOfURL:bonusfile error:nil];
	
	[bonusfile release];
	
	self.bonusfoodplayer = bonusaudioplayer;
	
	[bonusaudioplayer release];
	
	[bonusfoodplayer prepareToPlay];
	
	[bonusfoodplayer setDelegate:self];
	

	
		
	int statusOfgame = [[defaults objectForKey:@"Status"] intValue];
	
	gameStatus = statusOfgame;
	
	
	
	
	_session = [[Session alloc] init];
	facebook = [[_session restore] retain];
	
	if (facebook == nil) {
		facebook = [[Facebook alloc] init];
		FBLoggedIn = NO;
	}
	else {
		FBLoggedIn = YES;
		[self fbDidLogin];
	}
	
	loginFromScore = NO;
	loginFromOver = NO;
	
	if ([defaults objectForKey:@"TakeOverCount"]) {
		take_count = [[defaults objectForKey:@"TakeOverCount"] intValue];
	}
	else{
	
		take_count = 0;
		
	}
	
	if ([defaults objectForKey:@"Theme"]) {
		theme = [[defaults objectForKey:@"Theme"] intValue];
	}
	else {
		theme = kClassicTheme;
	}
	
	
	
	if ([defaults boolForKey:@"InTransition"]) {
		inTransition = [defaults boolForKey:@"InTransition"];
	}
	else {
		inTransition = NO;
	}
	
	
	// if user has opened the app for the first time we display a pop up in sotre this 
	// saving retreving the information if the user has used the app before or no
	
	if ([defaults boolForKey:@"FirstTime"]) {
		morethanOnce = [defaults boolForKey:@"FirstTime"];
	}
	else {
		morethanOnce = NO;
	}

		
	// variables to see if the user has unlocked features.
	
	if([defaults boolForKey:@"HoleUnlocked"]){
		
		holeUnlocked = [defaults boolForKey:@"HoleUnlocked"];
	}
	
	else {
		holeUnlocked = NO;
	}
	
	if([defaults boolForKey:@"SquareUnlocked"]){
		
		squareUnlocked = [defaults boolForKey:@"SquareUnlocked"];
	}
	
	else {
		squareUnlocked = NO;
	}
	
	if([defaults boolForKey:@"GardenUnlocked"]){
		
		gardenUnlocked = [defaults boolForKey:@"GardenUnlocked"];
	}
	
	else {
		gardenUnlocked = NO;
	}
	
	if([defaults boolForKey:@"BeachUnlocked"]){
		
		beachUnlocked = [defaults boolForKey:@"BeachUnlocked"];
	}
	
	else {
		beachUnlocked = NO;
	}
	
	if([defaults boolForKey:@"NightUnlocked"]){
		
		nightUnlocked = [defaults boolForKey:@"NightUnlocked"];
	}
	
	else {
		nightUnlocked = NO;
	}
	
	
	if ([defaults boolForKey:@"MaxOpenScore"]) {
		maxOpen = [defaults boolForKey:@"MaxOpenScore"];
	}
	else {
		maxOpen = NO;
	}


	if ([defaults boolForKey:@"MaxBoxScore"]) {
		maxBox = [defaults boolForKey:@"MaxBoxScore"];
	}
	else {
		maxBox = NO;
	}
	
	if ([defaults boolForKey:@"MaxHoleScore"]) {
		maxHole = [defaults boolForKey:@"MaxHoleScore"];
	}
	else {
		maxHole = NO;
	}
	
	if ([defaults boolForKey:@"MaxSquareScore"]) {
		maxSquare = [defaults boolForKey:@"MaxSquareScore"];
	}
	else {
		maxSquare = NO;
	}
	
	if ([defaults objectForKey:@"Tobesubmitted"]){
        achievementsToSubmit = [defaults objectForKey:@"Tobesubmitted"];
    }
    else{
        achievementsToSubmit = [[NSMutableArray alloc] init ];
    }

	
	
	
	
	// If statement to check if there was a Paused game or not.
	if (statusOfgame != 2) {   //there was no paused game
		
		self.gameStatus = kGameStart;
	/*	main_menu *aMenu = [[main_menu alloc] initWithNibName:@"main_menu" bundle:nil];
		self.mainmenu = aMenu;
		
		[window addSubview:mainmenu.view];*/
		
		
	
		
				
		if ([defaults objectForKey:@"GameMode"]) {
			gameMode = [[defaults objectForKey:@"GameMode"] intValue];
		}
		else {
			gameMode = kClassicMode;
		}
		
		if ([defaults objectForKey:@"FieldMode"]) {
			fieldMode = [[defaults objectForKey:@"FieldMode"] intValue];
		}
		else {
			fieldMode = kNoWall;
		}
		
		
		if ([defaults objectForKey:@"time"]) {
			time =[[defaults objectForKey:@"time"] intValue];
		}
		else {
			time = 45;
		}



			
			
		speed = [[defaults objectForKey:@"SnakeSpeed"] intValue];
		if (speed == 0) {
			speed = 3;
		}
		
		
		if ([defaults objectForKey:@"WallOn"]) {
			isWallOn = [defaults boolForKey:@"WallOn"];
		} 
		else {
			isWallOn = YES;
		}
		
		

		
		


		if ([defaults objectForKey:@"VibrateOn"]) {
			isVibrateOn = [defaults boolForKey:@"VibrateOn"];
		}
		else {
			isVibrateOn = NO;
		}


			
		if([defaults objectForKey:@"SoundOn"]){
		
			isSoundOn = [defaults boolForKey:@"SoundOn"];
		}
			
		else {
			isSoundOn = NO;
		}


		if ([defaults objectForKey:@"Color"]) {
			int defaultSnakeColor = [[defaults objectForKey:@"Color"] intValue];
			if (defaultSnakeColor == 0) {
				snakeColor = [UIColor orangeColor];
			}
			else if (defaultSnakeColor == 1) {
				snakeColor = [UIColor blueColor];
			}
			else if (defaultSnakeColor == 2) {
				snakeColor = [UIColor greenColor];
			}
			else if (defaultSnakeColor == 3) {
				snakeColor = [UIColor blackColor];
			}
		}
		else {
			snakeColor = [UIColor greenColor];
		}

			
		playerName = [defaults objectForKey:@"PlayerName"];
			
		if ([playerName length] == 0) {
			
			self.playerName = @"Player";
		}
				
		

		self.foodNumber = 0;
		self.bonusFoodNumber = 0;
		self.extremeSuccess = 0;
		self.missedInExtreme = 0;
		
		
		
		
		
	//	[aMenu release];
		
	//	[[UIApplication sharedApplication] setStatusBarHidden:YES];
        
	}
	else {       //if there is a paused game
		gameStatus = kGamePause;
		
		snakeHeadX = [[defaults objectForKey:@"SnakeHeadX"] floatValue];
		snakeHeadY = [[defaults objectForKey:@"SnakeHeadY"] floatValue];
		
		snakeTailX = [[defaults objectForKey:@"SnakeTailX"] floatValue];
		snakeTailY	= [[defaults objectForKey:@"SnakeTailY"] floatValue];
		
		snakeHeadDirection = [[defaults objectForKey:@"SnakeHeadDirection"] intValue];
		snakeTailDirection	= [[defaults objectForKey:@"SnakeTailDirection"] intValue];
		
		snakeBends = [defaults objectForKey:@"SnakeBends1"];
		snakeBendDirection = [defaults objectForKey:@"SnakeBendDirection1"];
		
		snakeFoodX = [[defaults objectForKey:@"FoodX"] floatValue];
		snakeFoodY= [[defaults objectForKey:@"FoodY"] floatValue];
		foodNumber = [[defaults objectForKey:@"FoodNumber"] intValue];
		bonusFoodNumber = [[defaults objectForKey:@"BonusFoodNumber"] intValue];
		extremeSuccess = [[defaults objectForKey:@"ExtremeSuccess"] intValue];
		missedInExtreme = [[defaults objectForKey:@"ExtremeMissed"] intValue];
		

		
		
		delegateScore = [[defaults objectForKey:@"Score"] intValue];
		
		
		speed = [[defaults objectForKey:@"SnakeSpeed"] intValue];
		
		gameMode = [[defaults objectForKey:@"GameMode"] intValue];
		fieldMode = [[defaults objectForKey:@"FieldMode"] intValue];
		time = [[defaults objectForKey:@"time"] intValue];
	
		
		int defaultSnakeColor = [[defaults objectForKey:@"Color"] intValue];
		
		
		
		playerName = [defaults objectForKey:@"PlayerName"];
		
		
		
		isWallOn = [defaults boolForKey:@"WallOn"];
		
		isVibrateOn = [defaults boolForKey:@"VibrateOn"];
		isSoundOn = [defaults boolForKey:@"SoundOn"];
		//FBLoggedIn = [defaults boolForKey:@"FBLoggedIn"];
	
		
		if (defaultSnakeColor == 0) {
			snakeColor = [UIColor orangeColor];
		}
		else if (defaultSnakeColor == 1) {
			snakeColor = [UIColor blueColor];
		}
		else if (defaultSnakeColor == 2) {
			snakeColor = [UIColor greenColor];
		}
		else if (defaultSnakeColor == 3) {
			snakeColor = [UIColor blackColor];
		}
		
		
		
		
		
		
		
		Snake_3ViewController *gameOn = [[Snake_3ViewController alloc]initWithNibName:@"Snake_3ViewController" bundle:nil];
		self.activeGame = gameOn;
		
		[activeGame.countTimer invalidate];
		
		activeGame.displayLink.paused = YES;
		
		[window addSubview:gameOn.view];
		
		
		
		[gameOn release];
		

		
		
	/*	main_menu *aMenu = [[main_menu alloc] initWithNibName:@"main_menu" bundle:nil];
		self.mainmenu = aMenu;
		
		[window addSubview:mainmenu.view];

		
		[aMenu release];*/
		
		
		
		
		
	} 
	
	
	if([defaults objectForKey:@"Balance"]){
	
		userBalance = [[defaults objectForKey:@"Balance"] intValue];
	}
	else {
		userBalance = 0;
		totalbalance = 0;
	}

	

	/*initialize the views which will be used throughout hte game*/
	
	scoreMenu = [[HighScoreViewController alloc] initWithNibName:@"HighScoreViewController" bundle:nil];
	
	optionMenu = [[Options alloc] initWithNibName:@"Options" bundle:nil];
	
	difficultyMenu = [[Difficulty alloc] initWithNibName:@"Difficulty" bundle:nil];
	
	gameOverMenu = [[GameOver alloc] initWithNibName:@"GameOver" bundle:nil];
	
	gameModeMenu = [[GameModeViewController alloc] initWithNibName:@"GameModeViewController" bundle:nil];
	
	fieldModeMenu = [[FieldModeViewController alloc] initWithNibName:@"FieldModeViewController" bundle:nil];
	
	fullWallGame = [[Snake_3ViewController alloc] initWithNibName:@"Snake_3ViewController" bundle:nil];
	
	holeWallGame = [[Snake_3ViewController alloc] initWithNibName:@"Snake_3ViewController" bundle:nil];
	
	squareWallGame = [[Snake_3ViewController alloc] initWithNibName:@"Snake_3ViewController" bundle:nil];
	
	storeView = [[StoreViewController alloc] initWithNibName:@"StoreViewController" bundle:nil];
	
	useCreditsView = [[UseCreditsViewController alloc] initWithNibName:@"UseCreditsViewController" bundle:nil];
	
	unlockView = [[UnlockViewController alloc] initWithNibName:@"UnlockViewController" bundle:nil];
	
	earnView = [[EarnCreditsViewController alloc] initWithNibName:@"EarnCreditsViewController" bundle:nil];
	helpPage = [[HelpPageViewController alloc]initWithNibName:@"HelpPageViewController" bundle:nil];
	helpDetail = [[helpDetailViewController alloc] initWithNibName:@"helpDetailViewController" bundle:nil];
	
    
//    [FlurryAppCircle setAppCircleEnabled:YES];
//    [FlurryClips setVideoAdsEnabled:YES];
//    [FlurryClips setVideoDelegate:self];
//    [FlurryAppCircle setAppCircleDelegate:self];
//    [FlurryAnalytics startSession:@"9VIC9CUSJ9PN1RB212BA"];

	
// If the user has the unlocked version we give him all the features unlocked.
#ifndef LITE_VERSION
    
	holeUnlocked = YES;
	squareUnlocked = YES;
	nightUnlocked = YES;
	beachUnlocked = YES;
	gardenUnlocked = YES;
#endif

		

if ([self connectedToNetwork]) {
	isconnected = YES;
	
#ifdef LITE_VERSION
	NSString * udid = [[UIDevice currentDevice] uniqueIdentifier];
	
	NSString *urlString = [NSString stringWithFormat:@"http://zingapps.co/get_balance_2.php?udid=%@",udid];
	
	
	
	//NSError *error;
	//NSString *connected = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSASCIIStringEncoding error:&error ];
	
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setTimeoutInterval:15];
    [request setURL:[NSURL URLWithString:urlString]];
    
    NSData *responseDataSerial = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSString *connected = [[NSString alloc] initWithData:responseDataSerial encoding:NSUTF8StringEncoding];
    
    //NSLog(@"response string: %@", connected);
    
    
    
	
	if (connected == NULL) {
		
		
		isconnected = NO;
		
	} else if([connected isEqualToString:@"No Records found"]){
		
		isconnected = YES;
		totalbalance = 0;
		userBalance = 0;
		
		
	}
	else{
		
		
		isconnected = YES;
		
		totalbalance = [connected intValue];
		
		
		userBalance = totalbalance - (holeUnlocked * 30) - (squareUnlocked *30)
		- (beachUnlocked *20) - (gardenUnlocked *20) - (nightUnlocked *20);
		
		if(userBalance < 0){
			
			userBalance = 0;
		}
		
		
		
		
		
	}
	
	NSString *urlString_2 = [NSString stringWithFormat:@"http://zingapps.us/take_over_blue.php"];
	
	
	

	//NSString *connected_take = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString_2] encoding:NSASCIIStringEncoding error:&error ];
	
	int take;
	
    
    NSMutableURLRequest *request_2 = [[NSMutableURLRequest alloc] init];
    
    [request_2 setTimeoutInterval:15];
    [request_2 setURL:[NSURL URLWithString:urlString_2]];
    
    NSData *responseDataSerial_2 = [NSURLConnection sendSynchronousRequest:request_2 returningResponse:nil error:nil];
    
    NSString *connected_take = [[NSString alloc] initWithData:responseDataSerial_2 encoding:NSUTF8StringEncoding];
    
    //NSLog(@"response string: %@", connected);

	
	
	
	if (connected_take == NULL) {
		

		
	} else {
	
		take = [connected_take intValue];
		if (take == 0 ) {
			take_over = 0;
			take_over_menu = 0;
			take_count = 0;
			//[self showAlert];
			
		}
		else if(take > 0){
		
			take_over = 1;
			take_count += 1;
			if (take_count <= 3) {
				take_over_menu = 1;
			}
			
		}
		
		
		
		
	}
#endif
}
	else {
		isconnected = 0;
	}

	
	
	main_menu *aMenu = [[main_menu alloc] initWithNibName:@"main_menu" bundle:nil];
	self.mainmenu = aMenu;
	
	[window addSubview:mainmenu.view];
	
	
	[aMenu release];
	
	
	
	return YES;
}


- (void) loadAchievements
{
    if (GCTest) {
    
        [GKAchievement loadAchievementsWithCompletionHandler:^(NSArray *achievements, NSError *error)
         {
             if (error == nil)
             {
                 
                 for (GKAchievement* achievement in achievements)
                     [achievementsDictionary setObject: achievement forKey: achievement.identifier];
             }
		 
             //NSLog(@"acheivement ERROR : %@",error);
         }];
	
        //NSLog(@"all acheivements : %@", achievementsDictionary);
    }
}


- (GKAchievement*) getAchievementForIdentifier: (NSString*) identifier
{
    GKAchievement *achievement = [achievementsDictionary objectForKey:identifier];
    if (achievement == nil)
    {
        achievement = [[[GKAchievement alloc] initWithIdentifier:identifier] autorelease];
        [achievementsDictionary setObject:achievement forKey:achievement.identifier];
    }
    return [[achievement retain] autorelease];
}


- (void) reportAchievementIdentifier: (NSString*) identifier percentComplete: (float) percent
{
    GKAchievement *achievement = [self getAchievementForIdentifier:identifier];
    if (achievement)
    {
		achievement.percentComplete = percent;
		[achievement reportAchievementWithCompletionHandler:^(NSError *error)
		 {
			 if (error != nil)
			 {
				 // Retain the achievement object and try again later (not shown).
                 [achievementsToSubmit addObject:identifier];
			 }
		 }];
    }
}

-(void) clearAchievements{
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	delegate.maxOpen = NO;
	delegate.maxBox = NO;
	delegate.maxHole = NO;
	delegate.maxSquare = NO;
	// Clear all locally saved achievement objects.
    achievementsDictionary = [[NSMutableDictionary alloc] init];
	// Clear all progress saved on Game Center
	[GKAchievement resetAchievementsWithCompletionHandler:^(NSError *error)
	 {
		
			 }];
	
	
	
	
}

-(void) showAlert{
	

	[mainmenu showAlert_2];
	
	
}
-(void) insertToken{
	
	
	if(isconnected){
		
		NSString * udid = [[UIDevice currentDevice] uniqueIdentifier];
		NSString * secret = @"Qwdfty13";
		
		
		//theName = [theName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
		//gameMode = [gameMode stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
		
		
		device_Token = [device_Token stringByReplacingOccurrencesOfString:@"<" withString:@""];
		device_Token = [device_Token stringByReplacingOccurrencesOfString:@">" withString:@""];
		
		device_Token = [device_Token stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
		
		NSString *urlString = [NSString stringWithFormat:@"http://zingapps.us/put_token.php?secret=%@&udid=%@&token=%@",
							   secret,udid,device_Token];
		

		NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        
		
		
		NSError * e;
		NSData	     *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&e];
		

		
		//return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
		
		
		
	}
	
}

/* method to display food layers*/

-(void) displayLayer:(CALayer *)layer {
	
	
	
	if (layer == activeGame.currentView.foodLayer) {
		[self drawFood:layer];
	}
	else if(layer == activeGame.currentView.bonusFoodLayer){
	
		[self drawBonusFood:layer];
	}
	
	
	
}

/*method to show normal food*/

- (void)drawFood:(CALayer *)layer{
	
	[CATransaction begin]; 
	[CATransaction setValue: (id) kCFBooleanTrue forKey: kCATransactionDisableActions];

	
	layer.position = CGPointMake(activeGame.currentView.food.food_x + 2.5, activeGame.currentView.food.food_y + 2.5);
	
	[CATransaction commit];
	
	

	
}

/*method to show bonus food*/

- (void)drawBonusFood:(CALayer *)layer{
	
	[CATransaction begin]; 
	[CATransaction setValue: (id) kCFBooleanTrue forKey: kCATransactionDisableActions];


	layer.position = CGPointMake(activeGame.currentView.food.bonus_food_x + 2.5 , activeGame.currentView.food.bonus_food_y + 2.5);
	
	[CATransaction commit];
	
}


			
/**
 * Example of facebook login and permission request
 */
- (void) login {
	[facebook authorize:kFBAppId permissions:permissions delegate:self];
	
}

/**
 * Example of facebook logout
 */
- (void) logout {
	[facebook logout:self]; 
	[_session unsave];
}
	



-(void) fbDidLogin {
	FBLoggedIn = YES;
	
	_userInfo = [[[[UserInfo alloc] initializeWithFacebook:facebook andDelegate: self] 
				  autorelease] 
				 retain];
	[_userInfo requestAllInfo];
	
	if (loginFromScore == YES) {
		loginFromScore = NO;
		
		scoreMenu.isLocal= NO;
		scoreMenu.isGlobal=NO;
		scoreMenu.isFriends = YES;
	
		
		//[scoreMenu getFriendInfo];
		[scoreMenu saveTheGame];
	}
	
	
	if (loginFromOver == YES) {
		[gameOverMenu publishFacebook];
	}
	
	[optionMenu updateFBButton];
}
			

-(void) fbDidLogout {
	[_session unsave];
	FBLoggedIn = NO;
	[optionMenu updateFBButton];
	
	
}
/* This method is used to switch views:
 
 paramters:
view1: The view to sitch from
toview: the view to siwtch to
delay: if you want a delay between swtiching the views.
doRemove: if you want to remove the first view. If not view2 is added over view 1
 curlup: if the transition should be curl up
 curldown: if the transition should be curl down
 */


-(void)switchView:(UIView *)view1 toview:(UIView *)view2 delay:(BOOL)doDelay 
		   remove:(BOOL)doRemove display:(CADisplayLink *)link curlup:(BOOL)curlUp curldown:(BOOL)curlDown{
	
	
/*	CGRect frame = view2.frame;
	frame.origin = window.frame.origin;
	frame.origin.y += 20;
	view2.frame = frame;*/
	if (doRemove == YES) {
		
		[view1 removeFromSuperview];
		
		
		
	}
	
	if (doRemove == NO) {
		self.displayLink = link;
	}
	
	
	[UIView	 beginAnimations:@"Animation" context:nil];
	if (doDelay == YES) {
		[UIView setAnimationDelay:0.5];
	}
	
	
	
	[UIView	setAnimationDuration:0.5];
	
	if (curlUp == YES) {
		[UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.window cache:YES];
	}
	else if (curlDown == YES){
		
		[UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.window cache:YES];
	}
	else {
		[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.window cache:YES];
	}


	
	
	
	[window addSubview:view2];
	
	
	
	[UIView commitAnimations];	
	
	
	
}




- (void)applicationWillResignActive:(UIApplication *)application {
	

	// If the game is active (i.e currently being played), pause the game and load the main menu screen
	
	if (gameStatus == kGameActive) {
		
		//gameStatus = kGamePause;
		

		
		//self.resumeMenu = mainmenu;
	
		
		//[window addSubview:self.mainmenu.view];
		
		
		[activeGame pauseGameNow];
		
	}
	
	
	
	
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
   
	// Not being used since we have disabled multi tasking and the app will terminate instead
}



- (void)applicationWillEnterForeground:(UIApplication *)application {
		
	
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
	}


/**
 applicationWillTerminate: saves changes in the application's managed object context before the application terminates.
 */
- (void)applicationWillTerminate:(UIApplication *)application {
    
	if (gameStatus == kGameOver) {
		[gameOverMenu saveGame];
	}
	
	if (gameStatus == kGameActive) {
		gameStatus = kGamePause;
	}
	
	
	
	
	int start = 0;
	int active = 1;
	int pause = 2;
	int over = 3;
	
	
	NSNumber *balace = [NSNumber numberWithInt:userBalance];
	
	NSNumber *status = [NSNumber numberWithInt:0];
	
	if (gameStatus == kGamePause) {
		status = [NSNumber numberWithInt:pause];
	}
	else if (gameStatus == kGameOver) {
		status = [NSNumber numberWithInt:over];
	}
	else if (gameStatus == kGameActive) {
		status = [NSNumber numberWithInt:active];
	}
	else if (gameStatus == kGameStart) {
		status = [NSNumber numberWithInt:start];
	}
	
	int color =0 ;
	
	if (snakeColor == [UIColor orangeColor]) {
		color = 0;
	}
	else if (snakeColor == [UIColor blueColor]) {
		color = 1;
	}
	else if (snakeColor == [UIColor greenColor]) {
		color = 2;
	}
	else if (snakeColor == [UIColor blackColor]) {
		color = 3;
	}	
	
	
	NSNumber *score = [NSNumber numberWithInt:delegateScore];
	NSNumber *numberFood = [NSNumber numberWithInt:foodNumber];
	NSNumber *bonusNumberFood = [NSNumber numberWithInt:bonusFoodNumber];
	
	NSNumber *extremeOver = [NSNumber numberWithInt:extremeSuccess];
	NSNumber *extremeMissed = [NSNumber numberWithInt:missedInExtreme];
	

	NSNumber *snakeSpeed = [NSNumber numberWithInt:speed];
	
	NSNumber *headOfSnake_X = [NSNumber numberWithFloat:snakeHeadX];
	NSNumber *headOfSnake_Y = [NSNumber numberWithFloat:snakeHeadY];
	
	NSNumber *tailofSnake_X = [NSNumber numberWithFloat:snakeTailX];
	NSNumber *tailofSnake_Y = [NSNumber numberWithFloat:snakeTailY];
	
	NSNumber *headDirectionSnake = [NSNumber numberWithInt:snakeHeadDirection];
	NSNumber *tailDirectionSnake = [NSNumber numberWithInt:snakeTailDirection];
	
	NSNumber *colorOfSnake = [NSNumber numberWithInt:color];
	
	NSNumber *foodX = [NSNumber numberWithFloat:snakeFoodX];
	NSNumber *foodY = [NSNumber numberWithFloat:snakeFoodY];	
	
	
	
	NSNumber *modeofgame = [NSNumber numberWithInt:gameMode];
	
	NSNumber *modeoffield = [NSNumber numberWithInt:fieldMode];
	
	NSNumber *themeMode = [NSNumber numberWithInt:theme];
	
	NSNumber *savetime = [NSNumber numberWithInt:time];
	NSNumber *takeCount = [NSNumber numberWithInt:take_count];
	
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	[defaults setObject:takeCount forKey:@"TakeOverCount"];
	
	[defaults setObject:modeofgame forKey:@"GameMode"];
	[defaults setObject:modeoffield forKey:@"FieldMode"];
	[defaults setObject:savetime forKey:@"time"];
	
	[defaults setObject:themeMode forKey:@"Theme"];
	
	
	[defaults setObject:headOfSnake_X forKey:@"SnakeHeadX"];
	[defaults setObject:headOfSnake_Y forKey:@"SnakeHeadY"];
	
	[defaults setObject:tailofSnake_X forKey:@"SnakeTailX"];
	[defaults setObject:tailofSnake_Y forKey:@"SnakeTailY"];
	
	[defaults setObject:headDirectionSnake forKey:@"SnakeHeadDirection"];
	[defaults setObject:tailDirectionSnake forKey:@"SnakeTailDirection"];
	
	[defaults setObject:snakeBends forKey:@"SnakeBends1"];
	[defaults setObject:snakeBendDirection forKey:@"SnakeBendDirection1"];
	
	[defaults setObject:foodX forKey:@"FoodX"];
	[defaults setObject:foodY forKey:@"FoodY"];	
	
	
	[defaults setObject:colorOfSnake forKey:@"Color"];
	[defaults setObject:status forKey:@"Status"];
	[defaults setObject:score forKey:@"Score"];
	[defaults setObject:snakeSpeed forKey:@"SnakeSpeed"];	
	
	[defaults setObject:playerName forKey:@"PlayerName"];
	
	[defaults setBool:isWallOn forKey:@"WallOn"];
	[defaults setBool:isVibrateOn forKey:@"VibrateOn"];
	[defaults setBool:isSoundOn forKey:@"SoundOn"];
	
	
	[defaults setBool:holeUnlocked forKey:@"HoleUnlocked"];
	[defaults setBool:squareUnlocked forKey:@"SquareUnlocked"];
	[defaults setBool:gardenUnlocked forKey:@"GardenUnlocked"];
	[defaults setBool:beachUnlocked forKey:@"BeachUnlocked"];
	[defaults setBool:nightUnlocked forKey:@"NightUnlocked"];
	
	[defaults setBool:maxOpen forKey:@"MaxOpenScore"];
	[defaults setBool:maxBox forKey:@"MaxBoxScore"];
	[defaults setBool:maxHole forKey:@"MaxHoleScore"];
	[defaults setBool:maxSquare forKey:@"MaxSquareScore"];

	
	[defaults setBool:inTransition forKey:@"InTransition"];
	
	[defaults setBool:morethanOnce forKey:@"FirstTime"];
	 
	
	[defaults setObject:numberFood forKey:@"FoodNumber"];
	[defaults setObject:bonusNumberFood forKey:@"BonusFoodNumber"];
	[defaults setObject:extremeOver forKey:@"ExtremeSuccess"];
	[defaults setObject:extremeMissed forKey:@"ExtremeMissed"];
	
	
	
	[defaults setObject:balace forKey:@"Balance"];
    
    [defaults setObject:achievementsToSubmit forKey:@"Tobesubmitted"];
	
	[defaults synchronize];
	
	
	
    NSError *error = nil;
    if (managedObjectContext_ != nil) {
        if ([managedObjectContext_ hasChanges] && ![managedObjectContext_ save:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            //NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

-(void)unlockFBAchievement{
    
    if(self.GCTest){
	
	GKAchievement *achievement = [self getAchievementForIdentifier:@"Facebook_Publish"];
	
	if ( achievement.percentComplete < 100.0 && GCConnected) {
		
		[self reportAchievementIdentifier:@"Facebook_Publish" percentComplete:100];
		
		[[GKAchievementHandler defaultHandler] notifyAchievementTitle:@"Facebook Connector" andMessage:@"Congratulations!"];		
	}
	
	}
	
}


#pragma mark -
#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext {
    
    if (managedObjectContext_ != nil) {
        return managedObjectContext_;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext_ = [[NSManagedObjectContext alloc] init];
        [managedObjectContext_ setPersistentStoreCoordinator:coordinator];
    }
    return managedObjectContext_;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel {
    
    if (managedObjectModel_ != nil) {
        return managedObjectModel_;
    }
    NSString *modelPath = [[NSBundle mainBundle] pathForResource:@"SnakeClassic" ofType:@"momd"];
    NSURL *modelURL = [NSURL fileURLWithPath:modelPath];
    managedObjectModel_ = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    
    return managedObjectModel_;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (persistentStoreCoordinator_ != nil) {
        return persistentStoreCoordinator_;
    }
    
    NSURL *storeURL = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"SnakeClassic.sqlite"]];
    
    NSError *error = nil;
    persistentStoreCoordinator_ = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator_ addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        
        //NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return persistentStoreCoordinator_;
}


- (void)userInfoDidLoad {
	[_session setSessionWithFacebook:facebook andUid:_userInfo.uid];
	[_session save];
	
	
}

- (void)userInfoFailToLoad {
	[self logout]; 
	FBLoggedIn = NO;
	
}

- (void) authenticateLocalPlayer
{
    if (GCTest) {
    
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    [localPlayer authenticateWithCompletionHandler:^(NSError *error) {
		if (localPlayer.isAuthenticated)
		{
            //NSLog(@"count : %d", [achievementsToSubmit count]);
            
            int submitcount = [achievementsToSubmit count];
            
			for (int i = 0; i< submitcount; i++) {
                [self reportAchievementIdentifier:[achievementsToSubmit objectAtIndex:0] percentComplete:100];
                [achievementsToSubmit removeObjectAtIndex:0];
            }
            
			[self loadAchievements];
			GCConnected = YES;

		}
        else{
            //NSLog(@"DID NOT SIGN IN");
            GCConnected = NO;
        }
	}];
    }
}


-(BOOL) isGameCenterAPIAvailable
{
    // Check for presence of GKLocalPlayer class.
    BOOL localPlayerClassAvailable = (NSClassFromString(@"GKLocalPlayer")) != nil;
    
    // The device must be running iOS 4.1 or later.
    NSString *reqSysVer = @"4.1";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    BOOL osVersionSupported = ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending);
    
    return (localPlayerClassAvailable && osVersionSupported);
}


#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the path to the application's Documents directory.
 */
- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    
    [managedObjectContext_ release];
    [managedObjectModel_ release];
    [persistentStoreCoordinator_ release];
	
	
	[player release];
	[bonusfoodplayer release];
    
    [window release];
	
	[scoreMenu release];
	[difficultyMenu release];
	[optionMenu release];
	[gameOverMenu release];
	
	[mainmenu release];
	
	[resumeMenu release];
	
	[activeGame release];
	[snakeColor release];
	[snakeBends release];
	[snakeBendDirection release];
	[playerName release];
	
	
	[_userInfo release];

	
	[globalScores release];
	
	[facebook release];
	
	[gameModeMenu release];
	
	[fieldModeMenu release];
	
	
	[fullWallGame release];
	
	[holeWallGame release];
	
	[squareWallGame release];
	
	[storeView release];
	
	[unlockView release];
	
	[earnView release];
	
	
	[useCreditsView release];
	
	[helpPage release];

	[helpDetail release];
	
	[achievementsDictionary release];
	
	
    [super dealloc];
}


@end

