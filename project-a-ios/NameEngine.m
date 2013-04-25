//  NameEngine.m
//  project-a-ios
//
//  Created by Mike Bell on 4/25/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "NameEngine.h"
#import "Dice.h"

@implementation NameEngine

@synthesize catNameIndex;
@synthesize catNameArray;

static NameEngine *_sharedEngine;

+(NameEngine *) sharedEngine {
    static BOOL initialized = NO;
    if ( ! initialized ) {
        initialized = YES;
        _sharedEngine = [[ NameEngine alloc ] init ];
    }
    return _sharedEngine;
}


-(id) init {
    if ((self=[super init])) {
        catNameIndex = 0;
        catNameArray = [[NSArray alloc] initWithObjects:
                     @"Max",
                     @"Chloe",
                     @"Bella",
                     @"Oliver",
                     @"Asparagus",
                     @"Tiger",
                     @"Smokey",
                     @"Shadow",
                     @"Lucy",
                     @"Angel",
                        nil];
    }
    return self;
}


-(NSString *) getNextCatName {
    NSString *returnName = nil;
    
    if ( catNameIndex < [catNameArray count] && catNameIndex >= 0 ) {
        returnName = [catNameArray objectAtIndex: catNameIndex];
        catNameIndex++;
        if ( catNameIndex >= [catNameArray count] ) {
            catNameIndex = 0;
        }
    }
    
    //return returnName;
    return [NSString stringWithFormat: @"%@ the Cat", returnName];
}


-(NSString *) getRandomCatName {
    NSInteger index = [Dice roll:[catNameArray count]];
    //return [catNameArray objectAtIndex:index];
    return [NSString stringWithFormat: @"%@ the Cat", [catNameArray objectAtIndex:index]];
}


@end
