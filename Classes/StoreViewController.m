//
//  StoreViewController.m
//  SnakeClassic
//
//  Created by Swapan Rajdev on 11/4/10.
//  Copyright 2010 Zing! Apps. All rights reserved.
//
//  NEW IN V2:
//  Description: This is the main store page which the user can use to earn credits/ user credits 
//				 or download the unlocked version

#import "StoreViewController.h"
#import "SnakeClassicAppDelegate.h"
#import "main_menu.h"


@implementation StoreViewController

@synthesize goToEarn;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/



- (void) viewDidAppear:(BOOL)animated{
	
	

	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	
	
	
	if (delegate.theme == kClassicTheme) {
		
		background.image = [UIImage imageNamed:@"_0000_classic_store.png"];
		balance.textColor = [UIColor whiteColor];
		
	}
	else if(delegate.theme == kTheme1){
		
		
		background.image = [UIImage imageNamed:@"_0000_theme1_store.png"];
		balance.textColor = [UIColor yellowColor];
	}
	else if(delegate.theme == kTheme2){
		
		background.image = [UIImage imageNamed:@"_0000_theme2_store.png"];
		balance.textColor = [UIColor darkTextColor];
	}
	else if(delegate.theme == kTheme3){
		
		
		background.image = [UIImage imageNamed:@"_0000_theme3_store.png"];
		balance.textColor = [UIColor whiteColor];
	}
	
	

	
	balance.text = [NSString stringWithFormat:@"%d Cr",delegate.userBalance];
	 

	
	if (delegate.morethanOnce == NO) {
		
		delegate.morethanOnce = YES;
		
		[NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(showAlert:) userInfo:nil repeats:NO];
		
	}
	
	
	
	
	
	//[adView doNotIgnoreNewAdRequests];
	//[adView doNotIgnoreAutoRefreshTimer];
	
	//adView = [AdWhirlView requestAdWhirlViewWithDelegate:self];
	adView = delegate.mainmenu.adView;
	
	adView.frame = CGRectMake(0.0, 432.0, 320.0, 50.0);
	

	
	
	
	
	
	[self.view addSubview:adView];
	
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
// Function to get AdWhirl key
-(NSString *)adWhirlApplicationKey{
	
	return kSampleAppKey;
	
}

- (UIViewController *)viewControllerForPresentingModalView {
	return self;
}


// Alert shown the first time user enters the store

-(void) showAlert :(NSTimer *)theTimer{

	
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome" message:@"Unlock premium fields and wallpapers using credits. Earn credits by downloading recommended free apps!" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Earn Credits",nil];
	
		[alert show];

	
	[theTimer invalidate];
	
	
	
}

// Action taking the user to earn credits
-(IBAction) earnPressed : (id) sender{
	
	[FlurryAnalytics logEvent:@"store/earn credits"];
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[delegate switchView:self.view toview:delegate.earnView.view delay:NO remove:YES display:nil curlup:YES curldown:NO];
	
	
}


// Action taking the user to use their credits
-(IBAction) usePressed : (id) sender{
	
	[FlurryAnalytics logEvent:@"store/user credits"];
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[delegate switchView:self.view toview:delegate.useCreditsView.view delay:NO remove:YES display:nil curlup:YES curldown:NO];
	
	
	
}



// Alert taking the user to download the Unlocked game
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	


		
	if (buttonIndex == 1){
		
		SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
		
		[delegate switchView:self.view toview:delegate.earnView.view delay:NO remove:YES display:nil curlup:YES curldown:NO];
		
		
	}
	
}

// Action that takes the user to download the unlocked game
-(IBAction) unlockPressed : (id) sender{
	
	[FlurryAnalytics logEvent:@"store/unlock all"];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/app/id403683533"]];
	
	
	
}



-(IBAction) backPressed : (id) sender{
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	
	
	[delegate switchView:self.view toview:delegate.mainmenu.view delay:NO remove:YES display:nil curlup:NO curldown:YES];
	
}

// Action taking the user to the help page to understand the store
-(IBAction) helpPressed : (id)sender{
	
	[FlurryAnalytics logEvent:@"store/help"];
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	delegate.pageFrom = kFromStore;
	
	delegate.helpMode = kUnlockItems;
	
	[delegate switchView:self.view toview:delegate.helpDetail.view delay:NO remove:YES display:nil curlup:YES curldown:NO];
	
	
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
