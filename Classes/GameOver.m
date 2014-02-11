//
//  GameOver.m
//  
//  Created by Swapan Rajdev on 8/19/10.
//  Copyright 2010 Zing! Apps. All rights reserved.
//
//  Description: This view controller shows handles the game over screen (i.e whent he snake dies)
//  It displays the score of the game, highest score scored on the device so far,
//  Name of the player which can be changed, and options for the user to choose (play again or go to Menu)
//
//
//  Update V1.1: Added functionality to submit high score to the global leaderboard
//  Updats V2: changed functionality to save the scores only locally. Saving of global scores is now done 
//				in the highscore view controller


#import "GameOver.h"
#import "SnakeClassicAppDelegate.h"
#import "main_menu.h"
#import "HighScores.h"
#import "HighScoreRecord.h"
#import "Difficulty.h"
#import "GKAchievementHandler.h"
#import "FlurryAdDelegate.h"
#import "FlurryAds.h"
#import "Flurry.h"
#import "TSTapstream.h"



#define kOAuthConsumerKey				@"qbOcFT2SmkVJ5JKNLpq1jg"		//REPLACE ME
#define kOAuthConsumerSecret			@"W3zanQvRhXx1rT9rsOJqlpIrwu1slvUbVabB4c2wDc"		//REPLACE ME

@implementation GameOver


@synthesize name;
@synthesize score;

@synthesize changeName;
@synthesize highestScore;


@synthesize highScore;

@synthesize FBName;
@synthesize FBid;
@synthesize isTwitterLogged;
@synthesize fbSaveCount;
@synthesize mainMenu;
@synthesize playAgain;
@synthesize rateAppButton;
@synthesize FBButton;
@synthesize TwtButton;
@synthesize gameOver;
@synthesize account;
@synthesize mainMenuButton;
@synthesize playAgainButton; 


static NSString* kFBAppId = @"158392174179755";


//Function to return the AdWhirl Key

-(NSString *)adWhirlApplicationKey{
	
	return kSampleAppKey;
	
	
	
}


- (UIViewController *)viewControllerForPresentingModalView {
	return self;
	
}

NSString *adSpaceName = @"INTERSTITIAL_MAIN_VIEW";


-(void)setBackground{
    
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (delegate.theme == kClassicTheme) {
		if(IS_IPHONE_5){
            [background setFrame:CGRectMake(0, 0, 320, 568)];
            background.image = [UIImage imageNamed:@"end_game_classic.png"];
        }
        else{
            background.image = [UIImage imageNamed:@"end game_classic.png"];
        }
	}
	else if(delegate.theme == kTheme1){
		if(IS_IPHONE_5){
            [background setFrame:CGRectMake(0, 0, 320, 568)];
            background.image = [UIImage imageNamed:@"end_game_garden.png"];
        }
        else{
            background.image = [UIImage imageNamed:@"end game_garden.png"];
        }
	}
	else if(delegate.theme == kTheme2){
		if(IS_IPHONE_5){
            [background setFrame:CGRectMake(0, 0, 320, 568)];
            background.image = [UIImage imageNamed:@"end_game_beach.png"];
        }
        else{
            background.image = [UIImage imageNamed:@"end game_beach.png"];
        }
	}
	else if(delegate.theme == kTheme3){
		score.textColor = [UIColor colorWithRed:1 green:0.56 blue:0 alpha:1];
		highestScore.textColor = [UIColor colorWithRed:1 green:0.56 blue:0 alpha:1];
		
		if(IS_IPHONE_5){
            [background setFrame:CGRectMake(0, 0, 320, 568)];
            background.image = [UIImage imageNamed:@"end_game_night.png"];
        }
        else{
            background.image = [UIImage imageNamed:@"end game_night.png"];
        }
	}

}

