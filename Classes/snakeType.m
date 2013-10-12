//
//  snakeType.m
//  
//
//  Created by Swapan Rajdev on 7/31/10.
//  Copyright 2010 Zing! Apps. All rights reserved.
//
//  Description: This object keeps a track of all the various data required for the snake.

#import "snakeType.h"
#import "constants.h"


@implementation snakeType

@synthesize head_x;
@synthesize head_y;

@synthesize tail_x;
@synthesize tail_y;

@synthesize headDirection;
@synthesize tailDirection;

@synthesize snakeColor;

@synthesize bends;
@synthesize bend_direction;

@synthesize i;



// Initilazie the snake.
-(id)init{
	if(self = [super init]){

		if(IS_IPHONE_5){
            head_x = 135.0;
            //head_y = 105.0;
            head_y = 185.0;
            
            tail_x = 45.0;
            //tail_y = 105.0;
            tail_y = 185.0;
        }
		else{
	
        head_x = 135.0;
		//head_y = 105.0;
		head_y = 145.0;
		
		tail_x = 45.0;
		//tail_y = 105.0;
		tail_y = 145.0;
		}
		
		
		headDirection = kEastDirection;
		
		tailDirection = kEastDirection;
		
		snakeColor = [UIColor greenColor];
		
		bends = [[NSMutableArray alloc] init];
		
		bend_direction = [[NSMutableArray alloc] init];
		
		i=1;
		
	}
	
	
	
	return (self);
}


// Function to move the snake right.
-(void)moveSnakeEast{
	

	/*storing bends value*/
	CGPoint old_head = CGPointMake(head_x, head_y);
	NSData *value = [NSData dataWithBytes:&old_head length:sizeof(CGPoint)];
	[bends addObject: value];
	
	/*Direction of Bend*/
	Direction bend_dir = kEastDirection;
	NSData *bend_dir_value = [NSData dataWithBytes:&bend_dir length:sizeof(Direction)];
	[bend_direction addObject:bend_dir_value];
	
	/*update head to go right*/
	head_x = head_x + SNAKE_INCREMENT;
	headDirection = kEastDirection;
	

	
	CGPoint old_head_2 = CGPointMake(5.0, head_y);
	
	
	if (head_x > 315.0) {

		
		NSData *value_2 = [NSData dataWithBytes:&old_head_2 length:sizeof(CGPoint)];
		[bends addObject: value_2];
		
		Direction bend_dir_2 = kEastIn;
		NSData *bend_dir_value_2 = [NSData dataWithBytes:&bend_dir_2 length:sizeof(Direction)];
		[bend_direction addObject:bend_dir_value_2];
		
		head_x = 5.0;
	}
	

	
	
}
	
// Function to move the snake left.
-(void)moveSnakeWest{
	
	/*storing bends value*/
	CGPoint old_head = CGPointMake(head_x, head_y);
	NSData *value = [NSData dataWithBytes:&old_head length:sizeof(CGPoint)];
	[bends addObject: value]; 
	
	/*Direction of Bend*/
	Direction bend_dir = kWestDirection;
	NSData *bend_dir_value = [NSData dataWithBytes:&bend_dir length:sizeof(Direction)];
	[bend_direction addObject:bend_dir_value];
	
	
	/*update head to go left*/
	head_x = head_x - SNAKE_INCREMENT;
	headDirection = kWestDirection;
	
		
	CGPoint old_head_2 = CGPointMake(315.0, head_y);
	
	
	
	if (head_x < 5.0) {

		
		NSData *value_2 = [NSData dataWithBytes:&old_head_2 length:sizeof(CGPoint)];
		[bends addObject: value_2];
		
		Direction bend_dir_2 = kWestIn;
		NSData *bend_dir_value_2 = [NSData dataWithBytes:&bend_dir_2 length:sizeof(Direction)];
		[bend_direction addObject:bend_dir_value_2];
		
		head_x = 315.0;
	}
}

