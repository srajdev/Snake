//
//  HighScoreCell.m
//  
//
//  Created by Swapan Rajdev on 9/7/10.
//  Copyright 2010 Zing! Apps. All rights reserved.
//
// Description: This object describes how the high score cell will look in a table

#import "HighScoreCell.h"


@implementation HighScoreCell

@synthesize rankLabel;
@synthesize nameLabel;
@synthesize scoreLabel;
@synthesize gameMode;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        // Initialization code
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
	
	
	[rankLabel release];
	[nameLabel release];
	[scoreLabel release];
	[gameMode release];
    [super dealloc];
}


@end
