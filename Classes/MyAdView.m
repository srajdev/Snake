//
//  MyAdView.m
//  HelloWorld
//
//  Created by Ryan Osborn on 7/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MyAdView.h"
//#import "FlurryOffer.h"


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

- (void)downloadApp {
	// allow this object to respond to touch or click.

	@try {
		nsurl = [NSURL URLWithString:referralUrl];
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