// Function to move the snake up.
-(void)moveSnakeNorth{
	
	/*storing bends value*/
	CGPoint old_head = CGPointMake(head_x, head_y);
	NSData *value = [NSData dataWithBytes:&old_head length:sizeof(CGPoint)];
	[bends addObject: value]; 
	
	/*Direction of Bend*/
	Direction bend_dir = kNorthDirection;
	NSData *bend_dir_value = [NSData dataWithBytes:&bend_dir length:sizeof(Direction)];
	[bend_direction addObject:bend_dir_value];
	
	
	/*update head to go up*/
	head_y = head_y - SNAKE_INCREMENT;
	headDirection = kNorthDirection;
	
	
	if(IS_IPHONE_5){
        
        CGPoint old_head_2 = CGPointMake(head_x, 385.0);

        
        if (head_y < 5.0) {
            
            
            NSData *value_2 = [NSData dataWithBytes:&old_head_2 length:sizeof(CGPoint)];
            [bends addObject: value_2];
            
            Direction bend_dir_2 = kNorthIn;
            NSData *bend_dir_value_2 = [NSData dataWithBytes:&bend_dir_2 length:sizeof(Direction)];
            [bend_direction addObject:bend_dir_value_2];
            
            head_y = 385.0;
            
        }
    }
	else{
        CGPoint old_head_2 = CGPointMake(head_x, 295.0);

	if (head_y < 5.0) {
		
		
		NSData *value_2 = [NSData dataWithBytes:&old_head_2 length:sizeof(CGPoint)];
		[bends addObject: value_2];
		
		Direction bend_dir_2 = kNorthIn;
		NSData *bend_dir_value_2 = [NSData dataWithBytes:&bend_dir_2 length:sizeof(Direction)];
		[bend_direction addObject:bend_dir_value_2];
		
        head_y = 295.0;
        
	}
	}
}

// Function to move the snake down.
-(void)moveSnakeSouth{
	
	/*storing bends value*/
	CGPoint old_head = CGPointMake(head_x, head_y);
	NSData *value = [NSData dataWithBytes:&old_head length:sizeof(CGPoint)];
	[bends addObject: value]; 
	
	/*Direction of Bend*/
	Direction bend_dir = kSouthDirection;
	NSData *bend_dir_value = [NSData dataWithBytes:&bend_dir length:sizeof(Direction)];
	[bend_direction addObject:bend_dir_value];
	
	
	/*update head to go down*/
	head_y = head_y + SNAKE_INCREMENT;
	headDirection = kSouthDirection;
	
	
	CGPoint old_head_2 = CGPointMake(head_x, 5.0);
	
    if(IS_IPHONE_5) {
        if (head_y > 385.0) {
            
            
            NSData *value_2 = [NSData dataWithBytes:&old_head_2 length:sizeof(CGPoint)];
            [bends addObject: value_2];
            
            Direction bend_dir_2 = kSouthIn;
            NSData *bend_dir_value_2 = [NSData dataWithBytes:&bend_dir_2 length:sizeof(Direction)];
            [bend_direction addObject:bend_dir_value_2];
            
            head_y = 5.0;
        }
        
    }
	else{
	if (head_y > 295.0) {
		
		
		NSData *value_2 = [NSData dataWithBytes:&old_head_2 length:sizeof(CGPoint)];
		[bends addObject: value_2];
		
		Direction bend_dir_2 = kSouthIn;
		NSData *bend_dir_value_2 = [NSData dataWithBytes:&bend_dir_2 length:sizeof(Direction)];
		[bend_direction addObject:bend_dir_value_2];
		
		head_y = 5.0;
	}
    }
}


// Function to move the snake right with time.

-(void)moveSnakeTimerEast{
	
	CGPoint old_head = CGPointMake(head_x, head_y);
	
	CGPoint old_head_2 = CGPointMake(5.0, head_y);
	
	
	head_x = head_x + SNAKE_INCREMENT;
	headDirection = kEastDirection;
	
	if (head_x > 315.0) {
		NSData *value = [NSData dataWithBytes:&old_head length:sizeof(CGPoint)];
		[bends addObject: value]; 
		
		Direction bend_dir = kEastDirection;
		NSData *bend_dir_value = [NSData dataWithBytes:&bend_dir length:sizeof(Direction)];
		[bend_direction addObject:bend_dir_value];
		
		NSData *value_2 = [NSData dataWithBytes:&old_head_2 length:sizeof(CGPoint)];
		[bends addObject: value_2];
		
		Direction bend_dir_2 = kEastIn;
		NSData *bend_dir_value_2 = [NSData dataWithBytes:&bend_dir_2 length:sizeof(Direction)];
		[bend_direction addObject:bend_dir_value_2];
		
		head_x = 5.0;
	}
	
	

}
// Function to move the snake left with time.

