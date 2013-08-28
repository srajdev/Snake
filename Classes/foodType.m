//
//  foodType.m
//  
//
//  Created by Swapan Rajdev on 7/31/10.
//  Copyright 2010 Zing! Apps. All rights reserved.
//
//  Description: This object contains all the data for the food that is displayed as part of the game.
//               There are 2 types of food. Normal food which appears at all the time and
//               Bonus food which appears at regular intervals of time and stays on the screen only for 
//               a short period of time


#import "foodType.h"
#import "SnakeClassicAppDelegate.h"


@implementation foodType

@synthesize food_x;
@synthesize food_y;

@synthesize bonus_food_x;
@synthesize bonus_food_y;

/* Function to generate random position for the food one the food is eaten */
-(void)generateRandomFood{
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];

	do{
		
		food_x = ((arc4random() % 30) * 10 ) - 7.5 ;
		food_y = ((arc4random() % 30) * 10 ) - 7.5 ;
		
		
	}while(food_x > 305 || food_y > 285 || food_x < 15 || food_y < 15);
	

	// If the food is at the same position as the bonus food .. re generate the food
	if (food_x == bonus_food_x && food_y == bonus_food_y) {
		food_x = ((arc4random() % 30) * 10 ) - 7.5 ;
		food_y = ((arc4random() % 30) * 10 ) - 7.5 ;

	}
	
	
	while (delegate.fieldMode == kSquareWall && ((food_x > 130 && food_x < 140) || (food_x > 180 && food_x < 190) )) {
		do{
			
			food_x = ((arc4random() % 30) * 10 ) - 7.5 ;
			food_y = ((arc4random() % 30) * 10 ) - 7.5 ;
			
			
		}while(food_x > 305 || food_y > 285 || food_x < 15 || food_y < 15);
	}
}


// Function to generate random bonus food

-(void)generateBonusFood{
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	do{
		
		bonus_food_x = ((arc4random() % 30) * 10 ) - 7.5;
		bonus_food_y = ((arc4random() % 30) * 10 ) - 7.5;
	}while(bonus_food_x > 305 || bonus_food_y > 285 || bonus_food_x < 15 || bonus_food_y < 15);
	
	while (delegate.fieldMode == kSquareWall && ((bonus_food_x > 130 && bonus_food_x < 140) || (bonus_food_x > 180 && bonus_food_x < 190) )) {
		do{
			
			bonus_food_x = ((arc4random() % 30) * 10 ) - 7.5 ;
			bonus_food_y = ((arc4random() % 30) * 10 ) - 7.5 ;
			
			
		}while(food_x > 305 || food_y > 285 || food_x < 15 || food_y < 15);
	}
	
	
	
}

// Initialize the food and bonus food by choosing a random position


-(id)init{
	
	SnakeClassicAppDelegate *delegate = (SnakeClassicAppDelegate *)[[UIApplication sharedApplication] delegate];
	if (self = [super init] ) {
		
		do {
			food_x = ((arc4random() % 32) * 10 ) - 7.5 ; //158.0;
			food_y = ((arc4random() % 32) * 10 ) -  7.5 ; //98.0;
			
			
			bonus_food_x = -10;
			bonus_food_y = -10;
		}while(food_x > 305 || food_y > 285 || food_x < 15 || food_y < 105);
		
		
		while (delegate.fieldMode == kSquareWall  && ((food_x > 130 && food_x < 140) || (food_x > 180 && food_x < 190) )) {
			do{
				
				food_x = ((arc4random() % 30) * 10 ) - 7.5 ;
				food_y = ((arc4random() % 30) * 10 ) - 7.5 ;
				
				
			}while(food_x > 305 || food_y > 285 || food_x < 15 || food_y < 15);
		}
		
	
		
	}
	
	
	return (self);
}


@end
