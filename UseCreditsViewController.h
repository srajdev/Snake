//
//  UseCreditsViewController.h
//  SnakeClassic
//
//  Created by Swapan Rajdev on 11/4/10.
//  Copyright 2010 Zing! Apps. All rights reserved.
//
//  NEW IN V2
//  Description: This view is used to use the credits to unlock the different themes and fields

#import <UIKit/UIKit.h>

#import <GameKit/GameKit.h>


@interface UseCreditsViewController : UIViewController {
	
	IBOutlet UILabel *balance;
	
	
	IBOutlet UIButton *beach;
	IBOutlet UIButton *beachUnlocked;
	
	IBOutlet UIButton *garden;
	IBOutlet UIButton *gardenUnlocked;
	
	IBOutlet UIButton *night;
	IBOutlet UIButton *nightUnlocked;
	
	IBOutlet UIButton *hole;
	IBOutlet UIButton *holeUnlocked;
	
	IBOutlet UIButton *square;
	IBOutlet UIButton *squareUnlocked;
	
    IBOutlet UIButton *backButton;
    
	IBOutlet UIImageView *background;
	
	

}

@property (nonatomic,retain) IBOutlet UIButton *garden;
@property (nonatomic,retain) IBOutlet UIButton *gardenUnlocked;
@property (nonatomic,retain) IBOutlet UIButton *beach;
@property (nonatomic,retain) IBOutlet UIButton *beachUnlocked;
@property (nonatomic,retain) IBOutlet UIButton *night;
@property (nonatomic,retain) IBOutlet UIButton *nightUnlocked;
@property (nonatomic,retain) IBOutlet UIButton *hole;
@property (nonatomic,retain) IBOutlet UIButton *holeUnlocked;
@property (nonatomic,retain) IBOutlet UIButton *square;
@property (nonatomic,retain) IBOutlet UIButton *squareUnlocked;
@property (nonatomic,retain) IBOutlet UIButton *backButton;
@property (nonatomic,retain) IBOutlet UILabel *balance;

-(IBAction) viewPressed : (id) sender;

-(IBAction) backPressed : (id) sender;



@end