-(void) viewDidLoad{
    
    [self setBackground];
    if(IS_IPHONE_5){
        
        [gameOver setFrame:CGRectMake(69, 55, 182, 42)];
        gameOver.image = [UIImage imageNamed:@"_0000_game-over!.png"];
        
        CGRect btScoreFrame = score.frame;
        btScoreFrame.origin.x = ENDGAME_BUTTON_X;
        btScoreFrame.origin.y = ENDGAME_BUTTON_Y;
        score.frame = btScoreFrame;
        
        CGRect bthighScoreFrame = highestScore.frame;
        bthighScoreFrame.origin.x = ENDGAME_BUTTON_X;
        bthighScoreFrame.origin.y = 40 + ENDGAME_BUTTON_Y;
        highestScore.frame = bthighScoreFrame;
        
        CGRect btNameFrame = name.frame;
        btNameFrame.origin.x = ENDGAME_BUTTON_X;
        btNameFrame.origin.y = 67 + ENDGAME_BUTTON_Y;
        name.frame = btNameFrame;
        
        CGRect btchangeNameFrame = changeName.frame;
        btchangeNameFrame.origin.x = ENDGAME_BUTTON_X;
        btchangeNameFrame.origin.y = 67 + ENDGAME_BUTTON_Y;
        changeName.frame = btchangeNameFrame;
        
        CGRect btfbFrame = FBButton.frame;
        btfbFrame.origin.x = 102;
        btfbFrame.origin.y = 170 + ENDGAME_BUTTON_Y;
        FBButton.frame = btfbFrame;
        
        CGRect bttwFrame = TwtButton.frame;
        bttwFrame.origin.x = 175;
        bttwFrame.origin.y = 170 + ENDGAME_BUTTON_Y;
        TwtButton.frame = bttwFrame;
        
        CGRect btplayFrame = playAgain.frame;
        btplayFrame.origin.x = 79;
        btplayFrame.origin.y = 210 + ENDGAME_BUTTON_Y;
        playAgain.frame = btplayFrame;
        
        CGRect btmenuFrame = mainMenu.frame;
        btmenuFrame.origin.x = 102;
        btmenuFrame.origin.y = 260 + ENDGAME_BUTTON_Y;
        mainMenu.frame = btmenuFrame;
        
        CGRect btrateFrame = rateAppButton.frame;
        btrateFrame.origin.x = 242;
        btrateFrame.origin.y = 50 + 381;
        rateAppButton.frame = btrateFrame;
        
        
    }
	//[GSAdEngine setFullScreenDelegate:self forSlotNamed:@"fullscreenSlot"];
    
    
    //[FlurryClips setVideoDelegate:self];
	
	
	
}

// Make sure all the score and names are shown as current every time the view appears
-(void) viewWillAppear:(BOOL)animated{
	
	

	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
    [self setBackground];
    [FlurryAds initialize:self];
	[FlurryAds setAdDelegate:self];
    
    playAgainButton = false;
    mainMenuButton = false;
    
	if(IS_IPHONE_5){
        //cretate a UIView to hold the Flurry banner ad, with desired position and size
        UIView *flurryContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 518, self.view.frame.size.width, 50)];
        
        [self.view addSubview:flurryContainer];
        //fetch the ad with the newly created UIView
        [FlurryAds fetchAndDisplayAdForSpace:@"BANNER_MAIN_VIEW" view:flurryContainer size:BANNER_BOTTOM];
    }
    else{
        [FlurryAds fetchAndDisplayAdForSpace:@"BANNER_MAIN_VIEW" view:self.view size:BANNER_BOTTOM];
	}
	
    [FlurryAds fetchAdForSpace:adSpaceName frame:self.view.frame size:FULLSCREEN];
	
	if (delegate.gameMode == kClassicMode && delegate.fieldMode == kNoWall && delegate.delegateScore >= 10000) {
		delegate.maxOpen = YES;
	}
	
	
	if (delegate.gameMode == kClassicMode && delegate.fieldMode == kFullWall && delegate.delegateScore >= 10000) {
		delegate.maxBox = YES;
	}
	
	
	if (delegate.gameMode == kClassicMode && delegate.fieldMode == kHoleWall && delegate.delegateScore >= 10000) {
		delegate.maxHole = YES;
	}
	
	
	if (delegate.gameMode == kClassicMode && delegate.fieldMode == kSquareWall && delegate.delegateScore >= 10000) {
		delegate.maxSquare = YES;
	}
	
	score.textColor = [UIColor whiteColor];
	highestScore.textColor = [UIColor whiteColor];

    	[[UIApplication sharedApplication] setStatusBarHidden: YES];
	
	if (delegate.FBLoggedIn == YES) {
		
		
	}
	else {
		fbSaveCount = 0;
	}

	
	NSArray *highScoreData = [[HighScores getLocalHighScores] retain];
	
	
	

	
	// If there are high scores, compare if current score is greater than the higest score
	// If it is greater show high score as current score, else show highest score
	if (highScoreData.count >= 1) {
		
			HighScoreRecord *record1 = (HighScoreRecord *)[highScoreData objectAtIndex:0];
		
			if (delegate.delegateScore > [record1.totalScore intValue]) {
				highestScore.text = [NSString stringWithFormat:@"%d",delegate.delegateScore];
			}
		else {
			highestScore.text = [NSString stringWithFormat:@"%@",record1.totalScore];
		}

			
	}
	else {

		
		highestScore.text = [NSString stringWithFormat:@"%d",delegate.delegateScore];
	}


	[name setTitle:delegate.playerName forState:UIControlStateNormal];

	score.text = [NSString stringWithFormat:@"%d",delegate.delegateScore];
	
	changeName.hidden = YES;
	
	[highScoreData release];
	
