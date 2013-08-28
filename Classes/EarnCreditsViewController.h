//
//  EarnCreditsViewController.h
//  SnakeClassic
//
//  Created by Swapan Rajdev on 11/5/10.
//  Copyright 2010 Zing! Apps. All rights reserved.
//
//  NEW IN V2:
//  Description: This view is the view to earn credits by downloading apps.


#import <UIKit/UIKit.h>
#import "MyAdView.h"

#import "AdWhirlView.h"
#import "AdWhirlDelegateProtocol.h"



@interface EarnCreditsViewController : UIViewController <AdWhirlDelegate, UIAlertViewDelegate>{
	
	MyAdView *myAdView;
	
	AdWhirlView *adView;
	
	

	IBOutlet UILabel *name;
	
	IBOutlet UILabel *balance;
	
	IBOutlet UIImageView *background;

}


@property (nonatomic,retain) MyAdView *myAdView;

- (IBAction) downloadPressed;

-(IBAction) backPressed;

-(void) refresh;

-(IBAction) refreshPressed;

-(void) showAlert :(NSTimer *)theTimer;
-(void) showAlert_2 :(NSTimer *)theTimer;
@end