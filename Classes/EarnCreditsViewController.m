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
#import "Social/Social.h"
#import "AdSupport/ASIdentifierManager.h"
#import <AdColony/AdColony.h>
#import "SnakeIAPHelper.h"
#import "TSTapstream.h"

@implementation EarnCreditsViewController

@synthesize backButton;
@synthesize refreshButton;
@synthesize refreshLabel;
@synthesize nameButton;
//@synthesize downloadButton;
@synthesize name;
@synthesize watchVideo;
@synthesize balance;
@synthesize products;



- (void) viewDidLoad{
 
    SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	[self setBackground];
	balance.text = [NSString stringWithFormat:@"%d Cr",delegate.userBalance];
    
	
    float yCoord = 180;
    if (!IS_IPHONE_5) {
        yCoord = 120;
    }
    
    UIImage *buyImage = [UIImage imageNamed:@"earncredits_buy.png"];
    UIButton *buyButton = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width / 2) - (buyImage.size.width / 2) - 30,
                                                                     yCoord,
                                                                     buyImage.size.width,
                                                                     buyImage.size.height)];
    [buyButton setImage:buyImage forState:UIControlStateNormal];
    [buyButton addTarget:self action:@selector(buyCredits) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buyButton];
    
   
    
    UIImage *facebookImage = [UIImage imageNamed:@"earncredits_share-on-facebook.png"];
    UIButton *facebookShare = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width / 2) - (facebookImage.size.width / 2) - 30,
                                                                         yCoord + buyButton.frame.size.height + 40,
                                                                         facebookImage.size.width - 30,
                                                                         facebookImage.size.height)];
    [facebookShare setImage:facebookImage forState:UIControlStateNormal];
    [facebookShare addTarget:self action:@selector(shareOnFacebook) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:facebookShare];
    
    
    UIImage *facebookCreditsImage = [UIImage imageNamed:@"earncredits_10-Cr"];
    UIImageView *facebookCredits = [[UIImageView alloc] initWithFrame:CGRectMake(facebookShare.frame.origin.x + facebookShare.frame.size.width + 20,
                                                                                facebookShare.frame.origin.y + 5,
                                                                                facebookCreditsImage.size.width,
                                                                                facebookCreditsImage.size.height)];
    [facebookCredits setImage:facebookCreditsImage];
    [self.view addSubview:facebookCredits];
    
    
    UIImage *buyCreditsImage = [UIImage imageNamed:@"earncredits_30-Cr.png"];
    UIImageView *buyCredits = [[UIImageView alloc] initWithFrame:CGRectMake(facebookCredits.frame.origin.x,
                                                                            buyButton.frame.origin.y + 5,
                                                                            buyCreditsImage.size.width,
                                                                            buyCreditsImage.size.height)];
    [buyCredits setImage:buyCreditsImage];
    [self.view addSubview:buyCredits];

    
    
    
    UIImage *twitterImage = [UIImage imageNamed:@"earncredits_share-on-twitter"];
    UIButton *twitterShare = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width / 2) - (twitterImage.size.width / 2) - 30,
                                                                        facebookShare.frame.origin.y + facebookShare.frame.size.height + 50,
                                                                        twitterImage.size.width - 30,
                                                                        twitterImage.size.height)];
    [twitterShare setImage:twitterImage forState:UIControlStateNormal];
    [twitterShare addTarget:self action:@selector(shareOnTwitter) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:twitterShare];
    
    UIImage *twitterCreditsImage = [UIImage imageNamed:@"earncredits_5-Cr"];
    UIImageView *twitterCredits = [[UIImageView alloc] initWithFrame:CGRectMake(facebookCredits.frame.origin.x,
                                                                             twitterShare.frame.origin.y + 5,
                                                                             twitterCreditsImage.size.width,
                                                                              twitterCreditsImage.size.height)];
    [twitterCredits setImage:twitterCreditsImage];
    [self.view addSubview:twitterCredits];
    
    UIImage *watchVideoImage = [UIImage imageNamed:@"watch videos.png"];
    
    watchVideo = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width / 2) - (watchVideoImage.size.width / 2) - 30,
                                                            twitterShare.frame.origin.y + twitterShare.frame.size.height + 50,
                                                            watchVideoImage.size.width - 30,
                                                            watchVideoImage.size.height)];
    [watchVideo setImage:watchVideoImage forState:UIControlStateNormal];
    [watchVideo addTarget:self action:@selector(watchVideoPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:watchVideo];
    
    UIImage *videosImages = [UIImage imageNamed:@"earncredits_3-Cr"];
    UIImageView *videosCredits = [[UIImageView alloc] initWithFrame:CGRectMake(facebookCredits.frame.origin.x,
                                                                              watchVideo.frame.origin.y + 5,
                                                                              videosImages.size.width,
                                                                               videosImages.size.height)];
    [videosCredits setImage:videosImages];
    [self.view addSubview:videosCredits];
    
    UIImage *noteImage = [UIImage imageNamed:@"earncredits_note"];
    UIImageView *note = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width / 2) - (noteImage.size.width / 2),
                                                                     watchVideo.frame.origin.y + 50,
                                                                     noteImage.size.width,
                                                                      noteImage.size.height)];
    [note setImage:noteImage];
    [self.view addSubview:note];
    
    
    
	if(IS_IPHONE_5){
        //self.view.frame = CGRectMake(0, 0, 320, 568);
        
        CGRect btbalFrame = balance.frame;
        btbalFrame.origin.x = 268;
        btbalFrame.origin.y = 3 + 4;
        balance.frame = btbalFrame;
        
        /*CGRect btnameFrame = name.frame;
        btnameFrame.origin.x = EARN_VIDEOS_LABEL_X;
        btnameFrame.origin.y = 20 + EARN_VIDEOS_LABEL_Y;
        name.frame = btnameFrame;
        
        CGRect btrefreshLabelFrame = refreshLabel.frame;
        btrefreshLabelFrame.origin.x = EARN_REFRESH_LABEL_X;
        btrefreshLabelFrame.origin.y = 20 + EARN_REFRESH_LABEL_Y;
        refreshLabel.frame = btrefreshLabelFrame;

        //CGRect btvidFrame = watchVideo.frame;
        //btvidFrame.origin.x = EARN_VIDEOS_BUTTON_X;
        //btvidFrame.origin.y = 20 + EARN_VIDEOS_BUTTON_Y;
        //watchVideo.frame = btvidFrame;*/
        
        CGRect btbackFrame = backButton.frame;
        btbackFrame.origin.x = EARN_BACK_BUTTON_X;
        btbackFrame.origin.y = 150 + EARN_BACK_BUTTON_Y;
        backButton.frame = btbackFrame;
        
    }
    
    UIImage *refreshImage = [UIImage imageNamed:@"_0001_refresh.png"];
    refreshButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - refreshImage.size.width,
                                                              backButton.frame.origin.y + 3,
                                                              refreshImage.size.width - 20,
                                                               refreshImage.size.height)];
    
    [refreshButton setImage:refreshImage forState:UIControlStateNormal];
    [refreshButton addTarget:self action:@selector(refreshPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:refreshButton];
    
    
    self.products = nil;
    [[SnakeIAPHelper sharedInstance] requestProductsWithCompletionHandler:^(BOOL success, NSArray *getProducts) {
        if (success) {
            self.products = getProducts;
            for (SKProduct * product in self.products){
                NSLog(@"product : %@", product.productIdentifier);
            }
        }
    }];
    
    
	
}

