//
//  helpDetailViewController.m
//  SnakeClassic
//
//  Created by Swapan Rajdev on 11/6/10.
//  Copyright 2010 Zing! Apps. All rights reserved.
//
//   NEW IN V2:
//   Description: this is the detailed view of help which has all the content

#import "helpDetailViewController.h"
#import "SnakeClassicAppDelegate.h"


@implementation helpDetailViewController

@synthesize backButton;

- (void) viewDidLoad{
    
    SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[text setEditable:NO];

    text.backgroundColor = [UIColor colorWithRed:1 green:0.925 blue:0.765 alpha:1];
	
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
        
        CGRect frame = text.frame;
        frame.origin.y = 50 + 104;
        frame.size.height = 50 + 208;
        text.frame = frame;
        
        CGRect btbackFrame = backButton.frame;
        btbackFrame.origin.x = HELPDETAIL_BACK_BUTTON_X;
        btbackFrame.origin.y = 50 + HELPDETAIL_BACK_BUTTON_Y;
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
	
	[text setEditable:NO];
	
	
	if (delegate.helpMode == kGamePlay) {
		text.text = [NSString stringWithFormat:@"Control the snake as it moves around eating apples and increasing in length. Bonus green apples appear for only a few seconds and are double the value of red apples. Game is over when the snake runs into itself or a wall.\n\n\u2022\tClassic Mode\nPlay any one of the 4 fields in typical classic snake style. There is no time limit on how long you can play and your goal is simply to achieve the highest score possible!\n\n\u2022\tExtreme Mode\nTime trial! You get 45 seconds to play each of the 4 fields, starting with the easiest – open field – and ending with the hardest – 4square. Your goal is to get as many points as possible within the 45 seconds on each field.\n\n\u2022\tScoring\nValue of red apple increases with each apple the snake eats. The increase is dependent on the field being played:\n\nOpen Field = 10 points\nBox = 15 points\nHole in the Wall = 20 points\n4square = 25 points\n\nGreen apples are double the value of the red apple being shown at that point.\n\nSo, for example, if you are playing hole in the wall and 3 red apples have been eaten. The value of the next (4th) red apple will be (100 + 3*15) = 145. And value of the green apple will be 2*145 = 290.\n\nIf the red apple is consumed, total score = 100 + 115 + 130 + 145 = 490."];
	}
	else if(delegate.helpMode == kUnlockItems){
	
		text.text = [NSString stringWithFormat:@"Premium fields and wallpapers have to be unlocked using credits. Credits are earned by watching videos from our partner advertisers.\n\nSteps to earn credits\n\u2022\tClick on “Unlock” in the main menu and then click on “Earn Credits”.\n\u2022\tClick on Watch Videos to watch a video to earn credits.\n\u2022\tMake sure to watch till the end of the video to earn your credits\n\u2022\tClick on refresh once you have watched the video to update the balance.\n\n*In most cases, the balance is updated immediately, but it might take up to 30 minutes some times for your credits to show up."];
		
	}
	else if (delegate.helpMode == kFAQ){

		text.text = [NSString stringWithFormat:@"\u2022\tThe friends and global leader board does not load in the Scores menu?\n- Make sure you are connected to the internet to view these scores. It will not load if you are not connected.\n\n\u2022\tCan I change options in the middle of a game in progress?\n- Yes, you can click on pause and go to options and change whatever you like. You can then resume the paused game and the new settings will be active.\n\n\u2022\tCan I close the app and still resume a game?\n- Yes, you can resume a paused game any time. The game is saved even when the app is closed. iOS 4.0 users: You can resume a game even if the app was manually terminated.\n\n\u2022\tAny tips/tricks to succeed at the game?\n- Eat as many green apples as possible, which is possible at faster speeds. However, be careful: at faster speeds it’s harder to control the snake so there is a higher chance of dying."];
	}
	
	
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

-(IBAction) backPressed :(id)sender{
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	if (delegate.pageFrom == kFromStore) {
		[delegate switchView:self.view toview:delegate.storeView.view delay:NO remove:YES display:nil curlup:NO curldown:YES];
	}
	
	if (delegate.pageFrom == kFromGameMode) {
	
		[delegate switchView:self.view toview:delegate.gameModeMenu.view delay:NO remove:YES display:nil curlup:NO curldown:YES];
	}
	
	if (delegate.pageFrom == kFromHelp) {
		[delegate switchView:self.view toview:delegate.helpPage.view delay:NO remove:YES display:nil curlup:NO curldown:YES];
	}
	
	
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void) viewDidDisappear:(BOOL)animated{
    
	
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
