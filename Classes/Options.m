//
//  Options.m
//
//
//  Created by Swapan Rajdev on 8/11/10.
//  Copyright 2010 Zing! Apps. All rights reserved.
//
//   Update V2: added options to select different themes.
//
//  Description: This View Controller is used to show the option screen to the user
//				 The user can:
//	             Change player name
//				 Have the walls On or Off
//				 Have sound On or Off
//				 Have vibrate On or Off
//				 Choose different colors of the snake.

#import "Options.h"
#import "SnakeClassicAppDelegate.h"
#import "main_menu.h"
#import "FlurryAdDelegate.h"
#import "FlurryAds.h"
#import "Flurry.h"


@implementation Options

@synthesize name;

@synthesize nameButton;
@synthesize black;
@synthesize blackSelected;
@synthesize blue;
@synthesize blueSelected;
@synthesize green;
@synthesize greenSelected;
@synthesize orange;
@synthesize orangeSelected;


@synthesize classic;
@synthesize classicSelected;

@synthesize soundOff;
@synthesize soundOffSelected;
@synthesize soundOn;
@synthesize soundOnSelected;
@synthesize theme1;
@synthesize theme1Selected;
@synthesize theme1Locked;
@synthesize theme2;
@synthesize theme2Selected;
@synthesize theme2Locked;
@synthesize theme3;
@synthesize theme3Selected;
@synthesize theme3Locked;
@synthesize vibrateOff;
@synthesize vibrateOffSelected;
@synthesize vibrateOn;
@synthesize vibrateOnSelected;
@synthesize fbButton;
@synthesize backButton;

//static NSString* kFBAppId = @"158392174179755";




// Function to get AdWhirl key
-(NSString *)adWhirlApplicationKey{

	return kSampleAppKey;
	
}


- (UIViewController *)viewControllerForPresentingModalView {
	return self;
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
	//	permissions =  [[NSArray arrayWithObjects: 
	//					  @"read_stream", @"offline_access",nil] retain];
	}
	
	return self;
}

