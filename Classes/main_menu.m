//  //NSLog
//  main_menu.m
//  MyGame

//
//  Created by Swapan Rajdev on 8/10/10.
//  Copyright 2010 Zing! Apps. All rights reserved.
//
//  Updater V2: added help page icon which takes user to help page.
//              In locked version we have Store icon which takes user to the store to earn credits
//				In unlocked veresion we still have more apps
//
//  Description: This View Controller is used to show the main menu of the game.
//                The main menu contains all the different buttons for the user.
//                New game: for the user to start a new game
//				  Resume: To resume an already exisitng game
//				  Score: To view local high scores
//				  More Apps: to view more apps
//				  Option: to change different options of the game

#import "main_menu.h"
#import "SnakeClassicAppDelegate.h"
#import "Difficulty.h"
#import "Snake_3ViewController.h"
#import "Options.h"
#import "HighScoreViewController.h"
#import "MMSDK.h"
#import "TSTapstream.h"
#import <CoreLocation/CoreLocation.h>



#define kiPhoneInlineDefaultZone @"3327876051"
#define kiPhoneInlineDefaultSecret @"5AC993C91380875B"
#define kiPadInlineDefaultZone @"0337178053"
#define kiPadInlineDefaultSecret @"F0B4E489B0CFC0BB"



@implementation main_menu

@synthesize newgamebutton;
@synthesize optionbutton;
@synthesize resumebutton;
@synthesize scoresbutton;
@synthesize storeButton;
@synthesize helpPressed;
@synthesize checkAchievementsButton;
@synthesize resumeTimer;

- (void) viewWillAppear:(BOOL)animated{
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];

	
	if (delegate.take_over_menu == 1) {
		[NSTimer scheduledTimerWithTimeInterval:0.6 target:self selector:@selector(showAlert:) userInfo:nil repeats:NO];
	}
	
	
	delegate.appLaunch = NO;
	
	delegate.comeFromResume = NO;
	
#ifdef LITE_VERSION
	storeButton.hidden = NO;
	moreButton.hidden = YES;
#else
    // Code specific to unlocked version
	storeButton.hidden = YES;
	moreButton.hidden = NO;
#endif
	
    
    [self setBackground];
    if (delegate.gameStatus == kGamePause || delegate.inTransition == YES) {
		resumebutton.enabled = YES;
	}
	else {
		resumebutton.enabled = NO;
	}
    
    self.adView = nil;
    self.adView = [[[MPAdView alloc] initWithAdUnitId:@"770bbd6ca49544bb80bf388fd6c08f61"
                                                 size:MOPUB_BANNER_SIZE] autorelease];
    self.adView.delegate = self;
    CGRect frame = self.adView.frame;
    CGSize size = [self.adView adContentViewSize];
    frame.origin.y = [[UIScreen mainScreen] applicationFrame].size.height - size.height;
    self.adView.frame = frame;
    [self.view addSubview:self.adView];
    [self.adView loadAd];
    
    [super viewWillAppear:animated];
	
}


// Function to get the AdWhirl Key

-(NSString *)adWhirlApplicationKey{
	return kSampleAppKey;
}

-(void) showAlert :(NSTimer *)theTimer{
	
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	delegate.take_over_menu = 0;
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Today Only!" message:@"Earn DOUBLE CREDITS when you download a recommended free app! Use the Credits to unlock fields and wallpapers! Hurry, offer ends tomorrow!" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Earn Credits",nil];
	
	[alert show];
	
	
	[theTimer invalidate];
	
	
	
}

-(void) showAlert_2 {
	
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	delegate.take_over_menu = 0;
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Only for today earn 60 credits instead of 30 when you download an app" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Download",nil];
	
	[alert show];
	
	
	
	
	
	
}



// Alert taking the user to download the Unlocked game
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	
	if (buttonIndex == 1){
		
		delegate.earn_from_menu = YES;
		
		[delegate switchView:self.view toview:delegate.earnView.view delay:NO remove:YES display:nil curlup:YES curldown:NO];
		
	}
}


#pragma mark - <MPAdViewDelegate>
- (UIViewController *)viewControllerForPresentingModalView {
    return self;
}



// Action that takes place when the new game button is pressed. takes the user to a screen to select different speeds
-(IBAction)newgame:(id)sender{

    TSEvent *e = [TSEvent eventWithName:@"menu_new game" oneTimeOnly:NO];
    [[TSTapstream instance] fireEvent:e];
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[delegate switchView:self.view toview:delegate.gameModeMenu.view delay:NO remove:YES display:nil curlup:YES curldown:NO];
	
	
}

// Action that takes place when the Options button is pressed. takes the user to the Options screen.


