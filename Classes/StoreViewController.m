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
#import "FlurryAdDelegate.h"
#import "FlurryAds.h"
#import "Flurry.h"

@implementation StoreViewController

@synthesize goToEarn;
@synthesize earnButton;
@synthesize useButton;
@synthesize backButton;
@synthesize helpButton;
@synthesize balance;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


-(void)viewWillAppear:(BOOL)animated{
    [self setBackground];
}

- (void)viewDidLoad{
    
    [self setBackground];
    
    if(IS_IPHONE_5){
        //self.view.frame = CGRectMake(0, 0, 320, 568);
        
        CGRect btbalFrame = balance.frame;
        btbalFrame.origin.x = 268;
        btbalFrame.origin.y = 3 + 4;
        balance.frame = btbalFrame;
        
        CGRect btearnFrame = earnButton.frame;
        btearnFrame.origin.x = STORE_EARN_BUTTON_X;
        btearnFrame.origin.y = 40 + STORE_EARN_BUTTON_Y;
        earnButton.frame = btearnFrame;
        
        CGRect btuseFrame = useButton.frame;
        btuseFrame.origin.x = STORE_EARN_BUTTON_X;
        btuseFrame.origin.y = 150 + STORE_EARN_BUTTON_Y;
        useButton.frame = btuseFrame;
        
        CGRect btbackFrame = backButton.frame;
        btbackFrame.origin.x = OPTIONS_BACK_BUTTON_X;
        btbackFrame.origin.y = 70 + OPTIONS_BACK_BUTTON_Y;
        backButton.frame = btbackFrame;
        
        CGRect bthelpFrame = helpButton.frame;
        bthelpFrame.origin.x = GAMEMODE_HELP_BUTTON_X;
        bthelpFrame.origin.y = 65 + GAMEMODE_HELP_BUTTON_Y;
        helpButton.frame = bthelpFrame;
	}
}


-(void)setBackground{
    SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
    
    if (delegate.theme == kClassicTheme) {
        if(IS_IPHONE_5){
            [background setFrame:CGRectMake(0, 0, 320, 568)];
            background.image = [UIImage imageNamed:@"store_classic.png"];
        }
        else{
            background.image = [UIImage imageNamed:@"_0000_classic_store.png"];
        }
        balance.textColor = [UIColor whiteColor];
    }
    
    else if(delegate.theme == kTheme1){
        if(IS_IPHONE_5){
            [background setFrame:CGRectMake(0, 0, 320, 568)];
            background.image = [UIImage imageNamed:@"store_garden.png"];
        }
        else{
            background.image = [UIImage imageNamed:@"_0000_theme1_store.png"];
        }
        balance.textColor = [UIColor yellowColor];
    }
    else if(delegate.theme == kTheme2){
        if(IS_IPHONE_5){
            [background setFrame:CGRectMake(0, 0, 320, 568)];
            background.image = [UIImage imageNamed:@"store_beach.png"];
        }
        else{
            background.image = [UIImage imageNamed:@"_0000_theme2_store.png"];
        }
        balance.textColor = [UIColor darkTextColor];
    }
    else if(delegate.theme == kTheme3){
        if(IS_IPHONE_5){
            [background setFrame:CGRectMake(0, 0, 320, 568)];
            background.image = [UIImage imageNamed:@"store_night.png"];
            
        }
        else{
            background.image = [UIImage imageNamed:@"_0000_theme3_store.png"];
        }
        balance.textColor = [UIColor whiteColor];
    }

}
- (void) viewDidAppear:(BOOL)animated{
	
	

	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
	
	balance.text = [NSString stringWithFormat:@"%d Cr",delegate.userBalance];
	 

	
	if (delegate.morethanOnce == NO) {
		
		delegate.morethanOnce = YES;
		
		[NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(showAlert:) userInfo:nil repeats:NO];
		
	}
	
	
    [FlurryAds setAdDelegate:self];
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


// Alert shown the first time user enters the store

-(void) showAlert :(NSTimer *)theTimer{

	
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome" message:@"Unlock premium fields and wallpapers using credits. There are various ways to earn free Credits." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Earn Credits",nil];
	
		[alert show];

	
	[theTimer invalidate];
	
	
	
}



// Action taking the user to earn credits
-(IBAction) earnPressed : (id) sender{
	
	[Flurry logEvent:@"store/earn credits"];
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[delegate switchView:self.view toview:delegate.earnView.view delay:NO remove:YES display:nil curlup:YES curldown:NO];
	
	
}


// Action taking the user to use their credits
-(IBAction) usePressed : (id) sender{
	
	[Flurry logEvent:@"store/user credits"];
	
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
	
	[Flurry logEvent:@"store/unlock all"];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/app/id403683533"]];
	
}



-(IBAction) backPressed : (id) sender{
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	
	
	[delegate switchView:self.view toview:delegate.mainmenu.view delay:NO remove:YES display:nil curlup:NO curldown:YES];
	
}

// Action taking the user to the help page to understand the store
-(IBAction) helpPressed : (id)sender{
	
	[Flurry logEvent:@"store/help"];
	
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

- (void) viewDidDisappear:(BOOL)animated{
    
    [FlurryAds removeAdFromSpace:@"BANNER_MAIN_VIEW"];
    [FlurryAds setAdDelegate:nil];
    
	
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
