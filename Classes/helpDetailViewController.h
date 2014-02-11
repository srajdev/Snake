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

#import "main_menu.h"
#import "MPAdView.h"


@interface helpDetailViewController : UIViewController <MPAdViewDelegate>{
	
	IBOutlet UITextView *text;	
	IBOutlet UIImageView *background;
    IBOutlet UIButton *backButton;

}

@property (nonatomic,retain) IBOutlet UIButton *backButton;
@property (nonatomic, retain) MPAdView *adView;

-(IBAction) backPressed :(id)sender;

@end
