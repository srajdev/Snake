//
//  HelpPageViewController.h
//  SnakeClassic
//
//  Created by Swapan Rajdev on 11/6/10.
//  Copyright 2010 Zing! Apps. All rights reserved.
//
//  NEW IN V2:
//  Descirption: This is the help page which gives the user all the information of all the different feature of the game

#import <UIKit/UIKit.h>

#import "AdWhirlView.h"
#import "AdWhirlDelegateProtocol.h"


@interface HelpPageViewController : UIViewController <AdWhirlDelegate> {
	
	AdWhirlView *adView;
	
	IBOutlet UIImageView *background;
	
	IBOutlet UIButton *unlockButton;

}


-(IBAction) buttonPressed : (id)sender;

-(IBAction) backPressed : (id)sender;

-(IBAction) rateGame : (id) sender;

-(IBAction) blogPressed : (id) sender;

-(IBAction) facebookPressed : (id) sender;

@end
