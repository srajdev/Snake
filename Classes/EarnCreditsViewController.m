//
//  EarnCreditsViewController.m
//  SnakeClassic
//
//  Created by Swapan Rajdev on 11/5/10.
//  Copyright 2010 Zing! Apps. All rights reserved.
//
//  NEW IN V2:
//  Description: This view is the view to earn credits by downloading apps.


#import "EarnCreditsViewController.h"
#import "SnakeClassicAppDelegate.h"
#import "main_menu.h"
#import "FlurryAdDelegate.h"
#import "FlurryAds.h"
#import "AdSupport/ASIdentifierManager.h"

@implementation EarnCreditsViewController

@synthesize backButton;
@synthesize refreshButton;
@synthesize refreshLabel;
@synthesize nameButton;
//@synthesize downloadButton;
@synthesize name;
@synthesize myAdView;
@synthesize watchVideo;
@synthesize balance;

- (void) viewDidLoad{
 
    SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	balance.text = [NSString stringWithFormat:@"%d Cr",delegate.userBalance];
    
	if (delegate.theme == kClassicTheme) {
        if(IS_IPHONE_5){
            [background setFrame:CGRectMake(0, 0, 320, 568)];
            background.image = [UIImage imageNamed:@"store_classic.png"];
        }
        else{
            background.image = [UIImage imageNamed:@"_0000_classic_store.png"];
        }
		balance.textColor = [UIColor whiteColor];
		
	}
	else if(delegate.theme == kTheme1){
		if(IS_IPHONE_5){
            [background setFrame:CGRectMake(0, 0, 320, 568)];
            background.image = [UIImage imageNamed:@"store_garden.png"];
        }
        else{
            background.image = [UIImage imageNamed:@"_0000_theme1_store.png"];
        }
		balance.textColor = [UIColor yellowColor];
	}
	else if(delegate.theme == kTheme2){
		if(IS_IPHONE_5){
            [background setFrame:CGRectMake(0, 0, 320, 568)];
            background.image = [UIImage imageNamed:@"store_beach.png"];
        }
        else{
            background.image = [UIImage imageNamed:@"_0000_theme2_store.png"];
		}
        balance.textColor = [UIColor darkTextColor];
	}
	else if(delegate.theme == kTheme3){
		if(IS_IPHONE_5){
            [background setFrame:CGRectMake(0, 0, 320, 568)];
            background.image = [UIImage imageNamed:@"store_night.png"];
        }
        else{
            background.image = [UIImage imageNamed:@"_0000_theme3_store.png"];
		}
        balance.textColor = [UIColor whiteColor];
	}
	if(IS_IPHONE_5){
        //self.view.frame = CGRectMake(0, 0, 320, 568);
        
        CGRect btbalFrame = balance.frame;
        btbalFrame.origin.x = 268;
        btbalFrame.origin.y = 3 + 4;
        balance.frame = btbalFrame;
        
        CGRect btnameFrame = name.frame;
        btnameFrame.origin.x = EARN_VIDEOS_LABEL_X;
        btnameFrame.origin.y = 20 + EARN_VIDEOS_LABEL_Y;
        name.frame = btnameFrame;
        
        CGRect btrefreshLabelFrame = refreshLabel.frame;
        btrefreshLabelFrame.origin.x = EARN_REFRESH_LABEL_X;
        btrefreshLabelFrame.origin.y = 20 + EARN_REFRESH_LABEL_Y;
        refreshLabel.frame = btrefreshLabelFrame;
        
        /*CGRect btdownloadFrame = downloadButton.frame;
        btdownloadFrame.origin.x = EARN_DOWNLOAD_BUTTON_X;
        btdownloadFrame.origin.y = 30 + EARN_DOWNLOAD_BUTTON_Y;
        downloadButton.frame = btdownloadFrame;
        */
        
        CGRect btvidFrame = watchVideo.frame;
        btvidFrame.origin.x = EARN_VIDEOS_BUTTON_X;
        btvidFrame.origin.y = 20 + EARN_VIDEOS_BUTTON_Y;
        watchVideo.frame = btvidFrame;
        
        CGRect btbackFrame = backButton.frame;
        btbackFrame.origin.x = EARN_BACK_BUTTON_X;
        btbackFrame.origin.y = 150 + EARN_BACK_BUTTON_Y;
        backButton.frame = btbackFrame;
        
        CGRect btrefreshFrame = refreshButton.frame;
        btrefreshFrame.origin.x = EARN_REFRESH_BUTTON_X;
        btrefreshFrame.origin.y = 20 + EARN_REFRESH_BUTTON_Y;
        refreshButton.frame = btrefreshFrame;
	}
	
}