-(IBAction)options:(id)sender{
	
    TSEvent *e = [TSEvent eventWithName:@"menu_settings" oneTimeOnly:NO];
    [[TSTapstream instance] fireEvent:e];

	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	
	
	[delegate switchView:self.view toview:delegate.optionMenu.view delay:NO remove:YES display:nil curlup:YES curldown:NO];
	
		
}


// Action that takes place when the resume button is pressed. Resumes an already exisitng game

-(IBAction)resume:(id)sender{
	
    TSEvent *e = [TSEvent eventWithName:@"menu_resume" oneTimeOnly:NO];
    [[TSTapstream instance] fireEvent:e];
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	
	delegate.comeFromResume = YES;
	[UIView	 beginAnimations:@"Animation2" context:nil];
		
	
	[UIView	setAnimationDuration:0.3];
	[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:delegate.window cache:YES];

	[self.view removeFromSuperview];
	[UIView commitAnimations];
	
	resumeTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(loadResume:) userInfo:nil repeats:NO];
	
}

// A timer function which is called after a short duation for the user to be comfortable before actually starting the game.
// This way the user can see where the snake is and has a short duration to react.

-(void)loadResume:(NSTimer *)theTimer{
	
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	if (delegate.snakeColor == [UIColor orangeColor]) {
		delegate.activeGame.currentView.snakeColor = [UIColor colorWithRed:1 green:0.568 blue:0 alpha:1];
	}
	else if (delegate.snakeColor == [UIColor greenColor]){
		delegate.activeGame.currentView.snakeColor = [UIColor colorWithRed:0.219 green:0.654 blue:0 alpha:1];
		
		
	}
	else if (delegate.snakeColor == [UIColor blackColor]){
		delegate.activeGame.currentView.snakeColor = [[UIColor alloc] initWithRed:1 green:0.843 blue:0.0 alpha:1];
		
		
	}
	else if (delegate.snakeColor == [UIColor blueColor]){
		delegate.activeGame.currentView.snakeColor = [UIColor colorWithRed:0 green:0.68 blue:0.67 alpha:1];
		
		
	}
	
	
	[delegate.activeGame.currentView.wallLayer setNeedsDisplay];
	

	if (delegate.inTransition == YES) {
		[delegate.activeGame startGame];
	}
	
	else if (delegate.gameMode == kExtremeMode) {
		
		//[delegate.activeGame startTime];
		//[delegate.activeGame startGame];
	}
	else if (delegate.gameMode == kClassicMode){
	
		//[delegate.activeGame startGame];

	}

	
	delegate.gameStatus = kGameActive;
    [delegate.activeGame activateTimers];
    [delegate.activeGame setupExtremeTimers];
	
	delegate.displayLink.paused = NO;
	
	delegate.displayLink = nil;
	
	
	
	[resumeTimer invalidate];
	[theTimer invalidate];
	
	
	
	
	[pool release];
	
	
	
	
}


// Action that takes palce when the scores button is pressed. Takes the user to the scores screen
-(IBAction)scores:(id)sender{
	
    TSEvent *e = [TSEvent eventWithName:@"menu_scores" oneTimeOnly:NO];
    [[TSTapstream instance] fireEvent:e];
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	
	[delegate switchView:self.view toview:delegate.scoreMenu.view delay:NO remove:YES display:nil curlup:YES curldown:NO];
	
}


//Action that takes the user to the store to earn and user credits
-(IBAction)storePressed:(id)sender{


	
    TSEvent *e = [TSEvent eventWithName:@"menu_store" oneTimeOnly:NO];
    [[TSTapstream instance] fireEvent:e];
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[delegate switchView:self.view toview:delegate.storeView.view delay:NO remove:YES display:nil curlup:YES curldown:NO];
	
	
}

// Action that takes user to the help page

