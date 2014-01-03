//
//  UnlockViewController.m
//  SnakeClassic
//
//  Created by Swapan Rajdev on 11/4/10.
//  Copyright 2010 Zing! Apps. All rights reserved.
//
//   NEW IN V2:
//   Description: this view is to unlock the theme or a field

#import "UnlockViewController.h"
#import "SnakeClassicAppDelegate.h"
#import "main_menu.h"
#import "Options.h"
#import "FieldModeViewController.h"
#import "FlurryAdDelegate.h"
#import "FlurryAds.h"
#import "Flurry.h"

@implementation UnlockViewController

@synthesize canPurchase;
@synthesize backButton;
@synthesize balance;

-(void) viewDidLoad{
    
    SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	
	balance.text = [NSString stringWithFormat:@"%d Cr",delegate.userBalance];
	
    if (delegate.theme == kClassicTheme) {
        if(IS_IPHONE_5){
            [background setFrame:CGRectMake(0, 0, 320, 568)];
            background.image = [UIImage imageNamed:@"main-menu_classic.png"];
        }
        else{
            background.image = [UIImage imageNamed:@"Classic.png"];
        }
        balance.textColor = [UIColor whiteColor];
    }
    
	else if(delegate.theme == kTheme1){
		if(IS_IPHONE_5){
            [background setFrame:CGRectMake(0, 0, 320, 568)];
            background.image = [UIImage imageNamed:@"main_menu_garden.png"];
        }
        else{
            background.image = [UIImage imageNamed:@"Theme1.png"];
        }
        balance.textColor = [UIColor yellowColor];

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
        balance.textColor = [UIColor darkTextColor];
    }
	else if(delegate.theme == kTheme3){
		if(IS_IPHONE_5){
            [background setFrame:CGRectMake(0, 0, 320, 568)];
            background.image = [UIImage imageNamed:@"main_menu_night.png"];
        }
        else{
            background.image = [UIImage imageNamed:@"Theme3.png"];
        }
        balance.textColor = [UIColor whiteColor];
    }
    
    if(IS_IPHONE_5) {
        self.view.frame = CGRectMake(0, 0, 320, 568);
        
        CGRect btbackFrame = backButton.frame;
        btbackFrame.origin.x = HELPDETAIL_BACK_BUTTON_X;
        btbackFrame.origin.y = 90 + HELPDETAIL_BACK_BUTTON_Y;
        backButton.frame = btbackFrame;
    }
	
    
}

