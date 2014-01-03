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


@interface StoreViewController : UIViewController <UIAlertViewDelegate> {
	
	
	IBOutlet UIImageView *background;
	
	IBOutlet UILabel *balance;
	
	
	
	BOOL goToEarn;
    
    IBOutlet UIButton *earnButton;
    IBOutlet UIButton *useButton;
    IBOutlet UIButton *helpButton;
    IBOutlet UIButton *backButton;

}

@property BOOL goToEarn;
@property (nonatomic,retain) IBOutlet UIButton *earnButton;
@property (nonatomic,retain) IBOutlet UIButton *useButton;
@property (nonatomic,retain) IBOutlet UIButton *helpButton;
@property (nonatomic,retain) IBOutlet UIButton *backButton;
@property (nonatomic,retain) IBOutlet UILabel *balance;

-(IBAction) earnPressed : (id) sender;

-(IBAction) usePressed : (id) sender;

-(IBAction) unlockPressed : (id) sender;

-(IBAction) backPressed : (id) sender;

-(void) showAlert :(NSTimer *)theTimer;
-(IBAction) helpPressed : (id)sender;
-(NSString *)appSpotMillennialAppKey;


@end
