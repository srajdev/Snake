//
//  GameModeViewController.h
//  SnakeClassic
//
//  Created by Swapan Rajdev on 10/26/10.
//  Copyright 2010 Zing! Apps. All rights reserved.
//  
//  NEW IN V2
//  Description: Screen which allows the user to select the game mode.
//				 The 2 different game modes are classic and extreme
//				 extreme is a time challenge through all levels.
//

#import <UIKit/UIKit.h>

#import "AdWhirlView.h"
#import "AdWhirlDelegateProtocol.h"


@interface GameModeViewController : UIViewController <AdWhirlDelegate> {
	
	
	IBOutlet UIImageView *background;
	AdWhirlView *adView;
	

}

-(IBAction) ClassicPressed : (id) sender;

- (IBAction) ExtremePressed : (id) sender;

-(IBAction) BackPressed :(id)sender;


-(IBAction) helpPressed : (id)sender;

@end