-(void)setBackground{
     SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
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

}

-(void)viewWillAppear:(BOOL)animated{
    [self setBackground];
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

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"UPDATE_CREDITS" object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(giveCreditsForPurchase) name:IAPHelperProductPurchasedNotification object:nil];
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
    
        NSString *idfaString = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
        if(((unsigned long)[emailTextField.text length]) > 0 ){
            NSString *urlString = [NSString stringWithFormat:@"http://zingapps.co/setEmail.php?idfa=%@&email=%@&vendorID=%@",idfaString,emailTextField.text,vendorID];
        
    
	
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
            NSURLResponse *response = nil;
        
            NSError *e = nil;
            NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&e];

            NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
            if([responseString isEqualToString:@"Email exists"]){
            
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Email ID Exists:" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
                [alertView setTag:2];
                [alertView show];
            
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

-(void)buyCredits{
    TSEvent *e = [TSEvent eventWithName:@"Earn Credits_Buy Credits" oneTimeOnly:NO];
    [[TSTapstream instance] fireEvent:e];
    for (SKProduct * product in self.products){
        NSLog(@"product : %@", product.productIdentifier);
        if ([product.productIdentifier isEqualToString:SnakeIAPProductName]) {
            [[SnakeIAPHelper sharedInstance] buyProduct:product];
        }
    }
}


-(void)shareOnFacebook{
    TSEvent *e = [TSEvent eventWithName:@"Earn Credits_Facebook Share" oneTimeOnly:NO];
    [[TSTapstream instance] fireEvent:e];
	
    SLComposeViewController *fbController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    
    [fbController setInitialText: [NSString stringWithFormat:@"Yes, this is the same old Snake. Best game ever."]];
    
    //[controller2 setInitialText:@"First post from my iPhone app"];
    [fbController addURL:[NSURL URLWithString:@"https://itunes.apple.com/in/app/snake-classic/id394603141?mt=8"]];
    [fbController addImage:[UIImage imageNamed:@"http://zingapps.co/FBlogo.png"]];
    
    
    SLComposeViewControllerCompletionHandler __block completionHandler=^(SLComposeViewControllerResult result){
        
        [fbController dismissViewControllerAnimated:YES completion:nil];
        
        switch(result){
            case SLComposeViewControllerResultCancelled:
            {
                 NSLog(@"Cancelled.....");

            }
                break;
            case SLComposeViewControllerResultDone:
            {
                NSLog(@"DONE");
                
                BOOL giveCredits = YES;
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                NSString *lastPostDate = [defaults objectForKey:@"FACEBOOK_EARN_SHARE"];
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateStyle:NSDateFormatterFullStyle];
                [dateFormatter setTimeStyle:NSDateFormatterFullStyle];
                NSDate *today = [[NSDate alloc] init];
                if (lastPostDate) {
                    
                    NSDate *lastDate = [dateFormatter dateFromString:lastPostDate];
                    
                    if ([today compare:[lastDate dateByAddingTimeInterval:24*60*60]] == NSOrderedAscending) {
                        giveCredits = NO;
                    }
                }
                
                if (giveCredits) {
                    [defaults setObject:[dateFormatter stringFromDate:today] forKey:@"FACEBOOK_EARN_SHARE"];
                    /*NSString *idfaString = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
                    NSString *urlString = [NSString stringWithFormat:@"http://zingapps.co/put_balance.php?idfa=%@&rewardquantity=10",idfaString];
                    
                    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
                    
                    [request setTimeoutInterval:15];
                    [request setURL:[NSURL URLWithString:urlString]];
                    
                    NSData *responseDataSerial = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
                    
                    NSString *connected = [[NSString alloc] initWithData:responseDataSerial encoding:NSUTF8StringEncoding];
                    if (!connected) {
                        NSLog(@"Unable to give credits");
                    }*/
                    SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
                    
                    [delegate putBalanceForUser:10];
                }

            }
                break;
            default:{
                NSLog(@"Default");
            }
                break;
        }};
    [fbController setCompletionHandler:completionHandler];

    
    
    [self presentViewController:fbController animated:YES completion:Nil];

    
}

