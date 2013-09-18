//
//  Difficulty.h
//  
//
//  Created by Swapan Rajdev on 8/10/10.
//  Copyright Zing! Apps 2010. All rights reserved.
//
//   Updated version 2: added new outlets to control the background
//
//  Description: This view controller is for the different speeds the game can be played on.



#import <UIKit/UIKit.h>
@class Snake_3ViewController;


@interface Difficulty : UIViewController {
	
	UIButton *speed1;
	UIButton *selectedSpeed1;
	
	UIButton *speed2;
	UIButton *selectedSpeed2;
	
	UIButton *speed3;
	UIButton *selectedSpeed3;
	
	UIButton *speed4;
	UIButton *selectedSpeed4;
	
	UIButton *speed5;
	UIButton *selectedSpeed5;
	
	IBOutlet UIImageView *background;
	
	Snake_3ViewController *gameNew;
	
	IBOutlet UIImageView *smallBackground;
	IBOutlet UIImageView *topBackground;
	
	
	

}

-(IBAction)setDifficulty:(id)sender;

-(IBAction)goPressed:(id)sender;

-(void) setbackground;



@property (nonatomic,retain) IBOutlet UIButton *speed1;

@property (nonatomic,retain) IBOutlet UIButton *selectedSpeed1;

@property (nonatomic,retain) IBOutlet UIButton *speed2;
@property (nonatomic,retain) IBOutlet UIButton *selectedSpeed2;

@property (nonatomic,retain) IBOutlet UIButton *speed3;
@property (nonatomic,retain) IBOutlet UIButton *selectedSpeed3;

@property (nonatomic,retain) IBOutlet UIButton *speed4;
@property (nonatomic,retain) IBOutlet UIButton *selectedSpeed4;

@property (nonatomic,retain) IBOutlet UIButton *speed5;
@property (nonatomic,retain) IBOutlet UIButton *selectedSpeed5;

@property (nonatomic,retain) Snake_3ViewController *gameNew;



@end
