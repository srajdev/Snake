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




@interface HelpPageViewController : UIViewController {
	
	
	IBOutlet UIImageView *background;
	
	IBOutlet UIButton *unlockButton;
    
    IBOutlet UIButton *gameplayButton;
    IBOutlet UIButton *faqButton;
    IBOutlet UIButton *rateButton;
    IBOutlet UIButton *blogButton;
    IBOutlet UIButton *facebookButton;
    IBOutlet UIButton *backButton;
}

@property (nonatomic,retain) IBOutlet UIButton *gameplayButton;
@property (nonatomic,retain) IBOutlet UIButton *faqButton;
@property (nonatomic,retain) IBOutlet UIButton *unlockButton;
@property (nonatomic,retain) IBOutlet UIButton *rateButton;
@property (nonatomic,retain) IBOutlet UIButton *blogButton;
@property (nonatomic,retain) IBOutlet UIButton *facebookButton;
@property (nonatomic,retain) IBOutlet UIButton *backButton;

-(IBAction) buttonPressed : (id)sender;

-(IBAction) backPressed : (id)sender;

-(IBAction) rateGame : (id) sender;

-(IBAction) blogPressed : (id) sender;

-(IBAction) facebookPressed : (id) sender;

@end
