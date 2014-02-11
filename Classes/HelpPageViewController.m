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
#import "TSTapstream.h"

@implementation HelpPageViewController

@synthesize gameplayButton;
@synthesize faqButton;
@synthesize unlockButton;
@synthesize rateButton;
@synthesize blogButton;
@synthesize facebookButton;
@synthesize backButton;

- (void) viewDidLoad{

    SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
    delegate.helpMode = kGamePlay;

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
        self.view.frame = CGRectMake(0, 0, 320, 568);
        
        CGRect btgameplayFrame = gameplayButton.frame;
        btgameplayFrame.origin.x = HELPPAGEVIEW_BUTTON_X;
        btgameplayFrame.origin.y = 40 + GAMEPLAY_BUTTON_Y;
        gameplayButton.frame = btgameplayFrame;
        
        CGRect btfaqFrame = faqButton.frame;
        btfaqFrame.origin.x = HELPPAGEVIEW_BUTTON_X;
        btfaqFrame.origin.y = 90 + GAMEPLAY_BUTTON_Y;
        faqButton.frame = btfaqFrame;
        
        CGRect btunlockFrame = unlockButton.frame;
        btunlockFrame.origin.x = HELPPAGEVIEW_BUTTON_X;
        btunlockFrame.origin.y = 140 + GAMEPLAY_BUTTON_Y;
        unlockButton.frame = btunlockFrame;
        
        CGRect btrateFrame = rateButton.frame;
        btrateFrame.origin.x = HELPPAGEVIEW_BUTTON_X;
        btrateFrame.origin.y = 210 + GAMEPLAY_BUTTON_Y;
        rateButton.frame = btrateFrame;
        
        CGRect btblogFrame = blogButton.frame;
        btblogFrame.origin.x = HELPPAGEVIEW_BUTTON_X;
        btblogFrame.origin.y = 260 + GAMEPLAY_BUTTON_Y;
        blogButton.frame = btblogFrame;
        
        CGRect btfacebookFrame = facebookButton.frame;
        btfacebookFrame.origin.x = HELPPAGEVIEW_BUTTON_X;
        btfacebookFrame.origin.y = 310 + GAMEPLAY_BUTTON_Y;
        facebookButton.frame = btfacebookFrame;
        
        CGRect btbackFrame = backButton.frame;
        btbackFrame.origin.x = BACK_BUTTON_X;
        btbackFrame.origin.y = 80 + BACK_BUTTON_Y;
        backButton.frame = btbackFrame;
        
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

- (void) viewWillAppear:(BOOL)animated{

	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	delegate.helpMode = kGamePlay;
	
		
#ifdef LITE_VERSION

	unlockButton.hidden = NO;
#else
    // Code specific to unlocked version
	unlockButton.hidden = YES;
		
#endif
	
	
	
#ifdef LITE_VERSION
#endif
	

	[super viewWillAppear:animated];
	
	
}


// Function to get AdWhirl key
-(NSString *)adWhirlApplicationKey{
	
	return kSampleAppKey;
	
}

- (UIViewController *)viewControllerForPresentingModalView {
	return self;
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


-(IBAction) buttonPressed : (id)sender{
	
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	UIButton *button = (UIButton *)sender;
	
	delegate.pageFrom = kFromHelp;
	
	if (button.tag == 0) {
        TSEvent *e = [TSEvent eventWithName:@"help_game play" oneTimeOnly:NO];
        [[TSTapstream instance] fireEvent:e];
		delegate.helpMode = kGamePlay;
	}
	else if(button.tag == 1){
	
        TSEvent *e = [TSEvent eventWithName:@"help_unlock items" oneTimeOnly:NO];
        [[TSTapstream instance] fireEvent:e];
		delegate.helpMode = kUnlockItems;
		
	}
	else if(button.tag == 2){
	
        TSEvent *e = [TSEvent eventWithName:@"help_faqs" oneTimeOnly:NO];
        [[TSTapstream instance] fireEvent:e];
		delegate.helpMode = kFAQ;
	}
	
	
	[delegate switchView:self.view toview:delegate.helpDetail.view delay:NO remove:NO display:nil curlup:YES curldown:NO];
	


	
	
	
}

// takes the user to rate the game depending on which version he is on

-(IBAction) rateGame : (id) sender{
    TSEvent *e = [TSEvent eventWithName:@"help_rate" oneTimeOnly:NO];
    [[TSTapstream instance] fireEvent:e];
#ifdef LITE_VERSION
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=394603141&onlyLatestVersion=false&type=Purple+Software"]];
	
#else
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=403683533&onlyLatestVersion=false&type=Purple+Software"]];
#endif
	
	
}


// Takes the user to Snake Classic Blog
-(IBAction) blogPressed : (id) sender{
    TSEvent *e = [TSEvent eventWithName:@"help_blog" oneTimeOnly:NO];
    [[TSTapstream instance] fireEvent:e];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://snakeclassic.blogspot.com"]];
	
	
}


// Takes the user to the facebook page of Snake classic
-(IBAction) facebookPressed : (id) sender{
    TSEvent *e = [TSEvent eventWithName:@"help_facebook page" oneTimeOnly:NO];
    [[TSTapstream instance] fireEvent:e];
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
    self.adView = nil;
    [super dealloc];
}


@end