#ifdef LITE_VERSION
    // Code specific to lite version

	
//	[adView doNotIgnoreNewAdRequests];
//	[adView doNotIgnoreAutoRefreshTimer];
	
	//adView = [AdWhirlView requestAdWhirlViewWithDelegate:self];
/*	adView = delegate.mainmenu.adView;
	if(IS_IPHONE_5){
        
        UadViewframe = CGRectMake(0.0, 520.0, 320.0, 50.0);
        
    }
    else{
	adView.frame = CGRectMake(0.0, 432.0, 320.0, 50.0);
	}
*/
 #endif

	[super viewDidLoad];
	
#ifdef LITE_VERSION
    // Code specific to lite version

	
	//[self.view addSubview:adView];
#endif
	
	if (delegate.GCTest) {
     
	GKAchievement *achievement = [delegate getAchievementForIdentifier:@"Allrounder"];
	
	if (achievement.percentComplete < 100.0 && delegate.maxOpen == YES && delegate.maxBox == YES && delegate.maxHole == YES && delegate.maxSquare == YES && delegate.GCConnected) {
		
		[delegate reportAchievementIdentifier:@"Allrounder" percentComplete:100];
		
		[NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(showAchievementExtreme:) userInfo:nil repeats:NO];
	}
	
	if (delegate.extremeSuccess == 1) {
		

		 [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(showAchievement:) userInfo:nil repeats:NO];
		
	}
	}

	
}

-(void) showAchievementExtreme:(NSTimer *)theTimer{
    
	  
    [[GKAchievementHandler defaultHandler] notifyAchievementTitle:@"All Star" andMessage:@"Congratulations!"];	

	
}

-(void) showAchievement:(NSTimer *)theTimer{
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	GKAchievement *achievement = [delegate getAchievementForIdentifier:@"Super_Extreme_Snake"];
	
	GKAchievement *achievement_2 = [delegate getAchievementForIdentifier:@"Extreme_Snake"];
	
	
	if (achievement.percentComplete < 100.0 && delegate.missedInExtreme == 0 && delegate.GCConnected) {
		
		[delegate reportAchievementIdentifier:@"Super_Extreme_Snake" percentComplete:100];
		[[GKAchievementHandler defaultHandler] notifyAchievementTitle:@"Super Extreme Snake" andMessage:@"Congratulations!"];	
	}
	else if (achievement_2.percentComplete < 100.0 && delegate.GCConnected){
		
		[delegate reportAchievementIdentifier:@"Extreme_Snake" percentComplete:100];
		[[GKAchievementHandler defaultHandler] notifyAchievementTitle:@"Extreme Snake" andMessage:@"Congratulations!"];	
	}
	
}

- (void) viewDidDisappear:(BOOL)animated{

//	[adView ignoreNewAdRequests];
	
//	[adView ignoreAutoRefreshTimer];
[super viewDidDisappear:animated];
	    [FlurryAds removeAdFromSpace:@"BANNER_MAIN_VIEW"];
    [FlurryAds setAdDelegate:nil];
}

