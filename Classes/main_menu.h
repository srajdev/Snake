//
//  main_menu.h
//  
//
//  Created by Swapan Rajdev on 8/10/10.
//  Copyright 2010 Zing! Apps. All rights reserved.
//
//  Updater V2: added help page icon which takes user to help page.
//              In locked version we have Store icon which takes user to the store to earn credits
//				In unlocked veresion we still have more apps
//
//  Description: This View Controller is used to show the main menu of the game.
//                The main menu contains all the different buttons for the user.
//                New game: for the user to start a new game
//				  Resume: To resume an already exisitng game
//				  Score: To view local high scores
//				  More Apps: to view more apps
//				  Option: to change different options of the game


#import <UIKit/UIKit.h>
#import "AdWhirlView.h"
#import "AdWhirlDelegateProtocol.h"
#import <GameKit/GameKit.h>



@class Difficulty;
@class Options;
@class HighScoreView;
@class HighScoreViewController;



@interface main_menu : UIViewController <AdWhirlDelegate,UIAlertViewDelegate, GKAchievementViewControllerDelegate>{
	
	
	
	UIButton *newgamebutton;
	UIButton *optionbutton;
	
	UIButton *resumebutton;
	
	
	NSTimer *resumeTimer;
	
	AdWhirlView *adView;
	
	IBOutlet UIImageView *background;
	
	
	IBOutlet UIButton *storeButton;
	IBOutlet UIButton *moreButton;
	
	
}



@property (nonatomic,retain) IBOutlet UIButton *newgamebutton;
@property (nonatomic,retain) IBOutlet UIButton *optionbutton;
@property (nonatomic,retain) IBOutlet UIButton *resumebutton;

@property (nonatomic,retain) AdWhirlView *adView;




@property (nonatomic,retain) 	NSTimer *resumeTimer;




-(IBAction)newgame:(id)sender;
-(IBAction)options:(id)sender;
-(IBAction)resume:(id)sender;
-(IBAction)scores:(id)sender;
-(IBAction)storePressed:(id)sender;
-(IBAction)moreApps:(id)sender;
-(IBAction) helpPressed : (id)sender;
-(void) showAlert :(NSTimer *)theTimer;
-(void) showAlert_2;
-(IBAction) checkAchievements;
-(IBAction) clearAchievements;


@end