-(void)moveSnakeTimerWest{
	
	CGPoint old_head = CGPointMake(head_x, head_y);
	
	CGPoint old_head_2 = CGPointMake(315.0, head_y);
	
	head_x = head_x - SNAKE_INCREMENT;
	headDirection = kWestDirection;
	
	if (head_x < 5.0) {
		NSData *value = [NSData dataWithBytes:&old_head length:sizeof(CGPoint)];
		[bends addObject: value]; 
		
		Direction bend_dir = kWestDirection;
		NSData *bend_dir_value = [NSData dataWithBytes:&bend_dir length:sizeof(Direction)];
		[bend_direction addObject:bend_dir_value];
		
		NSData *value_2 = [NSData dataWithBytes:&old_head_2 length:sizeof(CGPoint)];
		[bends addObject: value_2];
		
		Direction bend_dir_2 = kWestIn;
		NSData *bend_dir_value_2 = [NSData dataWithBytes:&bend_dir_2 length:sizeof(Direction)];
		[bend_direction addObject:bend_dir_value_2];
		
		head_x = 315.0;
	}
	
	
	
}
// Function to move the snake up with time.

-(void)moveSnakeTimerNorth{
	
	CGPoint old_head = CGPointMake(head_x, head_y);
	
	head_y = head_y - SNAKE_INCREMENT;
	headDirection = kNorthDirection;
    
	if(IS_IPHONE_5){
        CGPoint old_head_2 = CGPointMake(head_x, 385.0);
        
        if (head_y < 5.0) {
            NSData *value = [NSData dataWithBytes:&old_head length:sizeof(CGPoint)];
            [bends addObject: value];
            
            Direction bend_dir = kNorthDirection;
            NSData *bend_dir_value = [NSData dataWithBytes:&bend_dir length:sizeof(Direction)];
            [bend_direction addObject:bend_dir_value];
            
            NSData *value_2 = [NSData dataWithBytes:&old_head_2 length:sizeof(CGPoint)];
            [bends addObject: value_2];
            
            Direction bend_dir_2 = kNorthIn;
            NSData *bend_dir_value_2 = [NSData dataWithBytes:&bend_dir_2 length:sizeof(Direction)];
            [bend_direction addObject:bend_dir_value_2];
            
            head_y = 385.0;
            
        }
        
    }else{
        CGPoint old_head_2 = CGPointMake(head_x, 295.0);
        if (head_y < 5.0) {
            NSData *value = [NSData dataWithBytes:&old_head length:sizeof(CGPoint)];
            [bends addObject: value];
		
            Direction bend_dir = kNorthDirection;
            NSData *bend_dir_value = [NSData dataWithBytes:&bend_dir length:sizeof(Direction)];
            [bend_direction addObject:bend_dir_value];
		
            NSData *value_2 = [NSData dataWithBytes:&old_head_2 length:sizeof(CGPoint)];
            [bends addObject: value_2];
		
            Direction bend_dir_2 = kNorthIn;
            NSData *bend_dir_value_2 = [NSData dataWithBytes:&bend_dir_2 length:sizeof(Direction)];
            [bend_direction addObject:bend_dir_value_2];
		
            head_y = 295.0;
        
        }
    }
	
	
}

// Function to move the snake down with time.

-(void)moveSnakeTimerSouth{
	
	CGPoint old_head = CGPointMake(head_x, head_y);
	
	CGPoint old_head_2 = CGPointMake(head_x, 5.0);
	
	
	head_y = head_y + SNAKE_INCREMENT;
	headDirection = kSouthDirection;
    
	if(IS_IPHONE_5){
        if (head_y > 385.0) {
            NSData *value = [NSData dataWithBytes:&old_head length:sizeof(CGPoint)];
            [bends addObject: value];
            
            Direction bend_dir = kSouthDirection;
            NSData *bend_dir_value = [NSData dataWithBytes:&bend_dir length:sizeof(Direction)];
            [bend_direction addObject:bend_dir_value];
            
            NSData *value_2 = [NSData dataWithBytes:&old_head_2 length:sizeof(CGPoint)];
            [bends addObject: value_2];
            
            Direction bend_dir_2 = kSouthIn;
            NSData *bend_dir_value_2 = [NSData dataWithBytes:&bend_dir_2 length:sizeof(Direction)];
            [bend_direction addObject:bend_dir_value_2];
            
            head_y = 5.0;
        }
    }
    else{
	if (head_y > 295.0) {
		NSData *value = [NSData dataWithBytes:&old_head length:sizeof(CGPoint)];
		[bends addObject: value]; 
		
		Direction bend_dir = kSouthDirection;
		NSData *bend_dir_value = [NSData dataWithBytes:&bend_dir length:sizeof(Direction)];
		[bend_direction addObject:bend_dir_value];
		
		NSData *value_2 = [NSData dataWithBytes:&old_head_2 length:sizeof(CGPoint)];
		[bends addObject: value_2];
		
		Direction bend_dir_2 = kSouthIn;
		NSData *bend_dir_value_2 = [NSData dataWithBytes:&bend_dir_2 length:sizeof(Direction)];
		[bend_direction addObject:bend_dir_value_2];
		
		head_y = 5.0;
	}
    }
	
}
	

