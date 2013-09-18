//
//  HighScoreViewController.m
//  
//
//  Created by Swapan Rajdev on 9/7/10.
//  Copyright 2010 Zing! Apps. All rights reserved.
//
//  Update V2: We are now saving the score when the user preses Friends or Global.
//             and once it is saved we then display the scores.
//			   Also displaying what mode the user scored the high score in
//
//
// Description: this View controller is used to show all the high scores in a Table
// Update V1.1: Added facebook and global leaderboards

#import "HighScoreViewController.h"
#import "SnakeClassicAppDelegate.h"
#import "GlobalScoreRecord.h"
#import "XMLParser.h"



@implementation HighScoreViewController


@synthesize highScoreTable;
@synthesize highScoreData;
@synthesize isLocal;
@synthesize isFriends;
@synthesize isGlobal;
@synthesize friendsInfo;
@synthesize activity;
@synthesize FBName;
@synthesize FBid;
@synthesize saveGame;





// Function to get the AdWhilr Key

-(NSString *)adWhirlApplicationKey{

	
	return kSampleAppKey;
	
	
	
	
}


- (UIViewController *)viewControllerForPresentingModalView {
	return self;
	
}

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
       
		

		localButton.hidden=YES;
		localSelectedButton.hidden = NO;
		friendsButton.hidden = NO;
		friendsSelectedButton.hidden = YES;
		globalButton.hidden = NO;
		globalSelectedButton.hidden = YES;
		
		
		
		isLocal = YES;
		isFriends = NO;
		isGlobal = NO;
		[self loadLocalHighScores];
	
    }
    return self;
}



//Action to be called when the local high scores are pressed
-(IBAction) localPressed{
	localButton.hidden=YES;
	localSelectedButton.hidden = NO;
	friendsButton.hidden = NO;
	friendsSelectedButton.hidden = YES;
	globalButton.hidden = NO;
	globalSelectedButton.hidden = YES;
	
	isLocal = YES;
	isGlobal = NO;
	isFriends = NO;

	
	[self loadLocalHighScores];
	
}

// Alert to show if the user is not connected to the internet

-(void) showAlert{
	
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Unable to communicate with server. Please make sure you have Internet connectivity. Thanks!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
	
	[alert show];
	
	
}


//Action to be called whent he global high score is pressed
-(IBAction) globalPressed {
	[FlurryAnalytics logEvent:@"scores/global"];
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	if (delegate.isconnected == NO) {
		[self showAlert];
	}
	else {
		[activity startAnimating];
		[NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(globalPressedTime:) userInfo:nil repeats:NO];
	}
	
}

// Function to start the global high score retrieval..
// It is called after a short time to start the activity monitor

-(void) globalPressedTime:(NSTimer *)theTimer{
	
	localButton.hidden=NO;
	localSelectedButton.hidden = YES;
	friendsButton.hidden = NO;
	friendsSelectedButton.hidden = YES;
	globalButton.hidden = YES;
	globalSelectedButton.hidden = NO;
	
	
	
	isLocal = NO;
	isGlobal = YES;
	isFriends = NO;
	
	//[self loadGlobalHighScores];
	
	[self saveTheGame];
	
}

// Acction to be called when the friends score is pressed
-(IBAction) friendsPressed{
	
	[FlurryAnalytics logEvent:@"scores/friends"];
	
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	
	if (delegate.isconnected == NO) {
		[self showAlert];
	}
	else {
	

	
	
		// If user is not logged in, login function is called
		if (delegate.FBLoggedIn == NO) {   
			delegate.loginFromScore = YES;
			[delegate login];
		}
		else {
		
			delegate.loginFromScore = NO;
		
			isLocal = NO;
			isGlobal = NO;
			isFriends = YES;

			//[self getFriendInfo];
		
			[self saveTheGame];
		}
	}
	
}


// Function to load all the high scores.
- (void)loadLocalHighScores {
	highScoreData = [[HighScores getLocalHighScores] retain];
		[activity startAnimating];
	[self.highScoreTable reloadData];
}

