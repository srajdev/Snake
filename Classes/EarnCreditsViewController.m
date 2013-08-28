//
//  EarnCreditsViewController.m
//  SnakeClassic
//
//  Created by Swapan Rajdev on 11/5/10.
//  Copyright 2010 Zing! Apps. All rights reserved.
//
//  NEW IN V2:
//  Description: This view is the view to earn credits by downloading apps.


#import "EarnCreditsViewController.h"
#import "SnakeClassicAppDelegate.h"
#import "FlurryAnalytics.h"
#import "FlurryOffer.h"
#import "FlurryAppCircle.h"
#import "main_menu.h"


@implementation EarnCreditsViewController

@synthesize myAdView;

- (void) viewDidAppear:(BOOL)animated{
	
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	balance.text = [NSString stringWithFormat:@"%d Cr",delegate.userBalance];
	
	if (delegate.theme == kClassicTheme) {
		
		background.image = [UIImage imageNamed:@"_0000_earn_credits.png"];
		balance.textColor = [UIColor whiteColor];
		
	}
	else if(delegate.theme == kTheme1){
		
		
		background.image = [UIImage imageNamed:@"_0000_theme1_earn_credits.png"];
		balance.textColor = [UIColor yellowColor];
	}
	else if(delegate.theme == kTheme2){
		
		background.image = [UIImage imageNamed:@"_0000_theme2_earn_credits.png"];
		balance.textColor = [UIColor darkTextColor];
	}
	else if(delegate.theme == kTheme3){
		
		
		background.image = [UIImage imageNamed:@"_0000_theme_3_earn_credits.png"];
		balance.textColor = [UIColor whiteColor];
	}
	
	
	if (delegate.isconnected == NO) {
		
				
		[NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(showAlert:) userInfo:nil repeats:NO];
		
	}
	else if(delegate.take_over == 1){
		[NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(showAlert_2:) userInfo:nil repeats:NO];
	}

	
	
	
	[self refresh];
	
//	[adView doNotIgnoreNewAdRequests];
//	[adView doNotIgnoreAutoRefreshTimer];
	
	//adView = [AdWhirlView requestAdWhirlViewWithDelegate:self];
	adView = delegate.mainmenu.adView;
	
	adView.frame = CGRectMake(0.0, 432.0, 320.0, 50.0);
	
	
	[self.view addSubview:adView];
	
}


// Function to refresh the app suggested to the user
-(void) refresh{
	
	FlurryOffer *flurryOffer = [[FlurryOffer alloc] init];
	BOOL validOffer = [FlurryAppCircle getOffer:@"EARN_CREDITS" withFlurryOfferContainer:flurryOffer];
	

	

	if (validOffer) {
		
		
		CGRect imageRect = CGRectMake(68.7f, 120.5f, 44.0f, 44.0f);
		myAdView = [[MyAdView alloc] initWithFrame:imageRect appIcon:flurryOffer.appIcon referralUrl:flurryOffer.referralUrl];
		[self.view addSubview:myAdView];
		
		name.text = flurryOffer.appName;
		//[myAdView autorelease];
	}

	[flurryOffer release];
	
	
			
	
}


// Alert shown when the user is not connected to the interner
-(void) showAlert :(NSTimer *)theTimer{
	
	
	
	
	
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Unable to communicate with server. Please make sure you have Internet connectivity. Thanks!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
	
	[alert show];
	
	
	
	
	
	
	[theTimer invalidate];
	
	
	
}


-(void) showAlert_2 :(NSTimer *)theTimer{
	

	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Today only, earn 60 credits!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
	
	[alert show];
	

	[theTimer invalidate];
	
	
	
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


// Takes the user to download the suggested app
- (IBAction) downloadPressed{
	
	[myAdView downloadApp];
	
}

-(IBAction) refreshPressed{

	[self refresh];
	
}

-(IBAction) backPressed{
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	if (delegate.earn_from_menu == YES) {
		delegate.earn_from_menu = NO;
		[delegate switchView:self.view toview:delegate.mainmenu.view delay:NO remove:YES display:nil curlup:NO curldown:YES];
	}
	else {
		[delegate switchView:self.view toview:delegate.storeView.view delay:NO remove:YES display:nil curlup:NO curldown:YES];
	}

	
	
	
	
	
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