- (void) viewDidAppear:(BOOL)animated{
	
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	NSUserDefaults	*defaults = [NSUserDefaults standardUserDefaults];
  	
    NSString *idfaString = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
	NSString *urlString = [NSString stringWithFormat:@"http://zingapps.co/get_balance_2.php?idfa=%@",idfaString];
	
	
	
	//NSError *error;
	//NSString *connected = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSASCIIStringEncoding error:&error ];
	
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setTimeoutInterval:15];
    [request setURL:[NSURL URLWithString:urlString]];
    
    NSData *responseDataSerial = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSString *connected = [[NSString alloc] initWithData:responseDataSerial encoding:NSUTF8StringEncoding];
    
    NSLog(@"response string: %@", connected);
    
	if (connected == NULL) {
		
		delegate.isconnected = NO;
		
	} else if([connected isEqualToString:@"No Records found"]){
		
		delegate.isconnected = YES;
		delegate.totalbalance = 0;
		delegate.userBalance = 0;
	}
	else{
		delegate.isconnected = YES;
		
		delegate.totalbalance = [connected intValue];
		
		
		delegate.userBalance = delegate.totalbalance - (delegate.holeUnlocked * 30) - (delegate.squareUnlocked *30)
		- (delegate.beachUnlocked *20) - (delegate.gardenUnlocked *20) - (delegate.nightUnlocked *20);
		
		if(delegate.userBalance < 0){
			
			delegate.userBalance = 0;
		}
		
	}
    
    balance.text = [NSString stringWithFormat:@"%d Cr",delegate.userBalance];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Enter your Email ID:" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Don't Show Again", @"Ok", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;

    if ([defaults boolForKey:@"emailEntered"]!=YES && [defaults boolForKey:@"dontShow"]!=YES) {
        [alertView setTag:1];
        [alertView show];
        [alertView release];
    }
    
    
    
	if (delegate.isconnected == NO) {
				
		[NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(showAlert:) userInfo:nil repeats:NO];
		
	}
	else if(delegate.take_over == 1){
		[NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(showAlert_2:) userInfo:nil repeats:NO];
	}

    [FlurryAds setAdDelegate:self];
    
    [FlurryAds fetchAdForSpace:@"Videos" frame:self.view.frame size:FULLSCREEN];
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSUserDefaults	*defaults = [NSUserDefaults standardUserDefaults];
    
    if(buttonIndex == 1){
        BOOL dontShow = YES;
        [defaults setBool:dontShow forKey: @"dontShow"];
        [defaults synchronize];
    }
    
    if(alertView.tag == 1 && buttonIndex==2){
        
    UITextField *emailTextField = [alertView textFieldAtIndex:0];
    NSString *vendorID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    //NSLog(@"%@",emailTextField.text);
    //NSLog(@"%lu",(unsigned long)[emailTextField.text length]);
    //NSLog(@"%@",vendorID);
    
    NSString *idfaString = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    //NSLog(@"%@",idfaString);
    //NSString *secret = @"Qwdfty!3";
    
    if(((unsigned long)[emailTextField.text length]) > 0 ){
	NSString *urlString = [NSString stringWithFormat:@"http://zingapps.co/setEmail.php?idfa=%@&email=%@&vendorID=%@",idfaString,emailTextField.text,vendorID];
        
    
	
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSURLResponse *response = nil;
        
	NSError *e = nil;
	NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&e];

    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
        NSLog(@"%@",responseString);
      //  NSLog(@"%@",response);
      //  NSLog(@"%@",e);
    
        
        if([responseString isEqualToString:@"Email exists"]){
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Email ID Exists:" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            [alertView setTag:2];
            [alertView show];
            //[alert release];
            //[self viewDidAppear:true];
            
        }
        else{
            BOOL emailEntered = YES;
            [defaults setBool:emailEntered forKey: @"emailEntered"];
            [defaults synchronize];
            [self watchVideoPressed];
        }
        
	}
    }
    else if(alertView.tag == 2){
        [self viewDidAppear:true];
        
    }
    
}


