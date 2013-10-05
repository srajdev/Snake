//
//  UnlockViewController.h
//  SnakeClassic
//
//  Created by Swapan Rajdev on 11/4/10.
//  Copyright 2010 Zing! Apps. All rights reserved.
//
//   NEW IN V2:
//   Description: this view is to unlock the theme or a field

#import <UIKit/UIKit.h>
#import "AdWhirlView.h"
#import "AdWhirlDelegateProtocol.h"



@interface UnlockViewController : UIViewController <UIAlertViewDelegate, AdWhirlDelegate> {
	
	IBOutlet UIImageView *background;
	IBOutlet UIImageView *theme;
	IBOutlet UIImageView *themeName;
	
	IBOutlet UILabel *balance;
	
	BOOL canPurchase;
	
	AdWhirlView *adView;

	IBOutlet UIButton *backButton;

}

@property BOOL canPurchase;
@property (nonatomic,retain) IBOutlet UIButton *backButton;

-(IBAction) unlockPressed : (id)sender;
-(IBAction) backPressed : (id)sender;

@end
