//
//  MyAdView.h
//  HelloWorld
//
//  Created by Ryan Osborn on 7/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "FlurryOffer.h"


@interface MyAdView : UIView {
	UIImageView *myImage;
	UILabel *appNameLabel;
	NSString *referralUrl;
	NSURL * nsurl;
}

- (id)initWithFrame:(CGRect)frame appIcon:(UIImage*)icon referralUrl:(NSString*)url;
- (void)downloadApp;

@end