- (IBAction) watchVideoPressed{
    
    NSLog(@"self view :%@", self.view);
    if ([FlurryAds adReadyForSpace:@"Videos"]) {
        NSLog(@"ready");
        [FlurryAds displayAdForSpace:@"Videos" onView:self.view];
    } else {
        NSLog(@"not ready");
        //[FlurryAds fetchAdForSpace:@"Videos" frame:self.view.frame size:FULLSCREEN];
        [FlurryAds fetchAndDisplayAdForSpace:@"Videos" view:self.view size:FULLSCREEN];
    }
    
}

- (void) videoDidFinish:(NSString *)adSpace{
    NSLog(@"Ad Space [%@] Video Did Finish", adSpace);

    SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
    NSString *idfaString = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
	NSString *urlString = [NSString stringWithFormat:@"http://zingapps.co/get_balance_2.php?idfa=%@",idfaString];
	
	
	
	//NSError *error;
	//NSString *connected = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSASCIIStringEncoding error:&error ];
	
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setTimeoutInterval:15];
    [request setURL:[NSURL URLWithString:urlString]];
    
    NSData *responseDataSerial = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSString *connected = [[NSString alloc] initWithData:responseDataSerial encoding:NSUTF8StringEncoding];
    
    NSLog(@"response string: %@", connected);
    
	if (connected == NULL) {
		
		delegate.isconnected = NO;
		
	} else if([connected isEqualToString:@"No Records found"]){
		
		delegate.isconnected = YES;
		delegate.totalbalance = 0;
		delegate.userBalance = 0;
	}
	else{
		delegate.isconnected = YES;
		
		delegate.totalbalance = [connected intValue];
		
		
		delegate.userBalance = delegate.totalbalance - (delegate.holeUnlocked * 30) - (delegate.squareUnlocked *30)
		- (delegate.beachUnlocked *20) - (delegate.gardenUnlocked *20) - (delegate.nightUnlocked *20);
		
		if(delegate.userBalance < 0){
			
			delegate.userBalance = 0;
		}
		
	}

	
	balance.text = [NSString stringWithFormat:@"%d Cr",delegate.userBalance];

    
    // Grant the reward here.
    // The amount is the same for all user for all videos watched
    // The amount is the same as configured on dev portal - the min reward
    
    // Flurry server sends a post-view next stating the amount of the reward .
    
    [self viewDidAppear:true];
    
}


// Function to refresh the app suggested to the user

-(void) refresh{
	[self viewDidAppear:true];
	
}


// Alert shown when the user is not connected to the interner
-(void) showAlert :(NSTimer *)theTimer{
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Unable to communicate with server. Please make sure you have Internet connectivity. Thanks!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
	
	[alert show];
	
	[theTimer invalidate];
	
	
	
}


-(void) showAlert_2 :(NSTimer *)theTimer{
	

	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Today only, earn 60 credits!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
	
	[alert show];
	

	[theTimer invalidate];
	
	
	
}




// Function to get AdWhirl key
-(NSString *)adWhirlApplicationKey{
	
	return kSampleAppKey;
	
}

- (UIViewController *)viewControllerForPresentingModalView {
	return self;
}



-(IBAction) refreshPressed{

	[self refresh];
	
}

-(IBAction) backPressed{
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	if (delegate.earn_from_menu == YES) {
		delegate.earn_from_menu = NO;
		[delegate switchView:self.view toview:delegate.mainmenu.view delay:NO remove:YES display:nil curlup:NO curldown:YES];
	}
	else {
		[delegate switchView:self.view toview:delegate.storeView.view delay:NO remove:YES display:nil curlup:NO curldown:YES];
	}
	
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void) viewDidDisappear:(BOOL)animated{
    
    [FlurryAds removeAdFromSpace:@"BANNER_MAIN_VIEW"];
    [FlurryAds setAdDelegate:nil];
    
	
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
