//
//  helpDetailViewController.h
//  SnakeClassic
//
//  Created by Swapan Rajdev on 11/6/10.
//  Copyright 2010 Zing! Apps. All rights reserved.
//
//   NEW IN V2:
//   Description: this is the detailed view of help which has all the content

#import <UIKit/UIKit.h>
#import "AdWhirlView.h"
#import "AdWhirlDelegateProtocol.h"
#import "main_menu.h"


@interface helpDetailViewController : UIViewController <AdWhirlDelegate> {
	
	IBOutlet UITextView *text;
	
	
	AdWhirlView *adView;
	
	IBOutlet UIImageView *background;

}

-(IBAction) backPressed :(id)sender;

@end