-(void)shareOnTwitter{
    TSEvent *e = [TSEvent eventWithName:@"Earn Credits_Twiiter Share" oneTimeOnly:NO];
    [[TSTapstream instance] fireEvent:e];
    SLComposeViewController *tweetSheet;
    tweetSheet = [[SLComposeViewController alloc] init];

    tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    [tweetSheet setInitialText: [NSString stringWithFormat:@"Check out a true classic - Snake Classic for iOS! http://bit.ly/1iRQnvC"]];
    
    SLComposeViewControllerCompletionHandler __block completionHandler=^(SLComposeViewControllerResult result){
        
        [tweetSheet dismissViewControllerAnimated:YES completion:nil];
        
        switch(result){
            case SLComposeViewControllerResultCancelled:
            {
                NSLog(@"Cancelled.....");
                //SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
                //[delegate putBalanceForUser:5];
                
            }
                break;
            case SLComposeViewControllerResultDone:
            {
                BOOL giveCredits = YES;
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                NSString *lastPostDate = [defaults objectForKey:@"TWITTER_EARN_SHARE"];
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateStyle:NSDateFormatterFullStyle];
                [dateFormatter setTimeStyle:NSDateFormatterFullStyle];
                NSDate *today = [[NSDate alloc] init];
                if (lastPostDate) {
                    
                    NSDate *lastDate = [dateFormatter dateFromString:lastPostDate];

                    if ([today compare:[lastDate dateByAddingTimeInterval:24*60*60]] == NSOrderedAscending) {
                        giveCredits = NO;
                    }
                }
                
                if (giveCredits) {
                    [defaults setObject:[dateFormatter stringFromDate:today] forKey:@"TWITTER_EARN_SHARE"];
                    /*NSString *idfaString = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
                    NSString *urlString = [NSString stringWithFormat:@"http://zingapps.co/put_balance.php?idfa=%@&rewardquantity=5",idfaString];
                    
                    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
                    
                    [request setTimeoutInterval:15];
                    [request setURL:[NSURL URLWithString:urlString]];
                    
                    NSData *responseDataSerial = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
                    
                    NSString *connected = [[NSString alloc] initWithData:responseDataSerial encoding:NSUTF8StringEncoding];
                    if (!connected) {
                        NSLog(@"Unable to give credits");
                    }*/
                    
                    SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
                    
                    [delegate putBalanceForUser:5];
                }
            }
                break;
            default:{
                NSLog(@"default");
            }
                break;
        }};
    [tweetSheet setCompletionHandler:completionHandler];
    
    
    [self presentViewController:tweetSheet animated:YES completion:nil];

}

