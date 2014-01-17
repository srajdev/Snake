//
//  SnakeIAPHelper.m
//  SnakeClassic
//
//  Created by Swapan Rajdev on 1/17/14.
//
//

#import "SnakeIAPHelper.h"

@implementation SnakeIAPHelper

+ (SnakeIAPHelper *)sharedInstance{
    static dispatch_once_t once;
    static SnakeIAPHelper * sharedInstance;
    dispatch_once(&once, ^{
        NSSet * productIdentifiers = [NSSet setWithObjects:
                                      @"SnakeCredits1305",
                                      nil];
        sharedInstance = [[self alloc] initWithProductIdentifiers:productIdentifiers];
    });
    return sharedInstance;
}

@end