/*
- (void)adWhirlDidReceiveAd:(AdWhirlView *)adWhirlView {
	[UIView beginAnimations:@"AdResize" context:nil];
	[UIView setAnimationDuration:0.5];
	CGSize adSize = [adWhirlView actualAdSize];
	CGRect newFrame = adWhirlView.frame;
	newFrame.size.height = adSize.height; 
	newFrame.size.width = adSize.width;
	newFrame.origin.x = (self.view.bounds.size.width - adSize.width)/2;
	adWhirlView.frame = newFrame;
	
	[UIView commitAnimations];
} 
*/

// Action that is called to post to facebook

- (IBAction)postToFacebook:(id)sender {
    TSEvent *e = [TSEvent eventWithName:@"gameover_facebook" oneTimeOnly:NO];
    [[TSTapstream instance] fireEvent:e];
    
    SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	NSNumberFormatter *numberFormatter = [[[NSNumberFormatter alloc] init] autorelease];
	[numberFormatter setPositiveFormat:@"#,###"];
	
	NSNumber *abcd = [NSNumber numberWithInt:delegate.delegateScore];
	
        SLComposeViewController *controller2 = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    
    [controller2 setInitialText: [NSString stringWithFormat:@"I just scored %@ in SnakeClassic! Beat that!", [numberFormatter stringFromNumber:abcd]]];
    
        //[controller2 setInitialText:@"First post from my iPhone app"];
        [controller2 addURL:[NSURL URLWithString:@"https://itunes.apple.com/in/app/snake-classic/id394603141?mt=8"]];
        [controller2 addImage:[UIImage imageNamed:@"http://zingapps.co/FBlogo.png"]];
        
        [self presentViewController:controller2 animated:YES completion:Nil];
    
}

// Function that posts to facebook

-(void) publishFacebook{
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	

	
	
	
	NSNumberFormatter *numberFormatter = [[[NSNumberFormatter alloc] init] autorelease];
	[numberFormatter setPositiveFormat:@"#,###"];
	
	
	
	NSNumber *abcd = [NSNumber numberWithInt:delegate.delegateScore];
	
	
	
	SBJSON *jsonWriter = [[SBJSON new] autorelease];
	
	NSDictionary* actionLinks = [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys: 
														   @"Get Snake Classic",@"text",@"http://itunes.com/apps/snakeclassic",@"href", nil], nil];
	
	
	
	NSString *actionLinksStr = [jsonWriter stringWithObject:actionLinks];
	
	
	NSString *attachmentStr = [NSString stringWithFormat:@"{\"name\":\"I just scored %@ in Snake Classic!\",\"href\":\"http://itunes.com/apps/snakeclassic\",\"caption\":\"BEAT THAT! \",\"description\":\" \",\"media\":[{\"type\":\"image\",\"src\":\"http://zingapps.co/FBlogo.png\",\"href\":\"http://itunes.com/apps/snakeclassic\"}],\"properties\":{\"More Info\":{\"text\":\"Snake Classic for iPhone\",\"href\":\"http://itunes.com/apps/snakeclassic\"}}}", [numberFormatter stringFromNumber:abcd]];
	
	
	NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
								   kFBAppId, @"api_key",
								   @"Shout out!",  @"user_message_prompt",
								   @"http://ibiblio.org/Dave/Dr-Fun/logo-small.jpg", @"imageurl",
								   actionLinksStr, @"action_links",
								   attachmentStr, @"attachment",
								   nil];
	
	
	[delegate.facebook dialog: @"stream.publish"
			andParams: params
				  andDelegate:self];
		

	
}









// Action that takes place when the user wants to play again
// user is directed to the screen to select a speed and then start playing the game again

