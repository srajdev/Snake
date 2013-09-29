//
//  GameModeViewController.m
//  SnakeClassic
//
//  Created by Swapan Rajdev on 10/26/10.
//  Copyright 2010 Zing! Apps. All rights reserved.
//  
//  NEW IN V2
//  Description: Screen which allows the user to select the game mode.
//				 The 2 different game modes are classic and extreme
//				 extreme is a time challenge through all levels.
//

#import "GameModeViewController.h"
#import "SnakeClassicAppDelegate.h"
#import "Difficulty.h"
#import "Snake_3ViewController.h"


@implementation GameModeViewController
@synthesize classicButton;
@synthesize extremeButton;
@synthesize helpButton;
@synthesize backButton;

- (void) viewDidAppear:(BOOL)animated{
	
	
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
	
    if(IS_IPHONE_5){
        CGRect btclassicFrame = classicButton.frame;
        btclassicFrame.origin.x = GAMEMODE_CLASSIC_BUTTON_X;
        btclassicFrame.origin.y = 30 + GAMEMODE_BUTTON_Y;
        classicButton.frame = btclassicFrame;
        
        CGRect btextremeFrame = extremeButton.frame;
        btextremeFrame.origin.x = GAMEMODE_CLASSIC_BUTTON_X;
        btextremeFrame.origin.y = 150 + GAMEMODE_BUTTON_Y;
        extremeButton.frame = btextremeFrame;

        CGRect bthelpFrame = helpButton.frame;
        bthelpFrame.origin.x = GAMEMODE_HELP_BUTTON_X;
        bthelpFrame.origin.y = 60 + GAMEMODE_HELP_BUTTON_Y;
        helpButton.frame = bthelpFrame;

        CGRect btbackFrame = backButton.frame;
        btbackFrame.origin.x = GAMEMODE_BACK_BUTTON_X;
        btbackFrame.origin.y = 60 + GAMEMODE_BACK_BUTTON_Y;
        backButton.frame = btbackFrame;

    }
    
	
#ifdef LITE_VERSION
    // Code specific to lite version
	
	
	//	[adView doNotIgnoreNewAdRequests];
	//	[adView doNotIgnoreAutoRefreshTimer];
	
	//adView = [AdWhirlView requestAdWhirlViewWithDelegate:self];
	adView = delegate.mainmenu.adView;
	if(IS_IPHONE_5){
        
        adView.frame = CGRectMake(0.0, 520.0, 320.0, 50.0);
        
    }
    else{
	adView.frame = CGRectMake(0.0, 432.0, 320.0, 50.0);
	}
#endif
	
   
	
#ifdef LITE_VERSION
    // Code specific to lite version
	
	
	[self.view addSubview:adView];
	
#endif
	
	
}

- (UIViewController *)viewControllerForPresentingModalView {
	return self;
}


// Action that is called when the user wants to play the classic mode

-(IBAction) ClassicPressed : (id) sender{
	
	[FlurryAnalytics logEvent:@"newgame/classic"];
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	
	[delegate.activeGame.displayLink invalidate];
	delegate.activeGame = nil;
	
	
	
	delegate.foodNumber = 0;
	delegate.bonusFoodNumber = 0;
	delegate.extremeSuccess = 0;
	delegate.missedInExtreme = 0;
	
	
	
	
	delegate.gameMode = kClassicMode;
	
	delegate.fieldMode = kNoWall;
	
	delegate.inTransition = NO;
	
	delegate.isWallOn = NO;
	[delegate.mainmenu.adView ignoreNewAdRequests];
	
	[delegate switchView:self.view toview:delegate.fieldModeMenu.view delay:NO remove:YES display:nil curlup:YES curldown:NO];
	
	

	
	
	
}

- (void)adWhirlDidReceiveAd:(AdWhirlView *)adWhirlView {
	
	
	
	
	//SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	
	
	
	[UIView beginAnimations:@"AdResize" context:nil];
	[UIView setAnimationDuration:0.5];
	CGSize adSize = [adWhirlView actualAdSize];
	CGRect newFrame = adWhirlView.frame;
	newFrame.size.height = adSize.height; // fit the ad
	newFrame.size.width = adSize.width;
	newFrame.origin.x = (self.view.bounds.size.width - adSize.width)/2; // center
	
	
	
	adWhirlView.frame = newFrame;
	// ... adjust surrounding views here ...
	[UIView commitAnimations];
}
// Action that is called when the user wants to play the extreme mode

- (IBAction) ExtremePressed : (id) sender{
	
	[FlurryAnalytics logEvent:@"newgame/extreme"];
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	
	[delegate.mainmenu.adView ignoreNewAdRequests];
	
	[delegate.activeGame.displayLink invalidate];
	delegate.activeGame = nil;
	
	
	
	delegate.foodNumber = 0;
	delegate.bonusFoodNumber = 0;
	delegate.extremeSuccess = 0;
	delegate.missedInExtreme = 0;
	
	
	
	
	delegate.gameMode = kExtremeMode;
	
	delegate.delegateScore = 0;

	
	delegate.time = 45;
	delegate.fieldMode = kNoWall;
	
	delegate.isWallOn = NO;
	
	delegate.inTransition = NO;
	
	//[delegate.fullWallGame release];
	
	delegate.fullWallGame = [[Snake_3ViewController alloc] initWithNibName:@"Snake_3ViewController" bundle:nil];
	
	delegate.holeWallGame = [[Snake_3ViewController alloc] initWithNibName:@"Snake_3ViewController" bundle:nil];
	
	delegate.squareWallGame = [[Snake_3ViewController alloc] initWithNibName:@"Snake_3ViewController" bundle:nil];
	
	
	[delegate switchView:self.view toview:delegate.difficultyMenu.view delay:NO remove:YES display:nil curlup: YES curldown:NO];
	
}

// Takes the user back to the main menu
-(IBAction) BackPressed :(id)sender{
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[delegate switchView:self.view toview:delegate.mainmenu.view delay:NO remove:YES display:nil curlup:NO curldown:YES];
}

// Takes the user to the help page to explain the different modes
-(IBAction) helpPressed : (id)sender{
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	delegate.pageFrom = kFromGameMode;
	
	delegate.helpMode = kGamePlay;
	
	[delegate switchView:self.view toview:delegate.helpDetail.view delay:NO remove:YES display:nil curlup:YES curldown:NO];
	
	
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
    [super dealloc];
}


@end
