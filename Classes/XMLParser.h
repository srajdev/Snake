//
//  XMLParser.h
//  SnakeClassic
//
//  Created by Swapan Rajdev on 10/5/10.
//  Copyright 2010 Zing! Apps. All rights reserved.
//
// Update V1.1: New File
// Description: This object helps Parse the XML received from the server with high scores

#import <Foundation/Foundation.h>

@class SnakeClassicAppDelegate, GlobalScoreRecord;

@interface XMLParser : NSObject <NSXMLParserDelegate> {

	NSMutableString *currentElementValue;
	
	SnakeClassicAppDelegate *appDelegate;
	GlobalScoreRecord *aScore;

}

-(XMLParser *) initXMLParser;

@end
