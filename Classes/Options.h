//
//  Options.h
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

#import <UIKit/UIKit.h>

#import "AdWhirlView.h"
#import "AdWhirlDelegateProtocol.h"
#import "FBConnect.h"
#import "FBLoginButton.h"


@class main_menu;



@interface Options : UIViewController <UITextFieldDelegate, AdWhirlDelegate, FBSessionDelegate>{
	
	IBOutlet UITextField *name;
	IBOutlet UIButton *orange;
	IBOutlet UIButton *orangeSelected;
	IBOutlet UIButton *green;	
	IBOutlet UIButton *greenSelected;
	IBOutlet UIButton *blue;
	IBOutlet UIButton *blueSelected;
	IBOutlet UIButton *black;
	IBOutlet UIButton *blackSelected;	
	
	
	IBOutlet UIButton *wallOn;
	IBOutlet UIButton *wallOff;
	IBOutlet UIButton *wallOnSelected;
	IBOutlet UIButton *wallOffSelected;
	
	
	IBOutlet UIButton *nameButton;
	
	IBOutlet UIButton *vibrateOn;
	IBOutlet UIButton *vibrateOff;
	IBOutlet UIButton *vibrateOnSelected;
	IBOutlet UIButton *vibrateOffSelected;
	
	
	IBOutlet UIButton *soundOn;
	IBOutlet UIButton *soundOff;
	IBOutlet UIButton *soundOnSelected;
	IBOutlet UIButton *soundOffSelected;
	
	AdWhirlView *adView;
	
	
	IBOutlet FBLoginButton *fbButton;
	
	
	IBOutlet UIImageView *background;
	IBOutlet UIButton *classic;
	IBOutlet UIButton *classicSelected;
	
	IBOutlet UIButton *theme1;
	IBOutlet UIButton *theme1Selected;
	
	IBOutlet UIButton *theme2;
	IBOutlet UIButton *theme2Selected;
	
	IBOutlet UIButton *theme3;
	IBOutlet UIButton *theme3Selected;
	
	IBOutlet UIButton *theme1Locked;
	IBOutlet UIButton *theme2Locked;
	IBOutlet UIButton *theme3Locked;
	
    IBOutlet UIButton *backButton;

	

}
@property (nonatomic,retain) UITextField *name;
@property (nonatomic,retain) IBOutlet UIButton *nameButton;
@property (nonatomic,retain) IBOutlet UIButton *classic;
@property (nonatomic,retain) IBOutlet UIButton *classicSelected;

@property (nonatomic,retain) IBOutlet UIButton *theme1;
@property (nonatomic,retain) IBOutlet UIButton *theme1Selected;
@property (nonatomic,retain) IBOutlet UIButton *theme2;
@property (nonatomic,retain) IBOutlet UIButton *theme2Selected;
@property (nonatomic,retain) IBOutlet UIButton *theme3;
@property (nonatomic,retain) IBOutlet UIButton *theme3Selected;

@property (nonatomic,retain) IBOutlet UIButton *theme1Locked;
@property (nonatomic,retain) IBOutlet UIButton *theme2Locked;
@property (nonatomic,retain) IBOutlet UIButton *theme3Locked;


@property (nonatomic,retain) IBOutlet UIButton *orange;
@property (nonatomic,retain) IBOutlet UIButton *orangeSelected;
@property (nonatomic,retain) IBOutlet UIButton *green;
@property (nonatomic,retain) IBOutlet UIButton *greenSelected;
@property (nonatomic,retain) IBOutlet UIButton *blue;
@property (nonatomic,retain) IBOutlet UIButton *blueSelected;
@property (nonatomic,retain) IBOutlet UIButton *black;
@property (nonatomic,retain) IBOutlet UIButton *blackSelected;

@property (nonatomic,retain) IBOutlet UIButton *vibrateOn;
@property (nonatomic,retain) IBOutlet UIButton *vibrateOff;
@property (nonatomic,retain) IBOutlet UIButton *vibrateOnSelected;
@property (nonatomic,retain) IBOutlet UIButton *vibrateOffSelected;


@property (nonatomic,retain) IBOutlet UIButton *soundOn;
@property (nonatomic,retain) IBOutlet UIButton *soundOff;
@property (nonatomic,retain) IBOutlet UIButton *soundOnSelected;
@property (nonatomic,retain) IBOutlet UIButton *soundOffSelected;

@property (nonatomic,retain) IBOutlet UIButton *backButton;
@property (nonatomic,retain) IBOutlet FBLoginButton *fbButton;



-(IBAction)setSnakeColor:(id)sender;
-(IBAction)backPressed:(id)sender;

-(IBAction)wallPressed:(id)sender;

-(IBAction)buttonToChangeName;

-(IBAction)vibratePressed:(id)sender;

-(IBAction)soundPressed:(id)sender;

- (IBAction) fbButtonClick: (id) sender;

-(IBAction) setTheme : (id)sender;

-(void) updateFBButton;

-(IBAction) lockPressed : (id) sender;





@end
