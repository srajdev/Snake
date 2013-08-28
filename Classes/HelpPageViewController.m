//
//  HelpPageViewController.m
//  SnakeClassic
//
//  Created by Swapan Rajdev on 11/6/10.
//  Copyright 2010 Zing! Apps. All rights reserved.
//
//  NEW IN V2:
//  Descirption: This is the help page which gives the user all the information of all the different feature of the game

#import "HelpPageViewController.h"
#import "SnakeClassicAppDelegate.h"
#import "main_menu.h"


@implementation HelpPageViewController



- (void) viewDidAppear:(BOOL)animated{

	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	delegate.helpMode = kGamePlay;
	
	
	if (delegate.theme == kClassicTheme) {
		
		//background.image = [UIImage imageNamed:@"_0006_help_classic.png"];
		background.image = [UIImage imageNamed:@"Classic.png"];
	}
	else if(delegate.theme == kTheme1){
		
		
		//background.image = [UIImage imageNamed:@"help_garden.png"];
		background.image = [UIImage imageNamed:@"Theme1.png"];
	}
	else if(delegate.theme == kTheme2){
		
		//background.image = [UIImage imageNamed:@"help_beach.png"];
		background.image = [UIImage imageNamed:@"Theme2.png"];
	}
	else if(delegate.theme == kTheme3){
		
		
		//background.image = [UIImage imageNamed:@"help_night.png"];
		background.image = [UIImage imageNamed:@"Theme3.png"];
	}
	
	
#ifdef LITE_VERSION

	unlockButton.hidden = NO;
#else
    // Code specific to unlocked version
	unlockButton.hidden = YES;
	
	
#endif
	
	
	
#ifdef LITE_VERSION
//	[adView doNotIgnoreNewAdRequests];
//	[adView doNotIgnoreAutoRefreshTimer];
	
	//adView = [AdWhirlView requestAdWhirlViewWithDelegate:self];
	adView = delegate.mainmenu.adView;
	
	adView.frame = CGRectMake(0.0, 432.0, 320.0, 50.0);
	
	
	[self.view addSubview:adView];
	
#endif
	

	
	
	
}




// Function to get AdWhirl key
-(NSString *)adWhirlApplicationKey{
	
	return kSampleAppKey;
	
}

- (UIViewController *)viewControllerForPresentingModalView {
	return self;
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



-(IBAction) buttonPressed : (id)sender{
	
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	UIButton *button = (UIButton *)sender;
	
	delegate.pageFrom = kFromHelp;
	
	if (button.tag == 0) {
		[FlurryAnalytics logEvent:@"help/gameplay"];
		delegate.helpMode = kGamePlay;
	}
	else if(button.tag == 1){
	
		[FlurryAnalytics logEvent:@"help/unlock items"];
		delegate.helpMode = kUnlockItems;
		
	}
	else if(button.tag == 2){
	
		[FlurryAnalytics logEvent:@"help/FAQ"];
		delegate.helpMode = kFAQ;
	}
	
	
	[delegate switchView:self.view toview:delegate.helpDetail.view delay:NO remove:NO display:nil curlup:YES curldown:NO];
	


	
	
	
}

// takes the user to rate the game depending on which version he is on

-(IBAction) rateGame : (id) sender{
	[FlurryAnalytics logEvent:@"help/rate"];
#ifdef LITE_VERSION
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=394603141&onlyLatestVersion=false&type=Purple+Software"]];
	
#else
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=403683533&onlyLatestVersion=false&type=Purple+Software"]];
#endif
	
	
}


// Takes the user to Snake Classic Blog
-(IBAction) blogPressed : (id) sender{
	[FlurryAnalytics logEvent:@"help/blog"];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://snakeclassic.blogspot.com"]];
	
	
}


// Takes the user to the facebook page of Snake classic
-(IBAction) facebookPressed : (id) sender{
	[FlurryAnalytics logEvent:@"help/facebook page"];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.facebook.com/snakeclassic"]];
	
}


-(IBAction) backPressed : (id)sender{
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	
	[delegate switchView:self.view toview:delegate.mainmenu.view delay:NO remove:YES display:nil curlup:NO curldown:YES];
	
	
	
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
