//
//  MyAdView.m
//  HelloWorld
//
//  Created by Ryan Osborn on 7/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MyAdView.h"
#import "FlurryOffer.h"


@implementation MyAdView


- (id)initWithFrame:(CGRect)frame appIcon:(UIImage*)icon referralUrl:(NSString*)url {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }

	// create icon and add it to this ad offer view.
	myImage = [[UIImageView alloc] initWithFrame:frame];
	[myImage setImage:icon];
	myImage.opaque = YES;
	[self addSubview:myImage];
	referralUrl = [url copy];

    return self;
}


- (id)initWithFlurryOffer:(FlurryOffer*)flurryOffer {
	// this will instantiate our very own customized view of
	// an ad offer. it uses the FlurryOffer object to create
	// this as a viewable banner with icon, app name, and url
	// to visit when this ad offer is touched or clicked.

	CGRect appNameRect = CGRectMake(50.0f, 0.0f, 300.0f, 50.0f);
	CGRect myImageRect = CGRectMake(0.0f, 0.0f, 50.0f, 50.0f);

	[self initWithFrame:appNameRect];

	// create icon and add it to this ad offer view.
	myImage = [[UIImageView alloc] initWithFrame:myImageRect];
	[myImage setImage:flurryOffer.appIcon];
	myImage.opaque = YES;
	[self addSubview:myImage];
	
	// create app name label and add it to this ad offer view.
	appNameLabel = [[UILabel alloc] initWithFrame:appNameRect];
	[appNameLabel setText:flurryOffer.appName];
	[self addSubview:appNameLabel];
	
	// save the referral url to use later when this ad view is
	// touched or clicked on by app users.
	referralUrl = [flurryOffer.referralUrl copy];
	return self;
}

- (void)downloadApp {
	// allow this object to respond to touch or click.

	@try {
		nsurl = [NSURL URLWithString:referralUrl];

		// open up the referralUrl provided by Flurry getOffer,
		// which will take users to the App Store related page.
		[[UIApplication sharedApplication] openURL:nsurl];
	}
	@catch (id e) {
		//NSLog(@"HelloWorld: Exception = %@",e);
	}
}


- (void)dealloc {
    [super dealloc];
}


@end
