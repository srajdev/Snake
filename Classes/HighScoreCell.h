//
//  HighScoreCell.h
//  
//
//  Created by Swapan Rajdev on 9/7/10.
//  Copyright 2010 Zing! Apps. All rights reserved.
//
// Description: This object describes how the high score cell will look in a table

#import <UIKit/UIKit.h>


@interface HighScoreCell : UITableViewCell {
	
	IBOutlet UILabel *rankLabel;
	IBOutlet UILabel *nameLabel;
	IBOutlet UILabel *scoreLabel;
	IBOutlet UILabel *gameMode;

}


@property (nonatomic, retain) UILabel *rankLabel;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *scoreLabel;
@property (nonatomic, retain) UILabel *gameMode;

@end
