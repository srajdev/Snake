//
//  GameOver.h
//  
//
//  Created by Swapan Rajdev on 8/19/10.
//  Copyright 2010 Zing! Apps. All rights reserved.
//
//  Updats V2: changed functionality to save the scores only locally. Saving of global scores is now done 
//				in the highscore view controller
//
//  Description: This view controller shows handles the game over screen (i.e whent he snake dies)
//  It displays the score of the game, highest score scored on the device so far,
//  Name of the player which can be changed, and options for the user to choose (play again or go to Menu)
//
//
//  Update V1.1: Added functionality to submit high score to the global leaderboard

#import <UIKit/UIKit.h>

#import "FBConnect.h"
//#import "SA_OAuthTwitterController.h"
//#import "SA_OAuthTwitterEngine.h"
//#import "GreystripeDelegate.h"
#import <GameKit/GameKit.h>
#import "GKAchievementHandler.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import "FlurryAdDelegate.h"

@class Difficulty;
@class main_menu;
@class HighScoreRecord;


@interface GameOver : UIViewController <UITextFieldDelegate,
FBDialogDelegate,FBRequestDelegate,FBSessionDelegate, FlurryAdDelegate> {
	
	IBOutlet UIButton *name;
	IBOutlet UILabel *score;
	
	IBOutlet UITextField *changeName;
	
	IBOutlet UILabel *highestScore;
	
	IBOutlet UIImageView *background;
	
    IBOutlet UIButton *playAgain;
    IBOutlet UIButton *mainMenu;
    IBOutlet UIButton *rateAppButton;
    IBOutlet UIButton *FBButton;
    IBOutlet UIButton *TwtButton;
	
    IBOutlet UIImageView *gameOver;
    
	
	
	BOOL isTwitterLogged;
	BOOL playAgainButton;
    BOOL mainMenuButton;
    
	HighScoreRecord *highScore;
	
//	Facebook *facebook;
	
	NSString *FBName;
	NSString *FBid;
	
	int fbSaveCount;
	
	//SA_OAuthTwitterEngine *engine;
	UIViewController *controller;

}

-(IBAction)mainmenu:(id)sender;

-(IBAction)buttonToChangeName;

-(void)saveGame;

-(IBAction) rateApp;


-(IBAction)playAgain:(id)sender;
@property (nonatomic,retain) HighScoreRecord *highScore;

@property (nonatomic,retain) UIButton *name;
@property (nonatomic,retain) UILabel *score;
@property (nonatomic,retain) UITextField *changeName;
@property (nonatomic,retain) IBOutlet UILabel *highestScore;
@property (nonatomic,retain) IBOutlet UIButton *playAgain;
@property (nonatomic,retain) IBOutlet UIButton *mainMenu;
@property (nonatomic,retain) IBOutlet UIButton *rateAppButton;
@property (nonatomic,retain) IBOutlet UIButton *FBButton;
@property (nonatomic,retain) IBOutlet UIButton *TwtButton;

@property (nonatomic,retain) NSString *FBName;
@property (nonatomic,retain) NSString *FBid;
@property int fbSaveCount;
@property BOOL isTwitterLogged;

@property (nonatomic,retain) UIImageView *gameOver;

@property (nonatomic, retain) ACAccount *account;

@property BOOL playAgainButton;
@property BOOL mainMenuButton;

//-(IBAction) FBpublish: (id)sender;
-(IBAction) postToTwitter:(id)sender;
-(IBAction) postToFacebook:(id)sender;
//-(IBAction) tweetIt;
//-(void) postToTwitter;
-(void) submitScore: (int) theScore theName:(NSString *)theName;   //v1.1
-(void) getUserInfo;
//-(id) appSpotRootViewController;

-(void) publishFacebook;


@end
