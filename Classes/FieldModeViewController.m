//
//  FieldModeViewController.m
//  SnakeClassic
//
//  Created by Swapan Rajdev on 10/26/10.
//  Copyright 2010 Zing! Apps. All rights reserved.
//
//  NEW IN V2
//  Description: This screen lets the user choose which maze/Field he wants to play
//				 There are 4 different mazes. 
//	

#import "FieldModeViewController.h"
#import "SnakeClassicAppDelegate.h"
#import "Difficulty.h"
#import "FlurryAdDelegate.h"
#import "FlurryAds.h"
#import "Flurry.h"

@implementation FieldModeViewController

@synthesize topImage;

// Action when user presses Open Field
-(IBAction) OpenFieldPressed:(id)sender{
	
	[Flurry logEvent:@"classic/play openfield"];
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	
	delegate.isWallOn = NO;
	delegate.fieldMode = kNoWall;
	
	hole.enabled = YES;
	square.enabled = YES;
	holeLocked.hidden =YES;
    squareLocked.hidden = YES;
	
	openField.hidden = YES;
	openFieldSelected.hidden = NO;
	
	box.hidden = NO;
	boxSelected.hidden = YES;
	
	
	if (delegate.holeUnlocked == NO) {
		hole.hidden = NO;
		holeSelected.hidden = YES;
		hole.enabled = NO;
		holeLocked.hidden = NO;
		
	}
	else {
		hole.hidden = NO;
		holeSelected.hidden = YES;
	}
	
	
	if (delegate.squareUnlocked == NO) {
		square.hidden = NO;
		squareSelected.hidden = YES;
		square.enabled = NO;
		squareLocked.hidden = NO;
	}
	else {
		square.hidden = NO;
		squareSelected.hidden = YES;
	}
	
	[self setbackground];
	
	
}

// Action when user presses Box field
-(IBAction) BoxPressed:(id)sender{
	
	[Flurry logEvent:@"classic/play box"];
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	
		delegate.isWallOn = YES;
	delegate.fieldMode = kFullWall;
	
	hole.enabled = YES;
	square.enabled = YES;
	holeLocked.hidden =YES;
	squareLocked.hidden = YES;
	
	openField.hidden = NO;
	openFieldSelected.hidden = YES;
	
	box.hidden = YES;
	boxSelected.hidden = NO;
	
	
	if (delegate.holeUnlocked == NO) {
		hole.hidden = NO;
		holeSelected.hidden = YES;
		hole.enabled = NO;
		holeLocked.hidden = NO;
		
	}
	else {
		hole.hidden = NO;
		holeSelected.hidden = YES;
	}
	
	
	if (delegate.squareUnlocked == NO) {
		square.hidden = NO;
		squareSelected.hidden = YES;
		square.enabled = NO;
		squareLocked.hidden = NO;
	}
	else {
		square.hidden = NO;
		squareSelected.hidden = YES;
	}
	
	[self setbackground];
	
}


// Action when user presses Hole in the wall Field
-(IBAction) HoleWallPressed:(id)sender{
	
	[Flurry logEvent:@"classic/play hitw"];

	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	
			delegate.isWallOn = YES;
	delegate.fieldMode = kHoleWall;
	
	
	hole.enabled = YES;
	square.enabled = YES;
	holeLocked.hidden =YES;
	squareLocked.hidden = YES;
	
	openField.hidden = NO;
	openFieldSelected.hidden = YES;
	
	box.hidden = NO;
	boxSelected.hidden = YES;
	
	
	if (delegate.holeUnlocked == NO) {
		hole.hidden = NO;
		holeSelected.hidden = YES;
		hole.enabled = NO;
		holeLocked.hidden = NO;
		
	}
	else {
		hole.hidden = YES;
		holeSelected.hidden = NO;
	}
	
	
	if (delegate.squareUnlocked == NO) {
		square.hidden = NO;
		squareSelected.hidden = YES;
		square.enabled = NO;
		squareLocked.hidden = NO;
	}
	else {
		square.hidden = NO;
		squareSelected.hidden = YES;
	}
	
	[self setbackground];
	
	
	
}

