//
//  FieldModeViewController.h
//  SnakeClassic
//
//  Created by Swapan Rajdev on 10/26/10.
//  Copyright 2010 Zing! Apps. All rights reserved.
//
//  NEW IN V2
//  Description: This screen lets the user choose which maze/Field he wants to play
//				 There are 4 different mazes. 
//				 
#import <UIKit/UIKit.h>


@interface FieldModeViewController : UIViewController {
	
	
	IBOutlet UIButton *openField;
	IBOutlet UIButton *openFieldSelected;
	
	
	IBOutlet UIButton *box;
	IBOutlet UIButton *boxSelected;
	
	
	IBOutlet UIButton *hole;
	IBOutlet UIButton *holeSelected;
	IBOutlet UIButton *holeLocked;
	
	IBOutlet UIButton *square;
	IBOutlet UIButton *squareSelected;
	IBOutlet UIButton *squareLocked;
	
	IBOutlet UIImageView *smallBackground;
	
	IBOutlet UIImageView *background;
	IBOutlet UIImageView *topBackground;

}

-(IBAction) OpenFieldPressed:(id)sender;
-(IBAction) BoxPressed:(id)sender;
-(IBAction) HoleWallPressed:(id)sender;
-(IBAction) SquarePressed:(id)sender;
-(IBAction) NextPressed:(id)sender;

-(IBAction) lockPressed : (id) sender;

-(void) setbackground;

@end