// Max number of high scores is 10 for local and friends and 50 for Global

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	if (isGlobal) {
		return 50;
	}
	else {
		return 10;
	}

}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	
	
	[activity stopAnimating];
	
	
	NSNumberFormatter *numberFormatter = [[[NSNumberFormatter alloc] init] autorelease];
	[numberFormatter setPositiveFormat:@"#,###"];
	
	//NSInteger *abc;
	
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	HighScoreCell *cell = (HighScoreCell *)[tableView dequeueReusableCellWithIdentifier: @"HighScoreCellIdentifier"];
	if (cell == nil) {
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"HighScoreCell" owner:self options:nil];
		cell = (HighScoreCell *)[nib objectAtIndex:0];
	}
	NSUInteger row = [indexPath row];
	cell.rankLabel.text = [NSString stringWithFormat:@"%d.", row+1];
	
	if (isLocal && row < highScoreData.count ){
		
	

			HighScoreRecord *record = (HighScoreRecord *)[highScoreData objectAtIndex:row];
		
		
		//NSNumber *theScore = [NSNumber numberWithInteger:record.totalScore];
		
			cell.nameLabel.text = record.name;
		
		if([record.mode isEqual:@"C"]){
			
			cell.gameMode.text = [NSString stringWithFormat:@"classic"];
		}
		else if([record.mode isEqual:@"E"]){
			
			cell.gameMode.text = [NSString stringWithFormat:@"extreme"];
		}
		   
		cell.scoreLabel.text = [NSString stringWithFormat:@"%@", [numberFormatter stringForObjectValue:record.totalScore]];
	}
	else if((isFriends || isGlobal) && row < [delegate.globalScores count]){
		

		
		if(isFriends){
			
			
			GlobalScoreRecord *record = (GlobalScoreRecord *) [delegate.globalScores objectAtIndex:indexPath.row];
			record.fbname = [record.fbname stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
			record.mode = [record.mode stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
			record.value = [record.value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; 
			
			int abc = [record.value intValue];
			
			NSNumber *abcd = [NSNumber numberWithInt:abc];
			
		
			
			record.fbname = [record.fbname stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
			cell.nameLabel.text = record.fbname;
			if([record.mode isEqual:@"C"]){
				
				cell.gameMode.text = [NSString stringWithFormat:@"classic"];
			}
			else if([record.mode isEqual:@"E"]){
				
				cell.gameMode.text = [NSString stringWithFormat:@"extreme"];
			}
			cell.scoreLabel.text = [NSString stringWithFormat:@"%@",[numberFormatter stringFromNumber:abcd] ];
			
			
		}
		else {
			GlobalScoreRecord *record = (GlobalScoreRecord *) [delegate.globalScores objectAtIndex:indexPath.row];
			
			record.name = [record.name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; 
			record.value = [record.value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
			record.mode = [record.mode stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
			int abc = [record.value intValue];
			
			NSNumber *abcd = [NSNumber numberWithInt:abc];
			
			cell.nameLabel.text = record.name;
			
			
			if([record.mode isEqual:@"C"]){
				
				cell.gameMode.text = [NSString stringWithFormat:@"classic"];
			}
			else if([record.mode isEqual:@"E"]) {
				
				cell.gameMode.text = [NSString stringWithFormat:@"extreme"];
			}
			cell.scoreLabel.text = [NSString stringWithFormat:@"%@", [numberFormatter stringFromNumber:abcd]];
		}
	} else {
		cell.nameLabel.text = @"-";
		cell.gameMode.text = @"-";
		cell.scoreLabel.text = @"-";
		
	}
	
	return cell;
}

// Change colors of every alternate cell
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 || indexPath.row%2 == 0) {
        UIColor *altCellColor = [UIColor colorWithRed:0.219 green:0.654 blue:0 alpha:0.3];
        cell.backgroundColor = altCellColor;
    }
	else {
		UIColor *altCellColor = [UIColor colorWithRed:1 green:0.568 blue:0 alpha:0.3];
        cell.backgroundColor = altCellColor;
	}

}


// Action that takes place when the back button is pressed. Takes the user back to the main menu
-(IBAction)backPressed:(id)sender{
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	
	
	[delegate switchView:self.view toview:delegate.mainmenu.view delay:NO remove:YES display:nil curlup:NO curldown:YES];
	

	
	
}



- (void) viewDidAppear:(BOOL)animated{
	
	
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	if (delegate.theme == kClassicTheme) {
		
		//background.image = [UIImage imageNamed:@"_0000_Classic_scores.png"];
		background.image = [UIImage imageNamed:@"Classic.png"];
		
	}
	else if(delegate.theme == kTheme1){
		
		
		//background.image = [UIImage imageNamed:@"_0000_theme1_scores.png"];
		background.image = [UIImage imageNamed:@"Theme1.png"];
	}
	else if(delegate.theme == kTheme2){
		
		//background.image = [UIImage imageNamed:@"_0000_theme2_scores.png"];
		background.image = [UIImage imageNamed:@"Theme2.png"];
	}
	else if(delegate.theme == kTheme3){
		
		
		//background.image = [UIImage imageNamed:@"_0000_theme3_scores.png"];
		background.image = [UIImage imageNamed:@"Theme3.png"];
	}
	
	localButton.hidden=YES;
	localSelectedButton.hidden = NO;
	friendsButton.hidden = NO;
	friendsSelectedButton.hidden = YES;
	globalButton.hidden = NO;
	globalSelectedButton.hidden = YES;
	
	[self loadLocalHighScores];
	
	isLocal = YES;
	isFriends = NO;
	isGlobal = NO;
	
	saveGame = NO;
	
	
#ifdef LITE_VERSION
    // Code specific to lite version

	
//	[adView doNotIgnoreNewAdRequests];
//	[adView doNotIgnoreAutoRefreshTimer];
	
	//adView = [AdWhirlView requestAdWhirlViewWithDelegate:self];
	adView = delegate.mainmenu.adView;
	
	adView.frame = CGRectMake(0.0, 432.0, 320.0, 50.0);
	
#endif
	
    [super viewDidLoad];
	
#ifdef LITE_VERSION
    // Code specific to lite version

	
	[self.view addSubview:adView];
	
#endif
}



- (void) viewDidDisappear:(BOOL)animated{

//	[adView ignoreNewAdRequests];
	
//	[adView ignoreAutoRefreshTimer];

}


// Function that sends a call to the server and gets the global high scores
-(void)loadGlobalHighScores{

	[activity startAnimating];
	NSURL *url = [[NSURL alloc] initWithString:@"http://zingapps.co/get_scores_1_trial.php"];
	
	
	NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
	
	//Initialize the delegate.
	XMLParser *parser = [[XMLParser alloc] initXMLParser];
	
	//Set delegate
	[xmlParser setDelegate:parser];
	
	
	//Start parsing the XML file.
	BOOL success = [xmlParser parse];
	
	if(success){
		//NSLog(@"No Errors");
    }
	else{
		
		[activity stopAnimating];
	}
	
	
	[self.highScoreTable reloadData];
}


//  function that sends a call to the server and get the high scores of friends

-(void) loadFriendsHighScore{
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	

	NSMutableString *urlString = [[NSMutableString alloc] initWithString:@"http://zingapps.co/get_scores_1_trial.php?"];
	
	int i =0;
	
	NSString *friendid;
	NSString *abc;
	while (i<[friendsInfo count] - 1 && i < 500) {
		
		friendid = [[friendsInfo objectAtIndex:i] objectForKey:@"id"];
		
		
		abc = [NSString stringWithFormat:@"arr[]=%@&",friendid];
		
		[urlString appendString:abc];
		i++;
	}
	
	friendid = [[friendsInfo lastObject] objectForKey:@"id"];
	abc = [NSString stringWithFormat:@"arr[]=%@&arr[]=%@",friendid,delegate._userInfo.uid];
	

	
	[urlString appendString:abc] ;
	
	NSURL *url = [[NSURL alloc] initWithString:urlString];
	
	
	NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
	
	//Initialize the delegate.
	XMLParser *parser = [[XMLParser alloc] initXMLParser];
	
	//Set delegate
	[xmlParser setDelegate:parser];
	
	//Start parsing the XML file.
	BOOL success = [xmlParser parse];
	
	if(success){
        
    }
	else{
		//NSLog(@"FACEBOOK Error Error!!!");
		[activity stopAnimating];
	}
	
	[self.highScoreTable reloadData];

	
	
}


// function to get friends info of the logged in user

-(void) getFriendInfo {
	
		[activity startAnimating];
	
	localButton.hidden=NO;
	localSelectedButton.hidden = YES;
	friendsButton.hidden = YES;
	friendsSelectedButton.hidden = NO;
	globalButton.hidden = NO;
	globalSelectedButton.hidden = YES;
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[delegate.facebook requestWithGraphPath:@"me/friends" andDelegate:self];
	
	
}



/**
 * Called when a request returns and its response has been parsed into an object.
 * The resulting object may be a dictionary, an array, a string, or a number, depending
 * on thee format of the API response.
 */
- (void)request:(FBRequest*)request didLoad:(id)result {
	

	
	

	if (saveGame == YES) {
		
		
		
		
		FBName = [result objectForKey:@"name"];
		FBName = [FBName stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
		
		
		FBid = [result objectForKey:@"id"];
		
		
		[self submitScore];
		
		saveGame = NO;
	}
	
	else {
		friendsInfo = (NSMutableArray *)[result objectForKey:@"data"];
		
		
		
		[self loadFriendsHighScore];
	}

	
	
	
	
	
	
};

- (void)request:(FBRequest*)request didFailWithError:(NSError*)error{
	
	
	//NSLog(@" ERROR FACEBOOK: %@",[error localizedDescription]);
	
	[activity stopAnimating];
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Snake Classic" message:@"Sorry, there was an error. Please make sure your device is connected to the internet." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	
	[alert show];
	
	
	
};



// Function to make sure size of banner is the same size of Ad
- (void)adWhirlDidReceiveAd:(AdWhirlView *)adWhirlView {
	[UIView beginAnimations:@"AdResize" context:nil];
	[UIView setAnimationDuration:0.5];
	CGSize adSize = [adWhirlView actualAdSize];
	CGRect newFrame = adWhirlView.frame;
	newFrame.size.height = adSize.height; // fit the ad
	newFrame.size.width = adSize.width;
	newFrame.origin.x = (self.view.bounds.size.width - adSize.width)/2; // center
	adWhirlView.frame = newFrame;
	
	[UIView commitAnimations];
}





-(void)submitScore{

	
	
	
	
	int i = 0;
	while (i < [highScoreData count] && i < 10) {
		HighScoreRecord *record = (HighScoreRecord *)[highScoreData objectAtIndex:i];
		
		int theScore = [record.totalScore intValue];
		

		
		[self submitScore:theScore theName:record.name theMode:record.mode];
		
		i++;
	}
	
	if (isFriends) {
		[self getFriendInfo];
	}

	if (isGlobal) {
		[self loadGlobalHighScores];
	}
	
	
	
	
	
	
}


// New in v1.1
// This method is used to submit the high scores to the 
// gloabal leader board

-(void) submitScore: (int) theScore theName:(NSString *)theName theMode:(NSString *)gameMode{
	
	
	//SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	
	NSString * udid = [[UIDevice currentDevice] uniqueIdentifier];
	NSString * secret = @"Qwdfty!3";
	
	
	theName = [theName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	gameMode = [gameMode stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	

	
	NSString *urlString = [NSString stringWithFormat:@"http://zingapps.co/put_score_trial.php?secret=%@&udid=%@&name=%@&score=%d&fbname=%@&fbid=%@&mode=%@",
						   secret,udid,theName,theScore,FBName,FBid,gameMode];
	
	
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    

	
	
	NSError * e;
	NSData	     *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&e];
	
	
	
	//return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	
	
}



// This method saves the current score of the player 
// It is called every time the player gets out of the game over screen.
// That is if the player pressed Play Again or Menu we save the score 

-(void)saveTheGame{
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];

	
	if (delegate.FBLoggedIn == YES) {
		[self getUserInfo];
		
		saveGame = YES;
	}
	else {
		FBName = NULL;
		FBid = NULL;
		[self submitScore];
		
	}
	
	
}

// This method gets the users facebook info


-(void) getUserInfo {
	
	
	[activity startAnimating];
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[delegate.facebook requestWithGraphPath:@"me" andDelegate:self];
	
	
}









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
	
	
	[highScoreTable release];
	[highScoreData release];
	[friendsInfo release];
	[activity release];
	[FBName release];
	[FBid release];
	
	
    [super dealloc];
}





@end