// Action when user presses 4Square Field
-(IBAction) SquarePressed:(id)sender{
	
	[Flurry logEvent:@"classic/play 4sq"];

	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	
			delegate.isWallOn = YES;
	delegate.fieldMode = kSquareWall;
	
	hole.enabled = YES;
	square.enabled = YES;
	holeLocked.hidden =YES;
	squareLocked.hidden = YES;
	
	openField.hidden = NO;
	openFieldSelected.hidden = YES;
	
	box.hidden = NO;
	boxSelected.hidden = YES;
	
	
	if (delegate.holeUnlocked == NO) {
		hole.hidden = NO;
		holeSelected.hidden = YES;
		hole.enabled = NO;
		holeLocked.hidden = NO;
		
	}
	else {
		hole.hidden = NO;
		holeSelected.hidden = YES;
	}
	
	
	if (delegate.squareUnlocked == NO) {
		square.hidden = NO;
		squareSelected.hidden = YES;
		square.enabled = NO;
		squareLocked.hidden = NO;
	}
	else {
		square.hidden = YES;
		squareSelected.hidden = NO;
	}
	
	[self setbackground];
	
}
-(IBAction) NextPressed:(id)sender{
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[delegate switchView:self.view toview:delegate.difficultyMenu.view delay:NO remove:YES display:nil curlup: NO curldown:NO];
	
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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    
        [self setbackground];

	//  [super viewDidLoad];

}
-(void) viewWillAppear:(BOOL)animated{
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	
	hole.enabled = YES;
	square.enabled = YES;
	holeLocked.hidden =YES;
	squareLocked.hidden = YES;
	delegate.fieldMode = kNoWall;
	delegate.isWallOn = NO;
	
		
	openField.hidden = YES;
	openFieldSelected.hidden = NO;

	box.hidden = NO;
	boxSelected.hidden = YES;
	

	if (delegate.holeUnlocked == NO) {
		hole.hidden = NO;
		holeSelected.hidden = YES;
		hole.enabled = NO;
		holeLocked.hidden = NO;
		
	}
	else {
		hole.hidden = NO;
		holeSelected.hidden = YES;
	}

	
	if (delegate.squareUnlocked == NO) {
		square.hidden = NO;
		squareSelected.hidden = YES;
		square.enabled = NO;
		squareLocked.hidden = NO;
	}
	else {
		square.hidden = NO;
		squareSelected.hidden = YES;
	}

	//[self setbackground];
	
	
  
}

