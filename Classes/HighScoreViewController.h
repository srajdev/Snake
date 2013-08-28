//
//  HighScoreViewController.h
//  
//
//  Created by Swapan Rajdev on 9/7/10.
//  Copyright 2010 Zing! Apps. All rights reserved.
//
//  Update V2: We are now saving the score when the user preses Friends or Global.
//             and once it is saved we then display the scores.
//			   Also displaying what mode the user scored the high score in
//
// Description: this View controller is used to show all the high scores in a Table
// Update V1.1: Added facebook and global leaderboards

#import <UIKit/UIKit.h>

#import "HighScoreCell.h"
#import "HighScoreRecord.h"
#import "HighScores.h"
#import "main_menu.h"

#import "AdWhirlView.h"
#import "AdWhirlDelegateProtocol.h"
#import "FBConnect.h"



@interface HighScoreViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,AdWhirlDelegate,
FBDialogDelegate, FBSessionDelegate, FBRequestDelegate, UIAlertViewDelegate> {
	
	IBOutlet UITableView *highScoreTable;
	NSArray *highScoreData;
	
	AdWhirlView *adView;
	
	bool isLocal;
	bool isFriends;
	bool isGlobal;
	
	NSMutableArray *friendsInfo;
	
	IBOutlet UIActivityIndicatorView *activity;
	
	IBOutlet UIButton *localButton;
	IBOutlet UIButton *localSelectedButton;
	
	IBOutlet UIButton *friendsButton;
	IBOutlet UIButton *friendsSelectedButton;
	
	IBOutlet UIButton *globalButton;
	IBOutlet UIButton *globalSelectedButton;
	
	IBOutlet UIImageView *background;
	
	NSString *FBName;
	NSString *FBid;
	
	BOOL saveGame;
	

}


@property (nonatomic,retain) NSString *FBName;
@property (nonatomic,retain) NSString *FBid;
@property BOOL saveGame;


@property (nonatomic, retain) UITableView *highScoreTable;
@property (nonatomic, retain) NSArray *highScoreData;
@property bool isLocal;
@property bool isFriends;
@property bool isGlobal;
@property (nonatomic,retain) NSMutableArray *friendsInfo;
@property (nonatomic,retain) UIActivityIndicatorView *activity;

-(void) showAlert ;


- (void) loadLocalHighScores;
-(IBAction)backPressed:(id)sender;
-(void) loadFriendsHighScore;
-(void) loadGlobalHighScores;
-(void) getFriendInfo;

-(IBAction) localPressed;
-(IBAction) globalPressed;
-(IBAction) friendsPressed;

-(void) globalPressedTime:(NSTimer *)theTimer;


-(void) submitScore: (int) theScore theName:(NSString *)theName theMode:(NSString *)gameMode;
-(void)saveTheGame;
-(void) getUserInfo;

-(void)submitScore;


@end