-(void) viewDidLoad{

	//facebook = [[Facebook alloc] init];
	
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	[nameButton setTitle:delegate.playerName forState:UIControlStateNormal];
	name.hidden = YES;
	
	
	theme1.enabled = YES;
	theme2.enabled = YES;
	theme3.enabled = YES;
	theme1Locked.hidden = YES;
	theme2Locked.hidden = YES;
	theme3Locked.hidden = YES;
	
    
    
    
	if (delegate.theme == kClassicTheme) {
		classic.hidden = YES;
		classicSelected.hidden = NO;
		
		
		if (delegate.gardenUnlocked == NO) {
			theme1.hidden = NO;
			theme1Selected.hidden = YES;
			theme1.enabled = NO;
			theme1Locked.hidden = NO;
		}
		else{
			theme1.hidden = NO;
			theme1Selected.hidden = YES;
		}
		
		
		
		if (delegate.beachUnlocked == NO) {
			theme2.hidden = NO;
			theme2Selected.hidden = YES;
			theme2.enabled = NO;
			theme2Locked.hidden = NO;
		}
		else{
			theme2.hidden = NO;
			theme2Selected.hidden = YES;
		}
		
		if (delegate.nightUnlocked == NO) {
			theme3.hidden = NO;
			theme3Selected.hidden = YES;
			theme3.enabled = NO;
			theme3Locked.hidden = NO;
		}
		else{
			theme3.hidden = NO;
			theme3Selected.hidden = YES;
		}
		
		
		[nameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        if(IS_IPHONE_5){
            self.view.frame = CGRectMake(0, 0, 320, 568);
            [background setFrame:CGRectMake(0, 0, 320, 568)];
            background.image = [UIImage imageNamed:@"_Options_Classic.png"];
        }
        else{
            background.image = [UIImage imageNamed:@"_0000_classic_options.png"];
        }
	}
	else if(delegate.theme == kTheme1){
		classic.hidden = NO;
		classicSelected.hidden = YES;
		
		
		if (delegate.gardenUnlocked == NO) {
			theme1.hidden = NO;
			theme1Selected.hidden = YES;
			theme1.enabled = NO;
			theme1Locked.hidden = NO;
		}
		else{
			theme1.hidden = YES;
			theme1Selected.hidden = NO;
		}
		
		
		
		if (delegate.beachUnlocked == NO) {
			theme2.hidden = NO;
			theme2Selected.hidden = YES;
			theme2.enabled = NO;
			theme2Locked.hidden = NO;
		}
		else{
			theme2.hidden = NO;
			theme2Selected.hidden = YES;
		}
		
		if (delegate.nightUnlocked == NO) {
			theme3.hidden = NO;
			theme3Selected.hidden = YES;
			theme3.enabled = NO;
			theme3Locked.hidden = NO;
		}
		else{
			theme3.hidden = NO;
			theme3Selected.hidden = YES;
		}
		
		[nameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        if(IS_IPHONE_5){
             self.view.frame = CGRectMake(0, 0, 320, 568);
            [background setFrame:CGRectMake(0, 0, 320, 568)];
            background.image = [UIImage imageNamed:@"_Options_Garden.png"];
        }
        else{
            background.image = [UIImage imageNamed:@"_0000_theme1_options.png"];
        }
    }
	else if(delegate.theme == kTheme2){
		classic.hidden = NO;
		classicSelected.hidden = YES;
		
		
		if (delegate.gardenUnlocked == NO) {
			theme1.hidden = NO;
			theme1Selected.hidden = YES;
			theme1.enabled = NO;
			theme1Locked.hidden = NO;
		}
		else{
			theme1.hidden = NO;
			theme1Selected.hidden = YES;
		}
		
		
		
		if (delegate.beachUnlocked == NO) {
			theme2.hidden = NO;
			theme2Selected.hidden = YES;
			theme2.enabled = NO;
			theme2Locked.hidden = NO;
		}
		else{
			theme2.hidden = YES;
			theme2Selected.hidden = NO;
		}
		
		if (delegate.nightUnlocked == NO) {
			theme3.hidden = NO;
			theme3Selected.hidden = YES;
			theme3.enabled = NO;
			theme3Locked.hidden = NO;
		}
		else{
			theme3.hidden = NO;
			theme3Selected.hidden = YES;
		}
		[nameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		if(IS_IPHONE_5){
             self.view.frame = CGRectMake(0, 0, 320, 568);
            [background setFrame:CGRectMake(0, 0, 320, 568)];
            background.image = [UIImage imageNamed:@"_Options_Beach.png"];
        }
        else{
            background.image = [UIImage imageNamed:@"_0000_theme2_options.png"];
        }
	}
	else if(delegate.theme == kTheme3){
		classic.hidden = NO;
		classicSelected.hidden = YES;
		
		
		if (delegate.gardenUnlocked == NO) {
			theme1.hidden = NO;
			theme1Selected.hidden = YES;
			theme1.enabled = NO;
			theme1Locked.hidden = NO;
		}
		else{
			theme1.hidden = NO;
			theme1Selected.hidden = YES;
		}
		
		
		
		if (delegate.beachUnlocked == NO) {
			theme2.hidden = NO;
			theme2Selected.hidden = YES;
			theme2.enabled = NO;
			theme2Locked.hidden = NO;
		}
		else{
			theme2.hidden = NO;
			theme2Selected.hidden = YES;
		}
		
		if (delegate.nightUnlocked == NO) {
			theme3.hidden = NO;
			theme3Selected.hidden = YES;
			theme3.enabled = NO;
			theme3Locked.hidden = NO;
		}
		else{
			theme3.hidden = YES;
			theme3Selected.hidden = NO;
		}
		
		
		
		[nameButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
		if(IS_IPHONE_5){
             self.view.frame = CGRectMake(0, 0, 320, 568);
            [background setFrame:CGRectMake(0, 0, 320, 568)];
            background.image = [UIImage imageNamed:@"_Options_Night.png"];
        }
        else{
            background.image = [UIImage imageNamed:@"_0000_theme3_options.png"];
        }
	}
	
	
	if (delegate.snakeColor == [UIColor greenColor]) {
		greenSelected.hidden = NO;
		green.hidden = YES;
		orangeSelected.hidden = YES;
		orange.hidden = NO;
		blueSelected.hidden = YES;
		blue.hidden = NO;
		blackSelected.hidden = YES;
		black.hidden = NO;
	}
    
	else if (delegate.snakeColor == [UIColor blueColor]) {
		greenSelected.hidden = YES;
		green.hidden = NO;
		orangeSelected.hidden = YES;
		orange.hidden = NO;
		blueSelected.hidden = NO;
		blue.hidden = YES;
		blackSelected.hidden = YES;
		black.hidden = NO;
	}
	else if (delegate.snakeColor == [UIColor orangeColor]) {
		greenSelected.hidden = YES;
		green.hidden = NO;
		orangeSelected.hidden = NO;
		orange.hidden = YES;
		blueSelected.hidden = YES;
		blue.hidden = NO;
		blackSelected.hidden = YES;
		black.hidden = NO;
	}
	else if (delegate.snakeColor == [UIColor blackColor]) {
		greenSelected.hidden = YES;
		green.hidden = NO;
		orangeSelected.hidden = YES;
		orange.hidden = NO;
		blueSelected.hidden = YES;
		blue.hidden = NO;
		blackSelected.hidden = NO;
		black.hidden = YES;
	}
	
	
	
	if (delegate.isWallOn == NO) {
		wallOn.hidden = NO;
		wallOnSelected.hidden = YES;
		
		wallOff.hidden = YES;
		wallOffSelected.hidden = NO;
	}
	else if(delegate.isWallOn == YES){
		wallOn.hidden = YES;
		wallOnSelected.hidden = NO;
		
		wallOff.hidden = NO;
		wallOffSelected.hidden = YES;
		
	}
	
	
	if (delegate.isVibrateOn == NO) {
		vibrateOn.hidden = NO;
		vibrateOnSelected.hidden = YES;
		
		vibrateOff.hidden = YES;
		vibrateOffSelected.hidden = NO;
	}
	else if(delegate.isVibrateOn == YES){
		vibrateOn.hidden = YES;
		vibrateOnSelected.hidden = NO;
		
		vibrateOff.hidden = NO;
		vibrateOffSelected.hidden = YES;
		
	}
	
	if (delegate.isSoundOn == NO) {
		soundOn.hidden = NO;
		soundOnSelected.hidden = YES;
		
		soundOff.hidden = YES;
		soundOffSelected.hidden = NO;
	}
	else if(delegate.isSoundOn == YES){
		soundOn.hidden = YES;
		soundOnSelected.hidden = NO;
		
		soundOff.hidden = NO;
		soundOffSelected.hidden = YES;
		
	}
    
    if(IS_IPHONE_5){
        
        
        CGRect btNFrame = name.frame;
        btNFrame.origin.x = OPTIONS_NAME_BUTTON_X;
        btNFrame.origin.y = 65 + OPTIONS_NAME_BUTTON_Y;
        name.frame = btNFrame;
        
        CGRect btNameFrame = nameButton.frame;
        btNameFrame.origin.x = OPTIONS_NAME_BUTTON_X;
        btNameFrame.origin.y = 65 + OPTIONS_NAME_BUTTON_Y;
        nameButton.frame = btNameFrame;
        
        CGRect btclassicFrame = classic.frame;
        btclassicFrame.origin.x = OPTIONS_THEME_BUTTON_X;
        btclassicFrame.origin.y = 140 + OPTIONS_NAME_BUTTON_Y;
        classic.frame = btclassicFrame;
        
        CGRect btclassicSelectedFrame = classicSelected.frame;
        btclassicSelectedFrame.origin.x = OPTIONS_THEME_BUTTON_X;
        btclassicSelectedFrame.origin.y = 140 + OPTIONS_NAME_BUTTON_Y;
        classicSelected.frame = btclassicSelectedFrame;
        
        CGRect bttheme1Frame = theme1.frame;
        bttheme1Frame.origin.x = 110 + OPTIONS_THEME_BUTTON_X;
        bttheme1Frame.origin.y = 140 + OPTIONS_NAME_BUTTON_Y;
        theme1.frame = bttheme1Frame;
        
        CGRect bttheme1SelectedFrame = theme1Selected.frame;
        bttheme1SelectedFrame.origin.x = 110 + OPTIONS_THEME_BUTTON_X;
        bttheme1SelectedFrame.origin.y = 140 + OPTIONS_NAME_BUTTON_Y;
        theme1Selected.frame = bttheme1SelectedFrame;
        
        CGRect bttheme1LockedFrame = theme1Locked.frame;
        bttheme1LockedFrame.origin.x = 110 + OPTIONS_THEME_BUTTON_X;
        bttheme1LockedFrame.origin.y = 140 + OPTIONS_NAME_BUTTON_Y;
        theme1Locked.frame = bttheme1LockedFrame;
        
        CGRect bttheme2Frame = theme2.frame;
        bttheme2Frame.origin.x = OPTIONS_THEME_BUTTON_X;
        bttheme2Frame.origin.y = 180 + OPTIONS_NAME_BUTTON_Y;
        theme2.frame = bttheme2Frame;
        
        CGRect bttheme2SelectedFrame = theme2Selected.frame;
        bttheme2SelectedFrame.origin.x = OPTIONS_THEME_BUTTON_X;
        bttheme2SelectedFrame.origin.y = 180 + OPTIONS_NAME_BUTTON_Y;
        theme2Selected.frame = bttheme2SelectedFrame;
        
        CGRect bttheme2LockedFrame = theme2Locked.frame;
        bttheme2LockedFrame.origin.x = OPTIONS_THEME_BUTTON_X;
        bttheme2LockedFrame.origin.y = 180 + OPTIONS_NAME_BUTTON_Y;
        theme2Locked.frame = bttheme2LockedFrame;
        
        CGRect bttheme3Frame = theme3.frame;
        bttheme3Frame.origin.x = 110 + OPTIONS_THEME_BUTTON_X;
        bttheme3Frame.origin.y = 180 + OPTIONS_NAME_BUTTON_Y;
        theme3.frame = bttheme3Frame;
        
        CGRect bttheme3SelectedFrame = theme1Selected.frame;
        bttheme3SelectedFrame.origin.x = 110 + OPTIONS_THEME_BUTTON_X;
        bttheme3SelectedFrame.origin.y = 180 + OPTIONS_NAME_BUTTON_Y;
        theme3Selected.frame = bttheme1SelectedFrame;
        
        CGRect bttheme3LockedFrame = theme3Locked.frame;
        bttheme3LockedFrame.origin.x = 110 + OPTIONS_THEME_BUTTON_X;
        bttheme3LockedFrame.origin.y = 180 + OPTIONS_NAME_BUTTON_Y;
        theme3Locked.frame = bttheme3LockedFrame;
        
        CGRect btsoundOnFrame = soundOn.frame;
        btsoundOnFrame.origin.x = 15 + OPTIONS_SOUND_BUTTON_X;
        btsoundOnFrame.origin.y = 55 + OPTIONS_SOUND_BUTTON_Y;
        soundOn.frame = btsoundOnFrame;
        
        CGRect btsoundOnSelectedFrame = soundOnSelected.frame;
        btsoundOnSelectedFrame.origin.x = 15 + OPTIONS_SOUND_BUTTON_X;
        btsoundOnSelectedFrame.origin.y = 55 + OPTIONS_SOUND_BUTTON_Y;
        soundOnSelected.frame = btsoundOnSelectedFrame;
        
        CGRect btsoundOffFrame = soundOff.frame;
        btsoundOffFrame.origin.x = 97 + OPTIONS_SOUND_BUTTON_X;
        btsoundOffFrame.origin.y = 55 + OPTIONS_SOUND_BUTTON_Y;
        soundOff.frame = btsoundOffFrame;
        
        CGRect btsoundOffSelectedFrame = soundOffSelected.frame;
        btsoundOffSelectedFrame.origin.x = 97 + OPTIONS_SOUND_BUTTON_X;
        btsoundOffSelectedFrame.origin.y = 55 + OPTIONS_SOUND_BUTTON_Y;
        soundOffSelected.frame = btsoundOffSelectedFrame;
        
        CGRect btvibrateOnFrame = vibrateOn.frame;
        btvibrateOnFrame.origin.x = 15 + OPTIONS_SOUND_BUTTON_X;
        btvibrateOnFrame.origin.y = 110 + OPTIONS_SOUND_BUTTON_Y;
        vibrateOn.frame = btvibrateOnFrame;
        
        CGRect btvibrateOnSelectedFrame = vibrateOnSelected.frame;
        btvibrateOnSelectedFrame.origin.x = 15 + OPTIONS_SOUND_BUTTON_X;
        btvibrateOnSelectedFrame.origin.y = 110 + OPTIONS_SOUND_BUTTON_Y;
        vibrateOnSelected.frame = btvibrateOnSelectedFrame;
        
        CGRect btvibrateOffFrame = vibrateOff.frame;
        btvibrateOffFrame.origin.x = 97 + OPTIONS_SOUND_BUTTON_X;
        btvibrateOffFrame.origin.y = 110 + OPTIONS_SOUND_BUTTON_Y;
        vibrateOff.frame = btvibrateOffFrame;
        
        CGRect btvibrateOffSelectedFrame = vibrateOffSelected.frame;
        btvibrateOffSelectedFrame.origin.x = 97 + OPTIONS_SOUND_BUTTON_X;
        btvibrateOffSelectedFrame.origin.y = 110 + OPTIONS_SOUND_BUTTON_Y;
        vibrateOffSelected.frame = btvibrateOffSelectedFrame;
        
        CGRect btgreenFrame = green.frame;
        btgreenFrame.origin.x = 13 + OPTIONS_COLOR_BUTTON_X;
        btgreenFrame.origin.y = 75 + OPTIONS_COLOR_BUTTON_Y;
        green.frame = btgreenFrame;
        
        CGRect btgreenSelectedFrame = greenSelected.frame;
        btgreenSelectedFrame.origin.x = OPTIONS_COLOR_BUTTON_X;
        btgreenSelectedFrame.origin.y = 77 + OPTIONS_COLOR_BUTTON_Y;
        greenSelected.frame = btgreenSelectedFrame;
        
        CGRect btorangeFrame = orange.frame;
        btorangeFrame.origin.x = 56 + OPTIONS_COLOR_BUTTON_X;
        btorangeFrame.origin.y = 75 + OPTIONS_COLOR_BUTTON_Y;
        orange.frame = btorangeFrame;
        
        CGRect btorangeSelectedFrame = orangeSelected.frame;
        btorangeSelectedFrame.origin.x = 43 + OPTIONS_COLOR_BUTTON_X;
        btorangeSelectedFrame.origin.y = 77 + OPTIONS_COLOR_BUTTON_Y;
        orangeSelected.frame = btorangeSelectedFrame;
        
        CGRect btblackFrame = black.frame;
        btblackFrame.origin.x = 99 + OPTIONS_COLOR_BUTTON_X;
        btblackFrame.origin.y = 75 + OPTIONS_COLOR_BUTTON_Y;
        black.frame = btblackFrame;
        
        CGRect btblackSelectedFrame = blackSelected.frame;
        btblackSelectedFrame.origin.x = 86 + OPTIONS_COLOR_BUTTON_X;
        btblackSelectedFrame.origin.y = 77 + OPTIONS_COLOR_BUTTON_Y;
        blackSelected.frame = btblackSelectedFrame;
        
        CGRect btblueFrame = blue.frame;
        btblueFrame.origin.x = 142 + OPTIONS_COLOR_BUTTON_X;
        btblueFrame.origin.y = 75 + OPTIONS_COLOR_BUTTON_Y;
        blue.frame = btblueFrame;
        
        CGRect btblueSelectedFrame = blueSelected.frame;
        btblueSelectedFrame.origin.x = 129 + OPTIONS_COLOR_BUTTON_X;
        btblueSelectedFrame.origin.y = 77 + OPTIONS_COLOR_BUTTON_Y;
        blueSelected.frame = btblueSelectedFrame;
        
        CGRect btbackFrame = backButton.frame;
        btbackFrame.origin.x = OPTIONS_BACK_BUTTON_X;
        btbackFrame.origin.y = 80 + OPTIONS_BACK_BUTTON_Y;
        backButton.frame = btbackFrame;
        
        CGRect btfbButtonFrame = fbButton.frame;
        btfbButtonFrame.origin.x = OPTIONS_FB_BUTTON_X;
        btfbButtonFrame.origin.y = 80 + OPTIONS_FB_BUTTON_Y;
        fbButton.frame = btfbButtonFrame;
        
    }
	
}



- (void) viewDidAppear:(BOOL)animated{
	
	[[UIApplication sharedApplication] setStatusBarHidden:YES];

	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	/*
    [nameButton setTitle:delegate.playerName forState:UIControlStateNormal];
	name.hidden = YES;
	
	
	theme1.enabled = YES;
	theme2.enabled = YES;
	theme3.enabled = YES;
	theme1Locked.hidden = YES;
	theme2Locked.hidden = YES;
	theme3Locked.hidden = YES;
	
    
    
    
	if (delegate.theme == kClassicTheme) {
		classic.hidden = YES;
		classicSelected.hidden = NO;
		
		
		if (delegate.gardenUnlocked == NO) {
			theme1.hidden = NO;
			theme1Selected.hidden = YES;
			theme1.enabled = NO;
			theme1Locked.hidden = NO;
		}
		else{
			theme1.hidden = NO;
			theme1Selected.hidden = YES;
		}
		
		
		
		if (delegate.beachUnlocked == NO) {
			theme2.hidden = NO;
			theme2Selected.hidden = YES;
			theme2.enabled = NO;
			theme2Locked.hidden = NO;
		}
		else{
			theme2.hidden = NO;
			theme2Selected.hidden = YES;
		}
		
		if (delegate.nightUnlocked == NO) {
			theme3.hidden = NO;
			theme3Selected.hidden = YES;
			theme3.enabled = NO;
			theme3Locked.hidden = NO;
		}
		else{
			theme3.hidden = NO;
			theme3Selected.hidden = YES;
		}
		
		
		[nameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        if(IS_IPHONE_5){
            [background setFrame:CGRectMake(0, 0, 320, 568)];
            background.image = [UIImage imageNamed:@"_Options_Classic.png"];
        }
        else{
		background.image = [UIImage imageNamed:@"_0000_classic_options.png"];
        }
	}
	else if(delegate.theme == kTheme1){
		classic.hidden = NO;
		classicSelected.hidden = YES;
		
		
		if (delegate.gardenUnlocked == NO) {
			theme1.hidden = NO;
			theme1Selected.hidden = YES;
			theme1.enabled = NO;
			theme1Locked.hidden = NO;
		}
		else{
			theme1.hidden = YES;
			theme1Selected.hidden = NO;
		}
		
		
		
		if (delegate.beachUnlocked == NO) {
			theme2.hidden = NO;
			theme2Selected.hidden = YES;
			theme2.enabled = NO;
			theme2Locked.hidden = NO;
		}
		else{
			theme2.hidden = NO;
			theme2Selected.hidden = YES;
		}
		
		if (delegate.nightUnlocked == NO) {
			theme3.hidden = NO;
			theme3Selected.hidden = YES;
			theme3.enabled = NO;
			theme3Locked.hidden = NO;
		}
		else{
			theme3.hidden = NO;
			theme3Selected.hidden = YES;
		}
		
		[nameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        if(IS_IPHONE_5){
            [background setFrame:CGRectMake(0, 0, 320, 568)];
            background.image = [UIImage imageNamed:@"_Options_Garden.png"];
        }
        else{
		background.image = [UIImage imageNamed:@"_0000_theme1_options.png"];
        }
    }
	else if(delegate.theme == kTheme2){
		classic.hidden = NO;
		classicSelected.hidden = YES;
		
		
		if (delegate.gardenUnlocked == NO) {
			theme1.hidden = NO;
			theme1Selected.hidden = YES;
			theme1.enabled = NO;
			theme1Locked.hidden = NO;
		}
		else{
			theme1.hidden = NO;
			theme1Selected.hidden = YES;
		}
		
		
		
		if (delegate.beachUnlocked == NO) {
			theme2.hidden = NO;
			theme2Selected.hidden = YES;
			theme2.enabled = NO;
			theme2Locked.hidden = NO;
		}
		else{
			theme2.hidden = YES;
			theme2Selected.hidden = NO;
		}
		
		if (delegate.nightUnlocked == NO) {
			theme3.hidden = NO;
			theme3Selected.hidden = YES;
			theme3.enabled = NO;
			theme3Locked.hidden = NO;
		}
		else{
			theme3.hidden = NO;
			theme3Selected.hidden = YES;
		}
		[nameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		if(IS_IPHONE_5){
            [background setFrame:CGRectMake(0, 0, 320, 568)];
            background.image = [UIImage imageNamed:@"_Options_Beach.png"];
        }
        else{
        background.image = [UIImage imageNamed:@"_0000_theme2_options.png"];
        }
	}
	else if(delegate.theme == kTheme3){
		classic.hidden = NO;
		classicSelected.hidden = YES;
		
		
		if (delegate.gardenUnlocked == NO) {
			theme1.hidden = NO;
			theme1Selected.hidden = YES;
			theme1.enabled = NO;
			theme1Locked.hidden = NO;
		}
		else{
			theme1.hidden = NO;
			theme1Selected.hidden = YES;
		}
		
		
		
		if (delegate.beachUnlocked == NO) {
			theme2.hidden = NO;
			theme2Selected.hidden = YES;
			theme2.enabled = NO;
			theme2Locked.hidden = NO;
		}
		else{
			theme2.hidden = NO;
			theme2Selected.hidden = YES;
		}
		
		if (delegate.nightUnlocked == NO) {
			theme3.hidden = NO;
			theme3Selected.hidden = YES;
			theme3.enabled = NO;
			theme3Locked.hidden = NO;
		}
		else{
			theme3.hidden = YES;
			theme3Selected.hidden = NO;
		}
		
		
		
		[nameButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
		if(IS_IPHONE_5){
            [background setFrame:CGRectMake(0, 0, 320, 568)];
            background.image = [UIImage imageNamed:@"_Options_Night.png"];
        }
        else{
		background.image = [UIImage imageNamed:@"_0000_theme3_options.png"];
        }
	}
	
	
	if (delegate.snakeColor == [UIColor greenColor]) {
		greenSelected.hidden = NO;
		green.hidden = YES;
		orangeSelected.hidden = YES;
		orange.hidden = NO;
		blueSelected.hidden = YES;
		blue.hidden = NO;
		blackSelected.hidden = YES;
		black.hidden = NO;
	}

	else if (delegate.snakeColor == [UIColor blueColor]) {
		greenSelected.hidden = YES;
		green.hidden = NO;
		orangeSelected.hidden = YES;
		orange.hidden = NO;
		blueSelected.hidden = NO;
		blue.hidden = YES;
		blackSelected.hidden = YES;
		black.hidden = NO;
	}
	else if (delegate.snakeColor == [UIColor orangeColor]) {
		greenSelected.hidden = YES;
		green.hidden = NO;
		orangeSelected.hidden = NO;
		orange.hidden = YES;
		blueSelected.hidden = YES;
		blue.hidden = NO;
		blackSelected.hidden = YES;
		black.hidden = NO;
	}
	else if (delegate.snakeColor == [UIColor blackColor]) {
		greenSelected.hidden = YES;
		green.hidden = NO;
		orangeSelected.hidden = YES;
		orange.hidden = NO;
		blueSelected.hidden = YES;
		blue.hidden = NO;
		blackSelected.hidden = NO;
		black.hidden = YES;
	}
	
	
	
	if (delegate.isWallOn == NO) {
		wallOn.hidden = NO;
		wallOnSelected.hidden = YES;
		
		wallOff.hidden = YES;
		wallOffSelected.hidden = NO;
	}
	else if(delegate.isWallOn == YES){
		wallOn.hidden = YES;
		wallOnSelected.hidden = NO;
		
		wallOff.hidden = NO;
		wallOffSelected.hidden = YES;
		
	}
	
	
	if (delegate.isVibrateOn == NO) {
		vibrateOn.hidden = NO;
		vibrateOnSelected.hidden = YES;
		
		vibrateOff.hidden = YES;
		vibrateOffSelected.hidden = NO;
	}
	else if(delegate.isVibrateOn == YES){
		vibrateOn.hidden = YES;
		vibrateOnSelected.hidden = NO;
		
		vibrateOff.hidden = NO;
		vibrateOffSelected.hidden = YES;
		
	}
	
	if (delegate.isSoundOn == NO) {
		soundOn.hidden = NO;
		soundOnSelected.hidden = YES;
		
		soundOff.hidden = YES;
		soundOffSelected.hidden = NO;
	}
	else if(delegate.isSoundOn == YES){
		soundOn.hidden = YES;
		soundOnSelected.hidden = NO;
		
		soundOff.hidden = NO;
		soundOffSelected.hidden = YES;
		
	}
	*/
#ifdef LITE_VERSION
    
    [FlurryAds setAdDelegate:self];
	[FlurryAds fetchAndDisplayAdForSpace:@"BANNER_MAIN_VIEW" view:self.view size:BANNER_BOTTOM];
	
    
    // Code specific to lite version

	//[adView doNotIgnoreNewAdRequests];
//	[adView doNotIgnoreAutoRefreshTimer];
	
	
	//adView = [AdWhirlView requestAdWhirlViewWithDelegate:self];
	/*adView = delegate.mainmenu.adView;
	if(IS_IPHONE_5){
        
        adView.frame = CGRectMake(0.0, 520.0, 320.0, 50.0);
        
    }
    else{
	adView.frame = CGRectMake(0.0, 432.0, 320.0, 50.0);
	}
*/
#endif	
	
	fbButton.isLoggedIn = delegate.FBLoggedIn;
	
	[super viewDidLoad];
	
	
#ifdef LITE_VERSION
//	[self.view addSubview:adView];
#endif
	
	[fbButton updateImage];
	
	
}


// There is a lock on the ulocked themes. If this is pressed user is taken to the store to earn credits

-(IBAction) lockPressed : (id) sender{
	
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	//[delegate switchView:self.view toview:delegate.storeView.view delay:NO remove:YES display:nil curlup:YES curldown:NO];
	
	
	UIButton *buttonPressed = (UIButton *)sender;
	
	delegate.unlockFromAnother = 1;
	
	if (buttonPressed.tag == 0) {
		delegate.creditsInfo = kGarden;
	}
	
	if (buttonPressed.tag == 1) {
		delegate.creditsInfo = kBeach;
	}
	
	
	if (buttonPressed.tag == 2) {
		delegate.creditsInfo = kNight;
	}
	
	
	
	
	
	
	
	[delegate switchView:self.view toview:delegate.unlockView.view delay:NO remove:YES display:nil curlup:YES curldown:NO];
	
	
	
	
	
}

-(void) updateFBButton{
	
	
	[fbButton updateImage];
}



///////////////////////////////////////////////////////////////////////////////////////////////////
// IBAction

/**
 * Login/out button click
 */
- (IBAction) fbButtonClick: (id) sender {
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	if (fbButton.isLoggedIn || delegate.FBLoggedIn) {
		[delegate logout];
		//fbButton.isLoggedIn = NO;
		//delegate.FBLoggedIn = NO;
		
	} else {
		[delegate login];
		//fbButton.isLoggedIn = YES;
		//delegate.FBLoggedIn = YES;
	}
	[fbButton updateImage];
}


- (void) viewDidDisappear:(BOOL)animated{
	
    [FlurryAds removeAdFromSpace:@"BANNER_MAIN_VIEW"];
    [FlurryAds setAdDelegate:nil];

//	[adView ignoreNewAdRequests];
	
//	[adView ignoreAutoRefreshTimer];
	
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

// Action that is called when different themes are pressed


-(IBAction) setTheme : (id)sender{

	UIButton *buttonPressed = (UIButton *)sender;
	
	theme1.enabled = YES;
	theme2.enabled = YES;
	theme3.enabled = YES;
	theme1Locked.hidden = YES;
	theme2Locked.hidden = YES;
	theme3Locked.hidden = YES;
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	if (buttonPressed.tag == 0) {
		[Flurry logEvent:@"options/classic theme"];
		classic.hidden = YES;
		classicSelected.hidden = NO;
		
		
		if (delegate.gardenUnlocked == NO) {
			theme1.hidden = NO;
			theme1Selected.hidden = YES;
			theme1.enabled = NO;
			theme1Locked.hidden = NO;
		}
		else{
			theme1.hidden = NO;
			theme1Selected.hidden = YES;
		}
		

		
		if (delegate.beachUnlocked == NO) {
			theme2.hidden = NO;
			theme2Selected.hidden = YES;
			theme2.enabled = NO;
			theme2Locked.hidden = NO;
		}
		else{
			theme2.hidden = NO;
			theme2Selected.hidden = YES;
		}
		
		if (delegate.nightUnlocked == NO) {
			theme3.hidden = NO;
			theme3Selected.hidden = YES;
			theme3.enabled = NO;
			theme3Locked.hidden = NO;
		}
		else{
			theme3.hidden = NO;
			theme3Selected.hidden = YES;
		}
		
		delegate.theme = kClassicTheme;
		[nameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		if(IS_IPHONE_5){
            [background setFrame:CGRectMake(0, 0, 320, 568)];
            background.image = [UIImage imageNamed:@"_Options_Classic.png"];
        }
        else{
		background.image = [UIImage imageNamed:@"_0000_classic_options.png"];
		}
	
	}
	else if(buttonPressed.tag == 1){
	
		[Flurry logEvent:@"options/garden theme"];
		classic.hidden = NO;
		classicSelected.hidden = YES;
		
		
		if (delegate.gardenUnlocked == NO) {
			theme1.hidden = NO;
			theme1Selected.hidden = YES;
			theme1.enabled = NO;
			theme1Locked.hidden = NO;
		}
		else{
			theme1.hidden = YES;
			theme1Selected.hidden = NO;
		}
		
		
		
		if (delegate.beachUnlocked == NO) {
			theme2.hidden = NO;
			theme2Selected.hidden = YES;
			theme2.enabled = NO;
			theme2Locked.hidden = NO;
		}
		else{
			theme2.hidden = NO;
			theme2Selected.hidden = YES;
		}
		
		if (delegate.nightUnlocked == NO) {
			theme3.hidden = NO;
			theme3Selected.hidden = YES;
			theme3.enabled = NO;
			theme3Locked.hidden = NO;
		}
		else{
			theme3.hidden = NO;
			theme3Selected.hidden = YES;
		}
		
		delegate.theme = kTheme1;
		
		[nameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        if(IS_IPHONE_5){
            [background setFrame:CGRectMake(0, 0, 320, 568)];
            background.image = [UIImage imageNamed:@"_Options_Garden.png"];
        }
        else{
		background.image = [UIImage imageNamed:@"_0000_theme1_options.png"];
		}
		
	}
	else if(buttonPressed.tag == 2){
		[Flurry logEvent:@"options/beach theme"];
		
		classic.hidden = NO;
		classicSelected.hidden = YES;
		
		
		if (delegate.gardenUnlocked == NO) {
			theme1.hidden = NO;
			theme1Selected.hidden = YES;
			theme1.enabled = NO;
			theme1Locked.hidden = NO;
		}
		else{
			theme1.hidden = NO;
			theme1Selected.hidden = YES;
		}
		
		
		
		if (delegate.beachUnlocked == NO) {
			theme2.hidden = NO;
			theme2Selected.hidden = YES;
			theme2.enabled = NO;
			theme2Locked.hidden = NO;
		}
		else{
			theme2.hidden = YES;
			theme2Selected.hidden = NO;
		}
		
		if (delegate.nightUnlocked == NO) {
			theme3.hidden = NO;
			theme3Selected.hidden = YES;
			theme3.enabled = NO;
			theme3Locked.hidden = NO;
		}
		else{
			theme3.hidden = NO;
			theme3Selected.hidden = YES;
		}
		
		delegate.theme = kTheme2;
		
		[nameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		if(IS_IPHONE_5){
            [background setFrame:CGRectMake(0, 0, 320, 568)];
            background.image = [UIImage imageNamed:@"_Options_Beach.png"];
        }
        else{
		background.image = [UIImage imageNamed:@"_0000_theme2_options.png"];
		}
		
	}
	else if(buttonPressed.tag == 3){
		[Flurry logEvent:@"options/night theme"];
		
		classic.hidden = NO;
		classicSelected.hidden = YES;
		
		
		if (delegate.gardenUnlocked == NO) {
			theme1.hidden = NO;
			theme1Selected.hidden = YES;
			theme1.enabled = NO;
			theme1Locked.hidden = NO;
		}
		else{
			theme1.hidden = NO;
			theme1Selected.hidden = YES;
		}
		
		
		
		if (delegate.beachUnlocked == NO) {
			theme2.hidden = NO;
			theme2Selected.hidden = YES;
			theme2.enabled = NO;
			theme2Locked.hidden = NO;
		}
		else{
			theme2.hidden = NO;
			theme2Selected.hidden = YES;
		}
		
		if (delegate.nightUnlocked == NO) {
			theme3.hidden = NO;
			theme3Selected.hidden = YES;
			theme3.enabled = NO;
			theme3Locked.hidden = NO;
		}
		else{
			theme3.hidden = YES;
			theme3Selected.hidden = NO;
		}
		
		delegate.theme = kTheme3;
		
		[nameButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
		if(IS_IPHONE_5){
            [background setFrame:CGRectMake(0, 0, 320, 568)];
            background.image = [UIImage imageNamed:@"_Options_Night.png"];
        }
        else{
		background.image = [UIImage imageNamed:@"_0000_theme3_options.png"];
		}
		
	}
	
	
}

// Action that takes place when different colors are choosen for the snake.

-(IBAction)setSnakeColor:(id)sender{

	UIButton *buttonPressed = (UIButton *)sender;
	
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	
	
	
	if (buttonPressed.tag == 0 ) {
		greenSelected.hidden = YES;
		green.hidden = NO;
		orangeSelected.hidden = NO;
		orange.hidden = YES;
		blueSelected.hidden = YES;
		blue.hidden = NO;
		blackSelected.hidden = YES;
		black.hidden = NO;
		delegate.snakeColor = [UIColor orangeColor];
		
		
	}
	else if(buttonPressed.tag == 3){
		greenSelected.hidden = YES;
		green.hidden = NO;
		orangeSelected.hidden = YES;
		orange.hidden = NO;
		blueSelected.hidden = NO;
		blue.hidden = YES;
		blackSelected.hidden = YES;
		black.hidden = NO;
		delegate.snakeColor = [UIColor blueColor];
		
	}
	else if(buttonPressed.tag == 1){
		greenSelected.hidden = NO;
		green.hidden = YES;
		orangeSelected.hidden = YES;
		orange.hidden = NO;
		blueSelected.hidden = YES;
		blue.hidden = NO;
		blackSelected.hidden = YES;
		black.hidden = NO;
		delegate.snakeColor = [UIColor greenColor];
		
	}
	else if(buttonPressed.tag == 2){
		greenSelected.hidden = YES;
		green.hidden = NO;
		orangeSelected.hidden = YES;
		orange.hidden = NO;
		blueSelected.hidden = YES;
		blue.hidden = NO;
		blackSelected.hidden = NO;
		black.hidden = YES;
		delegate.snakeColor = [UIColor blackColor];
		
	}
	
	
	
	

}

// Action that takes place to change wall settings

-(IBAction)wallPressed:(id)sender{
	
	UIButton *butttonPressed = (UIButton *)sender;
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	if (butttonPressed.tag == 0) {
		
			delegate.isWallOn = YES;
		
			
		
		
		wallOnSelected.hidden = NO;
		wallOn.hidden = YES;
		wallOff.hidden = NO;
		wallOffSelected.hidden = YES;
		
	}
	else if(butttonPressed.tag == 1){
		
			delegate.isWallOn = NO;
		
	
		
		wallOnSelected.hidden = YES;
		wallOn.hidden = NO;
		wallOff.hidden = YES;
		wallOffSelected.hidden = NO;
	}
	
	
}


// Action that takes place to change vibrate settings

-(IBAction)vibratePressed:(id)sender{
	UIButton *butttonPressed = (UIButton *)sender;
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	if (butttonPressed.tag == 0) {
		
		delegate.isVibrateOn = YES;
		
		
		
		vibrateOnSelected.hidden = NO;
		vibrateOn.hidden = YES;
		vibrateOff.hidden = NO;
		vibrateOffSelected.hidden = YES;
		
	}
	else if(butttonPressed.tag == 1){
		
		delegate.isVibrateOn = NO;
		
		
		vibrateOnSelected.hidden = YES;
		vibrateOn.hidden = NO;
		vibrateOff.hidden = YES;
		vibrateOffSelected.hidden = NO;
	}
	
	
	
}


// Action that takes place to change sound settings
-(IBAction)soundPressed:(id)sender{
	UIButton *butttonPressed = (UIButton *)sender;
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	if (butttonPressed.tag == 0) {
		
		delegate.isSoundOn = YES;
		
		
		
		soundOnSelected.hidden = NO;
		soundOn.hidden = YES;
		soundOff.hidden = NO;
		soundOffSelected.hidden = YES;
		
	}
	else if(butttonPressed.tag == 1){
		
		delegate.isSoundOn = NO;
		
		
		soundOnSelected.hidden = YES;
		soundOn.hidden = NO;
		soundOff.hidden = YES;
		soundOffSelected.hidden = NO;
	}
	
	
	
}



// Action that takes place when back is pressed.Takes the user back to the main menu screen

-(IBAction)backPressed:(id)sender{
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	

	[delegate switchView:self.view toview:delegate.mainmenu.view delay:NO remove:YES display:nil curlup:NO curldown:YES];

	
	
}

// Action that takes place when the user wants to change name


-(IBAction)buttonToChangeName{
	
	[Flurry logEvent:@"Settings/Change Player"];
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	nameButton.hidden = YES;
	name.borderStyle = UITextBorderStyleNone;
	name.hidden = NO;
	name.placeholder = delegate.playerName;
	[name becomeFirstResponder];
	
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	[textField resignFirstResponder];
	
	
	if ([textField.text length] != 0) {
		delegate.playerName = textField.text;
				delegate.playerName = name.text;
	}	
	
	
	nameButton.hidden = NO;
	name.hidden = YES;
		

	
	[nameButton setTitle:delegate.playerName forState:UIControlStateNormal];
	
	return NO;
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
	[name release];
	[nameButton release];
	
	
    [super dealloc];
}


@end