-(void) setbackground{
	
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
    if(IS_IPHONE_5) {
        [smallBackground setFrame:CGRectMake(43, 150, 240, 208)];
        [background setFrame:CGRectMake(0, 388, 320, 180)];
        [topImage setFrame:CGRectMake(0, 0, 320, 568)];
        //CGRect frame = topBackground.frame;
        //frame.size.height = 88 + 480;
        //topBackground.frame = frame;
     }
    
	if (delegate.theme == kClassicTheme) {
        
        
		smallBackground.image = [UIImage imageNamed:@"_0000_Field_Classic.png"];
		background.image = [UIImage imageNamed:@"classic_back.png"];		
		
	}
	else if (delegate.theme == kTheme1){
		smallBackground.image = [UIImage imageNamed:@"_0000_Field_Theme1.png"];
		background.image = [UIImage imageNamed:@"garden.png"];
		
		
	}
	else if (delegate.theme == kTheme2){
		smallBackground.image = [UIImage imageNamed:@"_0000_Field_Theme2.png"];
		background.image = [UIImage imageNamed:@"beach.png"];
		
		
		
	}
	else if (delegate.theme == kTheme3){
		smallBackground.image = [UIImage imageNamed:@"_0000_Field_Theme3.png"];
		background.image = [UIImage imageNamed:@"night.png"];
		
	
	}
	
	if (delegate.snakeColor == [UIColor greenColor]) {
		if (delegate.fieldMode == kNoWall) {
            if(IS_IPHONE_5){
                [topBackground setFrame:CGRectMake(0, 0, 320, 388)];
                topBackground.image = [UIImage imageNamed:@"_green_open.png"];
            }
            else{
                topBackground.image = [UIImage imageNamed:@"green_open.png"];
            }
		}
		else if(delegate.fieldMode == kFullWall){
			if(IS_IPHONE_5){
                [topBackground setFrame:CGRectMake(0, 0, 320, 388)];
                topBackground.image = [UIImage imageNamed:@"_green_box.png"];
            }
            else{
                topBackground.image = [UIImage imageNamed:@"green_box.png"];
            }
		}
		else if(delegate.fieldMode == kHoleWall){
			if(IS_IPHONE_5){
                [topBackground setFrame:CGRectMake(0, 0, 320, 388)];
                topBackground.image = [UIImage imageNamed:@"_green_hitw.png"];
            }
            else{
                topBackground.image = [UIImage imageNamed:@"green_hitw.png"];
            }
		}
		else if(delegate.fieldMode == kSquareWall){
			if(IS_IPHONE_5){
                [topBackground setFrame:CGRectMake(0, 0, 320, 388)];
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
                [topBackground setFrame:CGRectMake(0, 0, 320, 388)];
                topBackground.image = [UIImage imageNamed:@"_orange_open.png"];
            }
            else{
                topBackground.image = [UIImage imageNamed:@"orange_open.png"];
            }
		}
		else if(delegate.fieldMode == kFullWall){
			if(IS_IPHONE_5){
                [topBackground setFrame:CGRectMake(0, 0, 320, 388)];
                topBackground.image = [UIImage imageNamed:@"_orange_box.png"];
            }
            else{
                topBackground.image = [UIImage imageNamed:@"orange_box.png"];
            }
		}
		else if(delegate.fieldMode == kHoleWall){
			if(IS_IPHONE_5){
                [topBackground setFrame:CGRectMake(0, 0, 320, 388)];
                topBackground.image = [UIImage imageNamed:@"_orange_hitw.png"];
            }
            else{
                topBackground.image = [UIImage imageNamed:@"orange_hitw.png"];
            }
		}
		else if(delegate.fieldMode == kSquareWall){
			if(IS_IPHONE_5){
                [topBackground setFrame:CGRectMake(0, 0, 320, 388)];
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
                [topBackground setFrame:CGRectMake(0, 0, 320, 388)];
                topBackground.image = [UIImage imageNamed:@"_yellow_open.png"];
            }
            else{
                topBackground.image = [UIImage imageNamed:@"yellow_open.png"];
            }
		}
		else if(delegate.fieldMode == kFullWall){
			if(IS_IPHONE_5){
                [topBackground setFrame:CGRectMake(0, 0, 320, 388)];
                topBackground.image = [UIImage imageNamed:@"_yellow_box.png"];
            }
            else{
                
                topBackground.image = [UIImage imageNamed:@"yellow_box.png"];
            }
		}
		else if(delegate.fieldMode == kHoleWall){
			if(IS_IPHONE_5){
                [topBackground setFrame:CGRectMake(0, 0, 320, 388)];
                topBackground.image = [UIImage imageNamed:@"_yellow_hitw.png"];
            }
            else{
                topBackground.image = [UIImage imageNamed:@"yellow_hitw.png"];
            }
		}
		else if(delegate.fieldMode == kSquareWall){
			if(IS_IPHONE_5){
                [topBackground setFrame:CGRectMake(0, 0, 320, 388)];
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
                [topBackground setFrame:CGRectMake(0, 0, 320, 388)];
                topBackground.image = [UIImage imageNamed:@"_blue_open.png"];
            }
            else{
                topBackground.image = [UIImage imageNamed:@"blue_open.png"];
            }
        }
		else if(delegate.fieldMode == kFullWall){
			if(IS_IPHONE_5){
                [topBackground setFrame:CGRectMake(0, 0, 320, 388)];
                topBackground.image = [UIImage imageNamed:@"_blue_box.png"];
            }
            else{
                topBackground.image = [UIImage imageNamed:@"blue_box.png"];
            }
        }
		else if(delegate.fieldMode == kHoleWall){
            if(IS_IPHONE_5){
                [topBackground setFrame:CGRectMake(0, 0, 320, 388)];
                topBackground.image = [UIImage imageNamed:@"_blue_hitw.png"];
            }
            else{
                topBackground.image = [UIImage imageNamed:@"blue_hitw.png"];
            }
        }
		else if(delegate.fieldMode == kSquareWall){
            if(IS_IPHONE_5){
                [topBackground setFrame:CGRectMake(0, 0, 320, 388)];
                topBackground.image = [UIImage imageNamed:@"_blue_4sq.png"];
            }
            else{
                topBackground.image = [UIImage imageNamed:@"blue_4sq.png"];
            }
        }
		
	}
	
	
	
	
}



-(IBAction) lockPressed : (id) sender{
	

	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	UIButton *buttonPressed = (UIButton *)sender;
	
	delegate.unlockFromAnother = 2;
	
	if (buttonPressed.tag == 0) {
		delegate.creditsInfo = kHole;
	}
	
	if (buttonPressed.tag == 1) {
		delegate.creditsInfo = kSquare;
	}
	
	//[delegate switchView:self.view toview:delegate.storeView.view delay:NO remove:YES display:nil curlup:YES curldown:NO];
	
	
	
	[delegate switchView:self.view toview:delegate.unlockView.view delay:NO remove:YES display:nil curlup:YES curldown:NO];
	
	
	
}

- (void) viewDidDisappear:(BOOL)animated{
    
    [FlurryAds removeAdFromSpace:@"BANNER_MAIN_VIEW"];
    [FlurryAds setAdDelegate:nil];
    
	
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
    [super dealloc];
}


@end
