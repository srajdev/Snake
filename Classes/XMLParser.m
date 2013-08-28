//
//  XMLParser.m
//  SnakeClassic
//
//  Created by Swapan Rajdev on 10/5/10.
//  Copyright 2010 Zing! Apps. All rights reserved.
//
// Update V1.1: New File
// Description: This object helps Parse the XML received from the server with high scores

#import "XMLParser.h"
#import "SnakeClassicAppDelegate.h"
#import "GlobalScoreRecord.h"


@implementation XMLParser


-(XMLParser *)initXMLParser{

	[super init];
	
	appDelegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	
	return self;
	
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName 
	attributes:(NSDictionary *)attributeDict {
	
	if([elementName isEqualToString:@"topscores"]) {
		//Initialize the array.
		appDelegate.globalScores = [[NSMutableArray alloc] init];
	}
	else if([elementName isEqualToString:@"score"]) {
		
		//Initialize the book.
		aScore = [[GlobalScoreRecord alloc] init];
		
		//Extract the attribute here.
		aScore.rank = [[attributeDict objectForKey:@"id"] integerValue];
		
		
	}
	

}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string { 
	
	if(!currentElementValue) 
		currentElementValue = [[NSMutableString alloc] initWithString:string];
	else
		[currentElementValue appendString:string];
	

	
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	
	if([elementName isEqualToString:@"topscpres"])
		return;
	
	//There is nothing to do if we encounter the topscores element here.
	//If we encounter the score element howevere, we want to add the score object to the array
	// and release the object.
	if([elementName isEqualToString:@"score"]) {
		[appDelegate.globalScores addObject:aScore];
		
		[aScore release];
		aScore = nil;
	}
	else 
		[aScore setValue:currentElementValue forKey:elementName];
	
	[currentElementValue release];
	currentElementValue = nil;
}



@end
