//
//  foodType.h
//  
//
//  Created by Swapan Rajdev on 7/31/10.
//  Copyright Zing! Apps 2010. All rights reserved.
//
//  Description: This object contains all the data for the food that is displayed as part of the game.
//               There are 2 types of food. Normal food which appears at all the time and
//               Bonus food which appears at regular intervals of time and stays on the screen only for 
//               a short period of time


#import <Foundation/Foundation.h>


@interface foodType : NSObject {
	
	CGFloat food_x;
	CGFloat food_y;
	
	CGFloat bonus_food_x;
	CGFloat bonus_food_y;
	

}

@property CGFloat food_x;
@property CGFloat food_y;
@property CGFloat bonus_food_x;
@property CGFloat bonus_food_y;




-(void)generateRandomFood;
-(void)generateBonusFood;

@end
