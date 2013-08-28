//
//  HighScoreViewController.h
//  SnakeClassic
//
//  Created by Swapan Rajdev on 9/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HighScores.h"
#import "HighScoreRecord.h"
#import "HighScoreCell.h"


@interface HighScoreViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	
	IBOutlet UITableView *highScoreTable;
	NSArray *highScoreData;

}

@property (nonatomic, retain) UITableView *highScoreTable;
@property (nonatomic, retain) NSArray *highScoreData;
- (void) loadLocalHighScores;

@end
