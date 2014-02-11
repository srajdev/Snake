//
//  Difficulty.m
//  
//
//  Created by Swapan Rajdev on 8/10/10.
//  Copyright Zing! Apps 2010. All rights reserved.
//
//   Updated version 2: added new outlets to control the background
//  
//  Description: This view controller is for the different speeds the game can be played on.
//

#import "Difficulty.h"
#import "SnakeClassicAppDelegate.h"
#import "Snake_3ViewController.h"
#import "TSTapstream.h"

@implementation Difficulty

@synthesize speed1;
@synthesize selectedSpeed1;

@synthesize speed2;
@synthesize selectedSpeed2;

@synthesize speed3;
@synthesize selectedSpeed3;

@synthesize speed4;
@synthesize selectedSpeed4;

@synthesize speed5;
@synthesize selectedSpeed5;

@synthesize topImage;

@synthesize gameNew;


/* Action that is called whent he GO button of the game is pressed */
-(IBAction)goPressed:(id)sender{
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	delegate.gameStatus = kGameActive;
	
    
    TSEvent *e = [TSEvent eventWithName:@"Difficulty_Options" oneTimeOnly:NO];
    [e addValue:[NSNumber numberWithInt:delegate.speed] forKey:@"speed"];
    [e addValue:[NSNumber numberWithBool:delegate.isSoundOn] forKey:@"sound"];
    [e addValue:[NSNumber numberWithBool:delegate.isVibrateOn] forKey:@"vibration"];
    [e addValue:[NSNumber numberWithBool:delegate.isWallOn] forKey:@"walls"];
    [e addValue:[NSNumber numberWithInt:delegate.snakeColor] forKey:@"snake_color"];
    [[TSTapstream instance] fireEvent:e];
	
	gameNew = [[Snake_3ViewController alloc] initWithNibName:@"Snake_3ViewController" bundle:nil];
	
	delegate.activeGame = gameNew;
	
	
	
	[delegate switchView:self.view toview:gameNew.view delay:NO remove:YES display:nil curlup:NO curldown:NO];
}


/* Action that happens when a user tries to change the speed of the game */

