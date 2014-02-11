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
#import "TSTapstream.h"

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
	
    TSEvent *e = [TSEvent eventWithName:@"store_earn credits" oneTimeOnly:NO];
    [[TSTapstream instance] fireEvent:e];
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[delegate switchView:self.view toview:delegate.earnView.view delay:NO remove:YES display:nil curlup:YES curldown:NO];
	
	
}


// Action taking the user to use their credits
-(IBAction) usePressed : (id) sender{
	
	TSEvent *e = [TSEvent eventWithName:@"store_use credits" oneTimeOnly:NO];
    [[TSTapstream instance] fireEvent:e];
	
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



-(IBAction) backPressed : (id) sender{
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	
	
	[delegate switchView:self.view toview:delegate.mainmenu.view delay:NO remove:YES display:nil curlup:NO curldown:YES];
	
}

// Action taking the user to the help page to understand the store
-(IBAction) helpPressed : (id)sender{
	
	TSEvent *e = [TSEvent eventWithName:@"store_help" oneTimeOnly:NO];
    [[TSTapstream instance] fireEvent:e];
	
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
    self.adView = nil;
    [super dealloc];
}


@end
