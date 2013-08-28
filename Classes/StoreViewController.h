//
//  StoreViewController.h
//  SnakeClassic
//
//  Created by Swapan Rajdev on 11/4/10.
//  Copyright 2010 Zing! Apps. All rights reserved.
//
//  NEW IN V2:
//  Description: This is the main store page which the user can use to earn credits/ user credits 
//				 or download the unlocked version

#import <UIKit/UIKit.h>
#import "AdWhirlView.h"
#import "AdWhirlDelegateProtocol.h"


@interface StoreViewController : UIViewController <UIAlertViewDelegate , AdWhirlDelegate> {
	
	
	IBOutlet UIImageView *background;
	
	IBOutlet UILabel *balance;
	
	AdWhirlView *adView;
	
	BOOL goToEarn;

}

@property BOOL goToEarn;



-(IBAction) earnPressed : (id) sender;

-(IBAction) usePressed : (id) sender;

-(IBAction) unlockPressed : (id) sender;

-(IBAction) backPressed : (id) sender;

-(void) showAlert :(NSTimer *)theTimer;
-(IBAction) helpPressed : (id)sender;


@end