-(IBAction) helpPressed : (id)sender{
	
    TSEvent *e = [TSEvent eventWithName:@"menu_help" oneTimeOnly:NO];
    [[TSTapstream instance] fireEvent:e];

	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[delegate switchView:self.view toview:delegate.helpPage.view delay:NO remove:YES display:nil curlup:YES curldown:NO];
	
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


-(void)setBackground{
    
     SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
    if (delegate.theme == kClassicTheme) {
        if(IS_IPHONE_5){
            [background setFrame:CGRectMake(0, 0, 320, 568)];
            background.image = [UIImage imageNamed:@"main-menu_classic.png"];
        }
        else{
            background.image = [UIImage imageNamed:@"Classic.png"];
        }
    }
    
	else if(delegate.theme == kTheme1){
		if(IS_IPHONE_5){
            [background setFrame:CGRectMake(0, 0, 320, 568)];
            background.image = [UIImage imageNamed:@"main_menu_garden.png"];
        }
        else{
            background.image = [UIImage imageNamed:@"Theme1.png"];
        }
    }
	else if(delegate.theme == kTheme2){
		if(IS_IPHONE_5){
            [background setFrame:CGRectMake(0, 0, 320, 568)];
            background.image = [UIImage imageNamed:@"main_menu_beach.png"];
        }
        else{
            //background.image = [UIImage imageNamed:@"_0000_theme2_main.png"];
            background.image = [UIImage imageNamed:@"Theme2.png"];
        }
    }
	else if(delegate.theme == kTheme3){
		if(IS_IPHONE_5){
            [background setFrame:CGRectMake(0, 0, 320, 568)];
            background.image = [UIImage imageNamed:@"main_menu_night.png"];
        }
        else{
            background.image = [UIImage imageNamed:@"Theme3.png"];
        }
    }

}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    
    
    
 #ifdef LITE_VERSION
 // Code specific to lite version

    SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [self setBackground];
    if(IS_IPHONE_5){
        self.view.frame = CGRectMake(0, 0, 320, 568);
        
        CGRect btNewFrame = newgamebutton.frame;
        btNewFrame.origin.x = NEWGAME_BUTTON_X;
        btNewFrame.origin.y = 20 + NEWGAME_BUTTON_Y;
        newgamebutton.frame = btNewFrame;
        
        CGRect btResumeFrame = resumebutton.frame;
        btResumeFrame.origin.x = RESUMEGAME_BUTTON_X;
        btResumeFrame.origin.y = 20 + RESUMEGAME_BUTTON_Y;
        resumebutton.frame = btResumeFrame;
        
        CGRect btOptionFrame = optionbutton.frame;
        btOptionFrame.origin.x = OPTIONGAME_BUTTON_X;
        btOptionFrame.origin.y = 20 + OPTIONGAME_BUTTON_Y;
        optionbutton.frame = btOptionFrame;
        
        CGRect btScoresFrame = scoresbutton.frame;
        btScoresFrame.origin.x = OPTIONGAME_BUTTON_X;
        btScoresFrame.origin.y = 70 + OPTIONGAME_BUTTON_Y;
        scoresbutton.frame = btScoresFrame;
        
        CGRect btStoreFrame = storeButton.frame;
        btStoreFrame.origin.x = OPTIONGAME_BUTTON_X;
        btStoreFrame.origin.y = 120 + OPTIONGAME_BUTTON_Y;
        storeButton.frame = btStoreFrame;
        
        CGRect btHelpFrame = helpPressed.frame;
        btHelpFrame.origin.x = HELP_BUTTON_X;
        btHelpFrame.origin.y = 70 + HELP_BUTTON_Y;
        helpPressed.frame = btHelpFrame;
        
        CGRect btcheckAchievementsFrame = checkAchievementsButton.frame;
        btcheckAchievementsFrame.origin.x = CHECKACHIEVEMENT_BUTTON_X;
        btcheckAchievementsFrame.origin.y = 70 + CHECKACHIEVEMENT_BUTTON_Y;
        checkAchievementsButton.frame = btcheckAchievementsFrame;
        
    }

 #endif
    
    self.adView = nil;
    self.adView = [[[MPAdView alloc] initWithAdUnitId:@"770bbd6ca49544bb80bf388fd6c08f61"
                                                 size:MOPUB_BANNER_SIZE] autorelease];
    self.adView.delegate = self;
    CGRect frame = self.adView.frame;
    CGSize size = [self.adView adContentViewSize];
    frame.origin.y = [[UIScreen mainScreen] applicationFrame].size.height - size.height;
    self.adView.frame = frame;
    [self.view addSubview:self.adView];
    [self.adView loadAd];
    
    [super viewDidLoad];
 
}

-(IBAction) checkAchievements{
    
    SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (delegate.GCTest) {
    
	
	GKAchievementViewController *achievements = [[GKAchievementViewController alloc] init];
    if (achievements != nil)
    {
        achievements.achievementDelegate = self;
        [self presentModalViewController: achievements animated: YES];
    }
    [achievements release];
	}
}

-(IBAction) clearAchievements{
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
    if (delegate.GCTest) {
        [delegate clearAchievements];
    }
}
- (void)achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
    [self dismissModalViewControllerAnimated:YES];
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
    [super viewDidUnload];
	
	
	
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[newgamebutton release];
	[optionbutton release];
	[resumebutton release];
	[scoresbutton release];
    [storeButton release];
    self.adView = nil;
    [super dealloc];
}


@end