// Function to keep updating the tail as the snake moves.


-(void)updateTail{

if ([bends count] > 0) {
	
	NSData *bend_value = [bends objectAtIndex:0];
	CGPoint bend_point = *(CGPoint*)[bend_value bytes];
	
	NSData *bend_dir = [bend_direction objectAtIndex:0];
	Direction bend_dir_value = *(Direction*)[bend_dir bytes];
	
	
	if (tail_x == bend_point.x && tail_y == bend_point.y) {
		tailDirection = bend_dir_value;
		if (tailDirection == kEastIn) {
			
			tailDirection = kEastDirection;
		}
		if (tailDirection == kWestIn) {
			tailDirection = kWestDirection;
		}
		if (tailDirection == kNorthIn) {
			tailDirection = kNorthDirection;
		}
		if (tailDirection == kSouthIn) {
			tailDirection = kSouthDirection;
		}
		
		[bends removeObjectAtIndex:0];
		[bend_direction removeObjectAtIndex:0];
		
		bend_value = [bends objectAtIndex:0];
		bend_point = *(CGPoint*)[bend_value bytes];
		
		bend_dir = [bend_direction objectAtIndex:0];
		bend_dir_value = *(Direction*)[bend_dir bytes];
	}
	
	
	
	switch (tailDirection) {
		case kEastDirection:
			tail_x = tail_x + SNAKE_INCREMENT;
			tailDirection = kEastDirection;
			
			if (tail_x > 315.0) {
				tail_x = 5;
				
			}
			
			if (tail_x == bend_point.x && tail_y == bend_point.y) {
				tailDirection = bend_dir_value;
				
				[bends removeObjectAtIndex:0];
				[bend_direction removeObjectAtIndex:0];
			}
			
			if (tailDirection == kEastIn) {
				tailDirection = kEastDirection;
			}
			
			break;
		case kWestDirection:
			tail_x = tail_x - SNAKE_INCREMENT;
			tailDirection = kWestDirection;
			
			if (tail_x < 5.0) {
				tail_x = 315.0;
			}
			
			if (tail_x == bend_point.x && tail_y == bend_point.y) {
				tailDirection = bend_dir_value;
				
				[bends removeObjectAtIndex:0];
				[bend_direction removeObjectAtIndex:0];
			}
			
			if (tailDirection == kWestIn) {
				tailDirection = kWestDirection;
			}
			break;
					
		case kNorthDirection:
			tail_y = tail_y - SNAKE_INCREMENT;
			tailDirection = kNorthDirection;
			if(IS_IPHONE_5){
                if (tail_y < 5.0) {
                    tail_y = 385.0;
                }
            }
            else{
                if (tail_y < 5.0) {
                    tail_y = 295.0;
                }
            }
            
			
			if (tail_x == bend_point.x && tail_y == bend_point.y) {
				tailDirection = bend_dir_value;
				
				[bends removeObjectAtIndex:0];
				[bend_direction removeObjectAtIndex:0];
			}
			
			if (tailDirection == kNorthIn) {
				tailDirection = kNorthDirection;
			}
			
			
			break;
		case kSouthDirection:
			tailDirection = kSouthDirection;
			tail_y = tail_y + SNAKE_INCREMENT;
			if(IS_IPHONE_5){
                if (tail_y > 385.0) {
                    tail_y = 5.0;
                }
            }
            else{
			if (tail_y > 295.0) {
				tail_y = 5.0;
			}
			}
			if (tail_x == bend_point.x && tail_y == bend_point.y) {
				tailDirection = bend_dir_value;
				
				[bends removeObjectAtIndex:0];
				[bend_direction removeObjectAtIndex:0];
			}
			
			if (tailDirection == kSouthIn) {
				tailDirection = kSouthDirection;
			}
			
			
			break;


		default:
			break;
			
			
	}
}
else {
	switch (tailDirection) {
		case kEastDirection:
			tail_x = tail_x + SNAKE_INCREMENT;
			tailDirection = kEastDirection;
			
			break;
		case kWestDirection:
			tail_x = tail_x - SNAKE_INCREMENT;
			tailDirection = kWestDirection;
			
			break;
			
		case kNorthDirection:
			tail_y = tail_y - SNAKE_INCREMENT;
			tailDirection = kNorthDirection;
			
						
			
			break;
		case kSouthDirection:
			tailDirection = kSouthDirection;
			tail_y = tail_y + SNAKE_INCREMENT;
			
			
			break;
			
			
		default:
			break;
			
			
	}
}



}




@end