-(IBAction)playAgain:(id)sender{

    TSEvent *e = [TSEvent eventWithName:@"gameover_Play Again" oneTimeOnly:NO];
    [[TSTapstream instance] fireEvent:e];
    playAgainButton = true;
    SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
    //[FlurryAds fetchAdForSpace:adSpaceName frame:self.view.frame size:FULLSCREEN];
    if ([FlurryAds adReadyForSpace:adSpaceName]) {
        NSLog(@"ad is there");
        [FlurryAds displayAdForSpace:adSpaceName onView:self.view];
    } else {
        // Fetch an ad
        NSLog(@"NO AD");
        [FlurryAds fetchAdForSpace:adSpaceName frame:self.view.frame size:FULLSCREEN];
        [delegate switchView:self.view toview:delegate.gameModeMenu.view delay:NO remove:YES display:nil curlup:YES curldown:NO];
        //[FlurryAds fetchAndDisplayAdForSpace:adSpaceName view:self.view size:FULLSCREEN];
    }

	delegate.foodNumber = 0;
	delegate.bonusFoodNumber = 0;
	delegate.extremeSuccess = 0;
	delegate.missedInExtreme = 0;
	
    
    
	//delegate.gameStatus = kGameActive;
	
	delegate.gameStatus = kGameStart;
	
	[self saveGame];
    
    
    
/*	
#ifdef LITE_VERSION
	
	if ([GSAdEngine isAdReadyForSlotNamed:@"fullscreenSlot"] && delegate.delegateScore > 5000)
	{
		[GSAdEngine displayFullScreenAdForSlotNamed:@"fullscreenSlot"];
		
	}
#endif
*/
    
	
    /*if([FlurryClips videoAdIsAvailable:@"VIDEO_AUTOPLAY"] && delegate.delegateScore > 5000){
        
        [FlurryClips openVideoTakeover:@"VIDEO_AUTOPLAY" orientation:@"portrait" rewardImage:nil rewardMessage:nil userCookies:nil autoPlay:YES];
        
        
    }
     */
//	[delegate switchView:self.view toview:delegate.gameModeMenu.view delay:NO remove:YES display:nil curlup:YES curldown:NO];
	
	
}

- (BOOL) spaceShouldDisplay:(NSString*)adSpace interstitial:(BOOL)
interstitial {
    if (interstitial) {
        // Pause app state here
    }
    
    // Continue ad display
    return YES;
}

/*
 *  Resume app state when the interstitial is dismissed.
 */

- (void)spaceDidDismiss:(NSString *)adSpace interstitial:(BOOL)interstitial {
    if (interstitial) {
        SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
        
        if(playAgainButton){
        /*delegate.foodNumber = 0;
        delegate.bonusFoodNumber = 0;
        delegate.extremeSuccess = 0;
        delegate.missedInExtreme = 0;
        
        
        
        //delegate.gameStatus = kGameActive;
        
        delegate.gameStatus = kGameStart;
        
        [self saveGame];
        */
        [delegate switchView:self.view toview:delegate.gameModeMenu.view delay:NO remove:YES display:nil curlup:YES curldown:NO];
        }
        
        if(mainMenuButton){
            //delegate.gameStatus = kGameStart;
            
            //[self saveGame];

            [delegate switchView:self.view toview:delegate.mainmenu.view delay:NO remove:YES display:nil curlup:NO curldown:YES];
            
        }
    }
}


// If the user taps on the area of the screen where the name is displayed
// he can change the name. 
// This method is called to change the name of the player

-(IBAction)buttonToChangeName{
	
    TSEvent *e = [TSEvent eventWithName:@"gameover_change player name" oneTimeOnly:NO];
    [[TSTapstream instance] fireEvent:e];
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	name.hidden = YES;
	changeName.borderStyle = UITextBorderStyleNone;
	changeName.hidden = NO;
	changeName.placeholder = delegate.playerName;
	[changeName becomeFirstResponder];
	
}




//When "Done" is pressed change the name on the label to the name jsut entered
//if nothing is entered move go back to the name previously shown

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
	
	
	[textField resignFirstResponder];
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	name.hidden = NO;
	changeName.hidden = YES;
	
	if ([changeName.text length] != 0) {
	
		delegate.playerName = changeName.text;
	}
	[name setTitle:delegate.playerName forState:UIControlStateNormal];
	
	
	return NO;
}


// Action that takes the player back to the main menu