- (void) viewWillAppear:(BOOL)animated{
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	
	balance.text = [NSString stringWithFormat:@"%d Cr",delegate.userBalance];
	
	
	if (delegate.creditsInfo == kGarden) {
		
		themeName.image = [UIImage imageNamed:@"_0000_garden_theme1.png"];
		theme.image = [UIImage imageNamed:@"_0000_unlock_theme1.png"];
		
	}
	
	else if(delegate.creditsInfo == kBeach){
		
		themeName.image = [UIImage imageNamed:@"_0000_beach_theme2.png"];
		theme.image = [UIImage imageNamed:@"_0000_unlock_theme2.png"];
		
	}
			
	else if(delegate.creditsInfo == kNight){
		themeName.image = [UIImage imageNamed:@"_0000_night_theme3.png"];
		theme.image = [UIImage imageNamed:@"_0000_unlock_theme3.png"];
		
	}
	else if(delegate.creditsInfo == kHole){
		themeName.image = [UIImage imageNamed:@"_0000_hole_field.png"];
		theme.image = [UIImage imageNamed:@"_0000_unlock_hole.png"];
		
	}
	else if(delegate.creditsInfo == kSquare){
		themeName.image = [UIImage imageNamed:@"_0000_square_field.png"];
		theme.image = [UIImage imageNamed:@"_0000_unlock_square.png"];
		
	}
	
    [FlurryAds setAdDelegate:self];
   /* if(IS_IPHONE_5){
    //cretate a UIView to hold the Flurry banner ad, with desired position and size
        UIView *flurryContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 250, self.view.frame.size.width, 50)];
    
        [self.view addSubview:flurryContainer];
    //fetch the ad with the newly created UIView
        [FlurryAds fetchAndDisplayAdForSpace:@"BANNER_MAIN_VIEW" view:flurryContainer size:BANNER_BOTTOM];
    }
    else{
    */
        [FlurryAds fetchAndDisplayAdForSpace:@"BANNER_MAIN_VIEW" view:self.view size:BANNER_BOTTOM];
	//}
    
//	[adView doNotIgnoreNewAdRequests];
//	[adView doNotIgnoreAutoRefreshTimer];
	
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

// Action that unlocks the theme or the field
-(IBAction) unlockPressed : (id)sender{
	
	
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	
	if ((delegate.creditsInfo == kGarden || delegate.creditsInfo == kBeach || delegate.creditsInfo == kNight) && delegate.userBalance < 20)	{
		canPurchase = NO;
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Snake Classic" message:@"You do not have enough credits to unlock this theme." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Earn Credits",nil];
		
		[alert show];
		
	}
	
	else if ((delegate.creditsInfo == kHole || delegate.creditsInfo == kSquare) && delegate.userBalance < 30) {
		canPurchase = NO;
        
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Snake Classic" message:@"You do not have enough credits to unlock this field." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Earn Credits",nil];
		
		[alert show];
	}
	
	else {
	

		if (delegate.creditsInfo == kGarden) {
			[Flurry logEvent:@"view/unlock garden"];
			delegate.gardenUnlocked = YES;
			canPurchase = YES;
		
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congratulations!" message:@"You have unlocked the wallpaper 'Garden'. You can apply it in the Options menu. Enjoy!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Continue" ,nil];
		
			[alert show];
		
		}
		else if (delegate.creditsInfo == kBeach){
			[Flurry logEvent:@"view/unlock beach"];
			delegate.beachUnlocked = YES;
			canPurchase = YES;
			
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congratulations!" message:@"You have unlocked the wallpaper 'Beach'. You can apply it in the Options menu. Enjoy!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Continue",nil];
			
			[alert show];
		}
		else if(delegate.creditsInfo == kNight){
			[Flurry logEvent:@"view/unlock night"];
			delegate.nightUnlocked = YES;
			canPurchase = YES;
			
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congratulations!" message:@"You have unlocked the wallpaper 'Night'. You can apply it in the Options menu. Enjoy!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Continue",nil];
			
			[alert show];
		}
		else if (delegate.creditsInfo == kHole){
			[Flurry logEvent:@"view/unlock hitw"];
	
			delegate.holeUnlocked = YES;
			canPurchase = YES;
			
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congratulations!" message:@"You have unlocked the field 'Hole in the Wall'. Enjoy!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Continue" ,nil];
			
			[alert show];
		}
		else if(delegate.creditsInfo == kSquare){
			[Flurry logEvent:@"view/unlock 4sq"];
	
			delegate.squareUnlocked = YES;
			canPurchase = YES;
			
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congratulations!" message:@"You have unlocked the field '4Square'. Enjoy!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Continue" ,nil];
			
			[alert show];
		
		}
	}

}



// Alert view to tells the user they have successfully unlocked the theme or field
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	
	if(buttonIndex == 0 && canPurchase == YES)
	{
		
		SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
		
		[delegate switchView:self.view toview:delegate.useCreditsView.view delay:NO remove:YES display:nil curlup:NO curldown:YES];
		
		
	}
	else if (buttonIndex == 1){
		SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
		
		[delegate switchView:self.view toview:delegate.earnView.view delay:NO remove:YES display:nil curlup:YES curldown:NO];
		
	}

}

-(IBAction) backPressed : (id)sender{
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	if (delegate.unlockFromAnother == 0) {
		[delegate switchView:self.view toview:delegate.useCreditsView.view delay:NO remove:YES display:nil curlup:NO curldown:YES];
	}
	else if (delegate.unlockFromAnother == 1){
		
		[delegate switchView:self.view toview:delegate.optionMenu.view delay:NO remove:YES display:nil curlup:NO curldown:YES];
	}
	else if(delegate.unlockFromAnother == 2){
	
		[delegate switchView:self.view toview:delegate.fieldModeMenu.view delay:NO remove:YES display:nil curlup:NO curldown:YES];
		
	}
	else {
		[delegate switchView:self.view toview:delegate.useCreditsView.view delay:NO remove:YES display:nil curlup:NO curldown:YES];
	}
	
}

- (void) viewDidDisappear:(BOOL)animated{
    
    [FlurryAds removeAdFromSpace:@"BANNER_MAIN_VIEW"];
    [FlurryAds setAdDelegate:nil];
    
	
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