-(IBAction)setDifficulty:(id)sender{
	
	
	
	

	UIButton *buttonPressed = (UIButton *)sender;
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	
	
	
	


	
	if (buttonPressed.tag == 1 ) {
		delegate.speed = 1;
		speed1.hidden = YES;
		selectedSpeed1.hidden = NO;
		
		speed2.hidden = NO;
		selectedSpeed2.hidden = YES;
		
		speed3.hidden = NO;
		selectedSpeed3.hidden = YES;
		
		speed4.hidden = NO;
		selectedSpeed4.hidden = YES;
		
		speed5.hidden = NO;
		selectedSpeed5.hidden = YES;
		
		
	}
	else if(buttonPressed.tag == 2){
		delegate.speed = 2;
		speed1.hidden = NO;
		selectedSpeed1.hidden = YES;
		
		speed2.hidden = YES;
		selectedSpeed2.hidden = NO;
		
		speed3.hidden = NO;
		selectedSpeed3.hidden = YES;
		
		speed4.hidden = NO;
		selectedSpeed4.hidden = YES;
		
		speed5.hidden = NO;
		selectedSpeed5.hidden = YES;
				
	}
	else if(buttonPressed.tag == 3){
		delegate.speed = 3;
		speed1.hidden = NO;
		selectedSpeed1.hidden = YES;
		
		speed2.hidden = NO;
		selectedSpeed2.hidden = YES;
		
		speed3.hidden = YES;
		selectedSpeed3.hidden = NO;
		
		speed4.hidden = NO;
		selectedSpeed4.hidden = YES;
		
		speed5.hidden = NO;
		selectedSpeed5.hidden = YES;
				
	}else if(buttonPressed.tag == 4){
		delegate.speed = 4;
		speed1.hidden = NO;
		selectedSpeed1.hidden = YES;
		
		speed2.hidden = NO;
		selectedSpeed2.hidden = YES;
		
		speed3.hidden = NO;
		selectedSpeed3.hidden = YES;
		
		speed4.hidden = YES;
		selectedSpeed4.hidden = NO;
		
		speed5.hidden = NO;
		selectedSpeed5.hidden = YES;
				
	}
	else if(buttonPressed.tag == 5){
		delegate.speed = 5;
		speed1.hidden = NO;
		selectedSpeed1.hidden = YES;
		
		speed2.hidden = NO;
		selectedSpeed2.hidden = YES;
		
		speed3.hidden = NO;
		selectedSpeed3.hidden = YES;
		
		speed4.hidden = NO;
		selectedSpeed4.hidden = YES;
		
		speed5.hidden = YES;
		selectedSpeed5.hidden = NO;
		
	}
	
	
	
	
	
	
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

-(void) viewDidLoad{	
	
	[self setbackground];
    
   // [super viewDidLoad];
	
}

- (void)viewDidAppear:(BOOL)animated{
    if(IS_IPHONE_5){
        //[topBackground setFrame:CGRectMake(0, 0, 320, 388)];
    }
}


-(void) viewWillAppear:(BOOL)animated{

	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[self setbackground];
	
	if (delegate.speed == 1 ) {

		speed1.hidden = YES;
		selectedSpeed1.hidden = NO;
		
		speed2.hidden = NO;
		selectedSpeed2.hidden = YES;
		
		speed3.hidden = NO;
		selectedSpeed3.hidden = YES;
		
		speed4.hidden = NO;
		selectedSpeed4.hidden = YES;
		
		speed5.hidden = NO;
		selectedSpeed5.hidden = YES;
		
		
	}
	else if(delegate.speed== 2){

		speed1.hidden = NO;
		selectedSpeed1.hidden = YES;
		
		speed2.hidden = YES;
		selectedSpeed2.hidden = NO;
		
		speed3.hidden = NO;
		selectedSpeed3.hidden = YES;
		
		speed4.hidden = NO;
		selectedSpeed4.hidden = YES;
		
		speed5.hidden = NO;
		selectedSpeed5.hidden = YES;
		
	}
	else if(delegate.speed == 3){

		speed1.hidden = NO;
		selectedSpeed1.hidden = YES;
		
		speed2.hidden = NO;
		selectedSpeed2.hidden = YES;
		
		speed3.hidden = YES;
		selectedSpeed3.hidden = NO;
		
		speed4.hidden = NO;
		selectedSpeed4.hidden = YES;
		
		speed5.hidden = NO;
		selectedSpeed5.hidden = YES;
		
	}else if(delegate.speed == 4){

		speed1.hidden = NO;
		selectedSpeed1.hidden = YES;
		
		speed2.hidden = NO;
		selectedSpeed2.hidden = YES;
		
		speed3.hidden = NO;
		selectedSpeed3.hidden = YES;
		
		speed4.hidden = YES;
		selectedSpeed4.hidden = NO;
		
		speed5.hidden = NO;
		selectedSpeed5.hidden = YES;
		
	}
	else if(delegate.speed== 5){

		speed1.hidden = NO;
		selectedSpeed1.hidden = YES;
		
		speed2.hidden = NO;
		selectedSpeed2.hidden = YES;
		
		speed3.hidden = NO;
		selectedSpeed3.hidden = YES;
		
		speed4.hidden = NO;
		selectedSpeed4.hidden = YES;
		
		speed5.hidden = YES;
		selectedSpeed5.hidden = NO;
		
	}
    
	if (delegate.snakeColor == [UIColor greenColor]) {
		if (delegate.fieldMode == kNoWall) {
            if(IS_IPHONE_5){
                //[topBackground setFrame:CGRectMake(0, 0, 320, 388)];
                topBackground.image = [UIImage imageNamed:@"_green_open.png"];
            }
            else{
                topBackground.image = [UIImage imageNamed:@"green_open.png"];
            }
		}
		else if(delegate.fieldMode == kFullWall){
			if(IS_IPHONE_5){
                //[topBackground setFrame:CGRectMake(0, 0, 320, 388)];
                topBackground.image = [UIImage imageNamed:@"_green_box.png"];
            }
            else{
                topBackground.image = [UIImage imageNamed:@"green_box.png"];
            }
		}
		else if(delegate.fieldMode == kHoleWall){
			if(IS_IPHONE_5){
                //[topBackground setFrame:CGRectMake(0, 0, 320, 388)];
                topBackground.image = [UIImage imageNamed:@"_green_hitw.png"];
            }
            else{
                topBackground.image = [UIImage imageNamed:@"green_hitw.png"];
            }
		}
		else if(delegate.fieldMode == kSquareWall){
			if(IS_IPHONE_5){
                //[topBackground setFrame:CGRectMake(0, 0, 320, 388)];
                topBackground.image = [UIImage imageNamed:@"_green_4sq.png"];
            }
            else{
                topBackground.image = [UIImage imageNamed:@"green_4sq.png"];
            }
		}
		
	}
	else if (delegate.snakeColor == [UIColor orangeColor]) {
		if (delegate.fieldMode == kNoWall) {
            if(IS_IPHONE_5){
                //[topBackground setFrame:CGRectMake(0, 0, 320, 388)];
                topBackground.image = [UIImage imageNamed:@"_orange_open.png"];
            }
            else{
                topBackground.image = [UIImage imageNamed:@"orange_open.png"];
            }
		}
		else if(delegate.fieldMode == kFullWall){
			if(IS_IPHONE_5){
                //[topBackground setFrame:CGRectMake(0, 0, 320, 388)];
                topBackground.image = [UIImage imageNamed:@"_orange_box.png"];
            }
            else{
                topBackground.image = [UIImage imageNamed:@"orange_box.png"];
            }
		}
		else if(delegate.fieldMode == kHoleWall){
			if(IS_IPHONE_5){
                //[topBackground setFrame:CGRectMake(0, 0, 320, 388)];
                topBackground.image = [UIImage imageNamed:@"_orange_hitw.png"];
            }
            else{
                topBackground.image = [UIImage imageNamed:@"orange_hitw.png"];
            }
		}
		else if(delegate.fieldMode == kSquareWall){
			if(IS_IPHONE_5){
                //[topBackground setFrame:CGRectMake(0, 0, 320, 388)];
                topBackground.image = [UIImage imageNamed:@"_orange_4sq.png"];
            }
            else{
                topBackground.image = [UIImage imageNamed:@"orange_4sq.png"];
            }
		}
		
	}
	else if (delegate.snakeColor == [UIColor blackColor]) {
		if (delegate.fieldMode == kNoWall) {
            if(IS_IPHONE_5){
                //[topBackground setFrame:CGRectMake(0, 0, 320, 388)];
                topBackground.image = [UIImage imageNamed:@"_yellow_open.png"];
            }
            else{
                topBackground.image = [UIImage imageNamed:@"yellow_open.png"];
            }
		}
		else if(delegate.fieldMode == kFullWall){
			if(IS_IPHONE_5){
                //[topBackground setFrame:CGRectMake(0, 0, 320, 388)];
                topBackground.image = [UIImage imageNamed:@"_yellow_box.png"];
            }
            else{
                
                topBackground.image = [UIImage imageNamed:@"yellow_box.png"];
            }
		}
		else if(delegate.fieldMode == kHoleWall){
			if(IS_IPHONE_5){
                //[topBackground setFrame:CGRectMake(0, 0, 320, 388)];
                topBackground.image = [UIImage imageNamed:@"_yellow_hitw.png"];
            }
            else{
                topBackground.image = [UIImage imageNamed:@"yellow_hitw.png"];
            }
		}
		else if(delegate.fieldMode == kSquareWall){
			if(IS_IPHONE_5){
                //[topBackground setFrame:CGRectMake(0, 0, 320, 388)];
                topBackground.image = [UIImage imageNamed:@"_yellow_4sq.png"];
            }
            else{
                topBackground.image = [UIImage imageNamed:@"yellow_4sq.png"];
            }
		}
		
	}
	else if (delegate.snakeColor == [UIColor blueColor]) {
		if (delegate.fieldMode == kNoWall) {
            if(IS_IPHONE_5){
                //[topBackground setFrame:CGRectMake(0, 0, 320, 388)];
                topBackground.image = [UIImage imageNamed:@"_blue_open.png"];
            }
            else{
                topBackground.image = [UIImage imageNamed:@"blue_open.png"];
            }
        }
		else if(delegate.fieldMode == kFullWall){
			if(IS_IPHONE_5){
                //[topBackground setFrame:CGRectMake(0, 0, 320, 388)];
                topBackground.image = [UIImage imageNamed:@"_blue_box.png"];
            }
            else{
                topBackground.image = [UIImage imageNamed:@"blue_box.png"];
            }
        }
		else if(delegate.fieldMode == kHoleWall){
            if(IS_IPHONE_5){
                //[topBackground setFrame:CGRectMake(0, 0, 320, 388)];
                topBackground.image = [UIImage imageNamed:@"_blue_hitw.png"];
            }
            else{
                topBackground.image = [UIImage imageNamed:@"blue_hitw.png"];
            }
        }
		else if(delegate.fieldMode == kSquareWall){
            if(IS_IPHONE_5){
                //[topBackground setFrame:CGRectMake(0, 0, 320, 388)];
                topBackground.image = [UIImage imageNamed:@"_blue_4sq.png"];
            }
            else{
                topBackground.image = [UIImage imageNamed:@"blue_4sq.png"];
            }
        }
		
        
	}
	
}

// Function to change the background of the screen according to theme, snake color and field

-(void) setbackground{
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if(IS_IPHONE_5) {
        [smallBackground setFrame:CGRectMake(20, 195, 280, 186)];
        [background setFrame:CGRectMake(0, 388, 320, 180)];
        [topImage setFrame:CGRectMake(0, 0, 320, 568)];
        [topBackground setFrame:CGRectMake(0, 0, 320, 388)];
        
    }
	
	if(delegate.theme == kClassicTheme){
		
		smallBackground.image = [UIImage imageNamed:@"_0000_Difficulty_Classic.png"];
		background.image = [UIImage imageNamed:@"classic_back.png"];
		
		
	}
	else if (delegate.theme == kTheme1) {
		smallBackground.image = [UIImage imageNamed:@"_0000_Difficulty_theme1.png"];
		background.image = [UIImage imageNamed:@"garden.png"];
		
		
	}
	else if (delegate.theme == kTheme2) {
		smallBackground.image = [UIImage imageNamed:@"_0000_Difficulty_theme2.png"];
		background.image = [UIImage imageNamed:@"beach.png"];
		
		
	}
	else if (delegate.theme == kTheme3) {
		smallBackground.image = [UIImage imageNamed:@"_0000_Difficulty_theme3.png"];
		
		background.image = [UIImage imageNamed:@"night.png"];
		
	}
    	
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	
	
	[speed1 release];
	[selectedSpeed1 release];
	
	[speed2 release];
	[selectedSpeed2 release];
	
	[speed3 release];
	[selectedSpeed3 release];
	
	[speed4 release];
	[selectedSpeed4 release];
	
	[speed5 release];
	[selectedSpeed5 release];
	
	
	
    [super dealloc];
}


@end