-(IBAction)mainmenu:(id)sender{
	
    TSEvent *e = [TSEvent eventWithName:@"gameover_mennu" oneTimeOnly:NO];
    [[TSTapstream instance] fireEvent:e];
    
    mainMenuButton = true;
    
      //[FlurryAds fetchAndDisplayAdForSpace:adSpaceName view:self.view size:FULLSCREEN];
    
    SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    delegate.gameStatus = kGameStart;
    
    [self saveGame];
    
    //[delegate switchView:self.view toview:delegate.mainmenu.view delay:NO remove:YES display:nil curlup:NO curldown:YES];
    
    
    if ([FlurryAds adReadyForSpace:adSpaceName]) {
        [FlurryAds displayAdForSpace:adSpaceName onView:self.view];
    } else {
        // Fetch an ad
        [FlurryAds fetchAdForSpace:adSpaceName frame:self.view.frame size:FULLSCREEN];
        [delegate switchView:self.view toview:delegate.mainmenu.view delay:NO remove:YES display:nil curlup:NO curldown:YES];
    }
	
	
	
/*	
#ifdef LITE_VERSION
	
	if ([GSAdEngine isAdReadyForSlotNamed:@"fullscreenSlot"] && delegate.delegateScore > 5000)
	{
		[GSAdEngine displayFullScreenAdForSlotNamed:@"fullscreenSlot"];
		
	}
	
#endif
*/
    
    /*
    if( [FlurryClips videoAdIsAvailable:@"VIDEO_AUTOPLAY"] && delegate.delegateScore > 5000){
        
        [FlurryClips openVideoTakeover:@"VIDEO_AUTOPLAY" orientation:@"portrait" rewardImage:nil rewardMessage:nil userCookies:nil autoPlay:YES];
    }
    */
	
	
	
}


// REMOVED...Moved to high score view controller

-(void) submitScore: (int) theScore theName:(NSString *)theName{
	
	
}

// Action that is calle to rate the app


-(IBAction) rateApp{
	
	
    TSEvent *e = [TSEvent eventWithName:@"gameover_rate" oneTimeOnly:NO];
    [[TSTapstream instance] fireEvent:e];
	
	// Send the user to the appropriate rate place depending on which version (LOCKED OR UNLOCKED)
#ifdef LITE_VERSION
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=394603141&onlyLatestVersion=false&type=Purple+Software"]];

#else
   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=403683533&onlyLatestVersion=false&type=Purple+Software"]];
#endif
	

}



// This method saves the current score of the player 
// It is called every time the player gets out of the game over screen.
// That is if the player pressed Play Again or Menu we save the score 

-(void)saveGame{
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	

	int saveScore = delegate.delegateScore;
	NSString *gameMode;
	
	if (delegate.gameMode == kClassicMode) {
		gameMode = [NSString stringWithFormat:@"C"];
	}
	else if(delegate.gameMode == kExtremeMode)
	{
		gameMode = [NSString stringWithFormat:@"E"];
	}
	
	highScore = [[HighScoreRecord alloc] initWithScore:delegate.playerName TotalScore:[NSNumber numberWithInt:saveScore] gameMode:gameMode];
	


	[HighScores addNewHighScore:highScore];
	
	
	
}

// This method gets the users facebook info


-(void) getUserInfo {
	
	/*SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];

	[delegate.facebook requestWithGraphPath:@"me" andDelegate:self];*/

	
}



/**
 * Called when a request returns and its response has been parsed into an object.
 * The resulting object may be a dictionary, an array, a string, or a number, depending
 * on thee format of the API response.
 */
- (void)request:(FBRequest*)request didLoad:(id)result {
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	

//	FBName = [result objectForKey:@"name"];
//	FBName = [FBName stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
	
	
//	FBid = [result objectForKey:@"id"];

	
	[self submitScore:delegate.delegateScore theName:delegate.playerName];
};

- (void)request:(FBRequest*)request didFailWithError:(NSError*)error{
	 SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	
	
	[self submitScore:delegate.delegateScore theName:delegate.playerName];
};

