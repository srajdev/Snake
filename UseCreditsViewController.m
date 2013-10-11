//
//  UseCreditsViewController.m
//  SnakeClassic
//
//  Created by Swapan Rajdev on 11/4/10.
//  Copyright 2010 Zing! Apps. All rights reserved.
//
//  NEW IN V2
//  Description: This view is used to use the credits to unlock the different themes and fields

#import "UseCreditsViewController.h"
#import "SnakeClassicAppDelegate.h"
#import "main_menu.h"
#import "UnlockViewController.h"
#import "GKAchievementHandler.h"


@implementation UseCreditsViewController

@synthesize garden;
@synthesize gardenUnlocked;
@synthesize beach;
@synthesize beachUnlocked;
@synthesize night;
@synthesize nightUnlocked;
@synthesize hole;
@synthesize holeUnlocked;
@synthesize square;
@synthesize squareUnlocked;
@synthesize backButton;

-(void) viewDidLoad{
    
    SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
    if (delegate.theme == kClassicTheme) {
		if(IS_IPHONE_5){
             self.view.frame = CGRectMake(0, 0, 320, 568);
            [background setFrame:CGRectMake(0, 0, 320, 568)];
            background.image = [UIImage imageNamed:@"_use_credits_classic.png"];
        }
        else{
            background.image = [UIImage imageNamed:@"use_credits_classic.png"];
		}
        balance.textColor = [UIColor whiteColor];
		
	}
	else if(delegate.theme == kTheme1){
		if(IS_IPHONE_5){
             self.view.frame = CGRectMake(0, 0, 320, 568);
            [background setFrame:CGRectMake(0, 0, 320, 568)];
            background.image = [UIImage imageNamed:@"_use_credits_garden.png"];
        }
        else{
            
            background.image = [UIImage imageNamed:@"use_credits_garden.png"];
		}
        balance.textColor = [UIColor yellowColor];
	}
	else if(delegate.theme == kTheme2){
		if(IS_IPHONE_5){
             self.view.frame = CGRectMake(0, 0, 320, 568);
            [background setFrame:CGRectMake(0, 0, 320, 568)];
            background.image = [UIImage imageNamed:@"_use_credits_beach.png"];
        }
        else{
            background.image = [UIImage imageNamed:@"use_credits_beach.png"];
		}
        balance.textColor = [UIColor darkTextColor];
	}
	else if(delegate.theme == kTheme3){
		
		if(IS_IPHONE_5){
             self.view.frame = CGRectMake(0, 0, 320, 568);
            [background setFrame:CGRectMake(0, 0, 320, 568)];
            background.image = [UIImage imageNamed:@"_use_credits_night.png"];
        }
        else{
            background.image = [UIImage imageNamed:@"use_credits_night.png"];
        }
		balance.textColor = [UIColor whiteColor];
	}
    
    
    if(IS_IPHONE_5) {
       
        
        CGRect btbeachFrame = beach.frame;
        btbeachFrame.origin.x = USE_BEACH_BUTTON_X;
        btbeachFrame.origin.y = 65 + USE_BEACH_BUTTON_Y;
        beach.frame = btbeachFrame;
        
        CGRect btbeachUnFrame = beachUnlocked.frame;
        btbeachUnFrame.origin.x = USE_BEACH_BUTTON_X;
        btbeachUnFrame.origin.y = 65 + USE_BEACH_BUTTON_Y;
        beachUnlocked.frame = btbeachUnFrame;
        
        CGRect btgardenFrame = garden.frame;
        btgardenFrame.origin.x = USE_BEACH_BUTTON_X;
        btgardenFrame.origin.y = 115 + USE_BEACH_BUTTON_Y;
        garden.frame = btgardenFrame;
        
        CGRect btgardenUnFrame = gardenUnlocked.frame;
        btgardenUnFrame.origin.x = USE_BEACH_BUTTON_X;
        btgardenUnFrame.origin.y = 115 + USE_BEACH_BUTTON_Y;
        gardenUnlocked.frame = btgardenUnFrame;
        
        CGRect btnightFrame = night.frame;
        btnightFrame.origin.x = USE_BEACH_BUTTON_X;
        btnightFrame.origin.y = 165 + USE_BEACH_BUTTON_Y;
        night.frame = btnightFrame;
        
        CGRect btnightUnFrame = nightUnlocked.frame;
        btnightUnFrame.origin.x = USE_BEACH_BUTTON_X;
        btnightUnFrame.origin.y = 165 + USE_BEACH_BUTTON_Y;
        nightUnlocked.frame = btnightUnFrame;
        
        CGRect btholeFrame = hole.frame;
        btholeFrame.origin.x = USE_BEACH_BUTTON_X;
        btholeFrame.origin.y = 260 + USE_BEACH_BUTTON_Y;
        hole.frame = btholeFrame;
        
        CGRect btholeUnFrame = holeUnlocked.frame;
        btholeUnFrame.origin.x = USE_BEACH_BUTTON_X;
        btholeUnFrame.origin.y = 260 + USE_BEACH_BUTTON_Y;
        holeUnlocked.frame = btholeUnFrame;
        
        CGRect btsquareFrame = square.frame;
        btsquareFrame.origin.x = USE_BEACH_BUTTON_X;
        btsquareFrame.origin.y = 310 + USE_BEACH_BUTTON_Y;
        square.frame = btsquareFrame;
        
        CGRect btsquareUnFrame = squareUnlocked.frame;
        btsquareUnFrame.origin.x = USE_BEACH_BUTTON_X;
        btsquareUnFrame.origin.y = 310 + USE_BEACH_BUTTON_Y;
        squareUnlocked.frame = btsquareUnFrame;
        
        CGRect btbackFrame = backButton.frame;
        btbackFrame.origin.x = HELPDETAIL_BACK_BUTTON_X;
        btbackFrame.origin.y = 80 + HELPDETAIL_BACK_BUTTON_Y;
        backButton.frame = btbackFrame;
    }
}
- (void) viewDidAppear:(BOOL)animated{
	
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	
	delegate.userBalance = delegate.totalbalance - (delegate.holeUnlocked * 30) - (delegate.squareUnlocked *30)
	- (delegate.beachUnlocked *20) - (delegate.gardenUnlocked *20) - (delegate.nightUnlocked *20);
	
	if(delegate.userBalance < 0){
		
		delegate.userBalance = 0;
	}
	
	balance.text = [NSString stringWithFormat:@"%d Cr",delegate.userBalance];
	
	
	/*if (delegate.theme == kClassicTheme) {
		if(IS_IPHONE_5){
            [background setFrame:CGRectMake(0, 0, 320, 568)];
            background.image = [UIImage imageNamed:@"_use_credits_classic.png"];
        }
        else{
		background.image = [UIImage imageNamed:@"use_credits_classic.png"];
		}
        balance.textColor = [UIColor whiteColor];
		
	}
	else if(delegate.theme == kTheme1){
		if(IS_IPHONE_5){
            [background setFrame:CGRectMake(0, 0, 320, 568)];
            background.image = [UIImage imageNamed:@"_use_credits_garden.png"];
        }
        else{
		
		background.image = [UIImage imageNamed:@"use_credits_garden.png"];
		}
        balance.textColor = [UIColor yellowColor];
	}
	else if(delegate.theme == kTheme2){
		if(IS_IPHONE_5){
            [background setFrame:CGRectMake(0, 0, 320, 568)];
            background.image = [UIImage imageNamed:@"_use_credits_beach.png"];
        }
        else{
		background.image = [UIImage imageNamed:@"use_credits_beach.png"];
		}
        balance.textColor = [UIColor darkTextColor];
	}
	else if(delegate.theme == kTheme3){
		
		if(IS_IPHONE_5){
            [background setFrame:CGRectMake(0, 0, 320, 568)];
            background.image = [UIImage imageNamed:@"_use_credits_night.png"];
        }
        else{
		background.image = [UIImage imageNamed:@"use_credits_night.png"];
        }
		balance.textColor = [UIColor whiteColor];
	}
	*/
	if (delegate.beachUnlocked == YES) {
		beachUnlocked.hidden = NO;
		beachUnlocked.enabled = NO;
		beach.hidden = YES;
	}
	else{
		
		beachUnlocked.hidden = YES;
		beach.hidden = NO;
	}

	
	if (delegate.gardenUnlocked == YES) {
		gardenUnlocked.hidden = NO;
		gardenUnlocked.enabled = NO;
		garden.hidden = YES;
	}
	else {
		gardenUnlocked.hidden = YES;
		garden.hidden = NO;
	}
	
	if (delegate.nightUnlocked == YES) {
		nightUnlocked.hidden = NO;
		nightUnlocked.enabled = NO;
		night.hidden = YES;
	}
	else {
		nightUnlocked.hidden = YES;
		night.hidden = NO;
	}
	
    
    if(delegate.GCTest){
    
	GKAchievement *achievement = [delegate getAchievementForIdentifier:@"Creative_Snake"];
	
	
	if (achievement.percentComplete < 100.0 && delegate.beachUnlocked == YES && delegate.gardenUnlocked == YES && delegate.nightUnlocked == YES && delegate.GCConnected) {
		[delegate reportAchievementIdentifier:@"Creative_Snake" percentComplete:100];
		
		[NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(showAchievement:) userInfo:nil repeats:NO];
	}
	}
	
	if (delegate.holeUnlocked == YES) {
		holeUnlocked.hidden = NO;
		holeUnlocked.enabled = NO;
		hole.hidden = YES;
	}
	else {
		holeUnlocked.hidden = YES;
		hole.hidden = NO;
	}
	
	if (delegate.squareUnlocked == YES) {
		squareUnlocked.hidden = NO;
		squareUnlocked.enabled = NO;
		square.hidden = YES;
	}
	else {
		squareUnlocked.hidden = YES;
		square.hidden = NO;
	}



	//[adView doNotIgnoreNewAdRequests];
	//[adView doNotIgnoreAutoRefreshTimer];
	
	//adView = [AdWhirlView requestAdWhirlViewWithDelegate:self];
/*	adView = delegate.mainmenu.adView;
	if(IS_IPHONE_5){
        
        adView.frame = CGRectMake(0.0, 520.0, 320.0, 50.0);
        
    }
    else{
	adView.frame = CGRectMake(0.0, 432.0, 320.0, 50.0);
	}
	
	[self.view addSubview:adView];
*/
	
	
}




