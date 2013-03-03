//
//  Dice.m
//  project-a-ios
//
//  Created by Mike Bell on 3/2/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Dice.h"
#import "GameConfig.h"


@implementation Dice

static BOOL isSeeded = NO;

+( NSUInteger ) roll: ( NSUInteger ) sides {
    if ( ! isSeeded ) {
        srand( time (NULL )) ;
        isSeeded = YES;
    }
    
    NSUInteger roll = 1;
    
    @try {
        roll = arc4random_uniform(sides) + 1;
    }
    @catch (NSException *e) {
        MLOG(@"DiceRollException: %@", e);
    }
    @finally {
        
    }
    
    return roll;
}

+( NSUInteger ) roll: (NSUInteger) sides nTimes: ( NSUInteger ) n {
    NSUInteger sum = 0;
    for ( int i = 0; i < n; i++ ) {
        sum += [ Dice roll: sides ];
    }
    return sum;
}

@end