- (IBAction) watchVideoPressed{
    
    TSEvent *e = [TSEvent eventWithName:@"Earn Credits_Watch Video" oneTimeOnly:NO];
    [[TSTapstream instance] fireEvent:e];
    [AdColony playVideoAdForZone:@"vz8a85a435f2b346368c"
                    withDelegate:nil
                withV4VCPrePopup:NO
                andV4VCPostPopup:NO];
    
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
    
    [self viewDidAppear:true];
    
}


// Function to refresh the app suggested to the user

/*- (void)productPurchased:(NSNotification *)notification {
    NSString * productIdentifier = notification.object;
    if ([productIdentifier isEqualToString:SnakeIAPProductName]) {
        SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
        [delegate putBalanceForUser:30];
        UIAlertView *purchasedAlert = [[UIAlertView alloc] initWithTitle:@"Congrtulations" message:@"Congratulations you have succesfully purchased 30 credits" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [purchasedAlert show];
    }
}*/
-(void) refresh{
    
    if(IS_IPHONE_5){
        CGRect btbackFrame = backButton.frame;
        btbackFrame.origin.x = EARN_BACK_BUTTON_X;
        btbackFrame.origin.y = 150 + EARN_BACK_BUTTON_Y;
        backButton.frame = btbackFrame;
    }
    else{
        CGRect btbackFrame = backButton.frame;
        btbackFrame.origin.x = EARN_BACK_BUTTON_X;
        btbackFrame.origin.y = EARN_BACK_BUTTON_Y;
        backButton.frame = btbackFrame;
    }

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
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UPDATE_CREDITS" object:nil];
    //[[NSNotificationCenter defaultCenter] removeObserver:self name:IAPHelperProductPurchasedNotification object:nil];
    
	
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
