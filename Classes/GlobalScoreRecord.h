//
//  GlobalScoreRecord.h
//  SnakeClassic
//
//  Created by Swapan Rajdev on 10/6/10.
//  Copyright 2010 Zing! Apps. All rights reserved.
//
// Update V1.1: New File
// Description: This object stores the data for the global and facebook friends score

#import <Foundation/Foundation.h>


@interface GlobalScoreRecord : NSObject {
	
	
	NSInteger rank;
	NSString *name;
	NSString *value;
	NSString *fbname;
	NSString *fbid;
	NSString *mode;

}


@property (nonatomic,readwrite) NSInteger rank;
@property (nonatomic,retain) NSString *name;
@property (nonatomic,retain) NSString *value;
@property (nonatomic,retain) NSString *fbname;
@property (nonatomic,retain) NSString *fbid;
@property (nonatomic,retain) NSString *mode;

@end