-(void) showAchievement: (NSTimer *)theTimer{
	
	[[GKAchievementHandler defaultHandler] notifyAchievementTitle:@"Creative Snake" andMessage:@"Congratulations!"];	
	
	[theTimer invalidate];
	
	
}

/*
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
*/

// Function to get AdWhirl key
-(NSString *)adWhirlApplicationKey{
	
	return kSampleAppKey;
	
}

- (UIViewController *)viewControllerForPresentingModalView {
	return self;
}


// Action taking the user to view the theme or field 
-(IBAction) viewPressed : (id) sender{

	UIButton *buttonPressed = (UIButton *)sender;
	
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	delegate.unlockFromAnother = 0;
	
	if (buttonPressed.tag == 0) {
		[FlurryAnalytics logEvent:@"use credits/view beach"];
		delegate.creditsInfo = kBeach;
		
	}
	else if(buttonPressed.tag == 1){
		[FlurryAnalytics logEvent:@"use credits/view garden"];
	
		delegate.creditsInfo = kGarden;
	}
	else if(buttonPressed.tag == 2){
		[FlurryAnalytics logEvent:@"use credits/view night"];
		
		delegate.creditsInfo = kNight;
	}	
	else if(buttonPressed.tag == 3){
		[FlurryAnalytics logEvent:@"use credits/view hitw"];
		
		delegate.creditsInfo = kHole;
	}
	else if(buttonPressed.tag == 4){
		[FlurryAnalytics logEvent:@"use credits/view 4sq"];
		
		delegate.creditsInfo = kSquare;
	}
	
	[delegate switchView:self.view toview:delegate.unlockView.view delay:NO remove:YES display:nil curlup:YES curldown:NO];
	
	
	
}

-(IBAction) backPressed : (id) sender{
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	
	
	[delegate switchView:self.view toview:delegate.storeView.view delay:NO remove:YES display:nil curlup:NO curldown:YES];
	
	
	
}



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