- (IBAction)postToTwitter:(id)sender {
    //NSLog(@"Enter posttotwitter");
    SLComposeViewController *tweetSheet;
    //if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    //{
    TSEvent *e = [TSEvent eventWithName:@"gamevoer_twitter" oneTimeOnly:NO];
    [[TSTapstream instance] fireEvent:e];
        tweetSheet = [[SLComposeViewController alloc] init];
        NSNumberFormatter *numberFormatter = [[[NSNumberFormatter alloc] init] autorelease];
        [numberFormatter setPositiveFormat:@"#,###"];
        
        SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
        NSNumber *abcd = [NSNumber numberWithInt:delegate.delegateScore];
        
        tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    [tweetSheet setInitialText: [NSString stringWithFormat:@"I scored %@ in #SnakeClassic! Beat that! http://bit.ly/1iRQnvC #iphone", [numberFormatter stringFromNumber:abcd]]];
        
        [self presentViewController:tweetSheet animated:YES completion:nil];
    //}
    /*else
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Sorry"
                                  message:@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup"
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
     */
    
}

// Action that is called to post on twitter
/*
-(IBAction) tweetIt{
	
	NSNumberFormatter *numberFormatter = [[[NSNumberFormatter alloc] init] autorelease];
	[numberFormatter setPositiveFormat:@"#,###"];
	
	
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	NSNumber *abcd = [NSNumber numberWithInt:delegate.delegateScore];
	
	//if (engine) return;
    
	//engine = [[SA_OAuthTwitterEngine alloc] initOAuthWithDelegate: self];
    //[engine requestRequestToken];
	//engine.consumerKey = kOAuthConsumerKey;
	//engine.consumerSecret = kOAuthConsumerSecret;
	
	controller = [SA_OAuthTwitterController controllerToEnterCredentialsWithTwitterEngine:engine delegate:self];
    
    
	if (controller) {
		
		//[[UIApplication sharedApplication] setStatusBarHidden: NO];
		
		[self presentModalViewController:controller animated:YES];

		
		
	}
	else{
		[engine sendUpdate: [NSString stringWithFormat: @"I scored %d in #SnakeClassic! Beat that! http://bit.ly/c26ZIw #iphone", [numberFormatter stringFromNumber:abcd] ]];
	}
	
	
	
	
}


//=============================================================================================================================
#pragma mark SA_OAuthTwitterEngineDelegate
- (void) storeCachedTwitterOAuthData: (NSString *) data forUsername: (NSString *) username {
	NSUserDefaults			*defaults = [NSUserDefaults standardUserDefaults];
	
	[defaults setObject: data forKey: @"authData"];
	[defaults synchronize];
}

- (NSString *) cachedTwitterOAuthDataForUsername: (NSString *) username {
	
	
	
	return [[NSUserDefaults standardUserDefaults] objectForKey: @"authData"];
}



//=============================================================================================================================
#pragma mark SA_OAuthTwitterControllerDelegate

- (void) OAuthTwitterController: (SA_OAuthTwitterController *) controller authenticatedWithUsername: (NSString *) username {
	//NSLog(@"Authenicated for %@", username);
	isTwitterLogged = YES;
}

- (void) OAuthTwitterControllerFailed: (SA_OAuthTwitterController *) controller {
	//NSLog(@"Authentication Failed!");
}

- (void) OAuthTwitterControllerCanceled: (SA_OAuthTwitterController *) controller {
	//NSLog(@"Authentication Canceled.");
		
}

//=============================================================================================================================
#pragma mark TwitterEngineDelegate
- (void) requestSucceeded: (NSString *) requestIdentifier {
	//NSLog(@"Request %@ succeeded", requestIdentifier);
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	if (delegate.GCTest) {
    
	
	GKAchievement *achievement = [delegate getAchievementForIdentifier:@"Twitter_Connector"];
	
	if (achievement.percentComplete < 100.0 && delegate.GCConnected) {

		[delegate reportAchievementIdentifier:@"Twitter_Connector" percentComplete:100];
		
		[[GKAchievementHandler defaultHandler] notifyAchievementTitle:@"Twitter Connector" andMessage:@"Congratulations!"];	
	}
    }
	
	
}
*/
- (void) requestFailed: (NSString *) requestIdentifier withError: (NSError *) error {
	//NSLog(@"Request %@ failed with error: %@", requestIdentifier, error);
}






/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[name release];
	[score release];
	[highestScore release];
	[changeName release];
	
	
	[FBid release];
	[FBName release];
	
	
    [super dealloc];
}


@end
