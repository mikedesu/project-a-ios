/*
Project A
A dungeon crawler by Mike Bell

This file is part of Project A.
 
Project A is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Project A is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied
warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Foobar.  If not, see <http://www.gnu.org/licenses/>.
*/
//
//  Dice.m
//  project-a-ios
//
//  Created by Mike Bell on 3/2/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Dice.h"
#import "GameConfig.h"



#include <stdint.h>
uint32_t xor128(void) {
    static uint32_t x = 123456789;
    static uint32_t y = 362436069;
    static uint32_t z = 521288629;
    static uint32_t w = 88675123;
    uint32_t t;
    
    t = x ^ (x << 11);
    x = y; y = z; z = w;
    return w = w ^ (w >> 19) ^ (t ^ (t >> 8));
}

void xor_srand( uint32_t seed ) {
    for ( int i = 0; i < seed; i++ ) {
        uint32_t tmp = xor128();
        tmp = tmp; // make sure compiler doesn't optimize-away the tmp
    }
}


@implementation Dice


static BOOL isSeeded = NO;


+( NSUInteger ) roll: ( NSUInteger ) sides {
    if ( ! isSeeded ) {
        srand( time (NULL )) ;
        //xor_srand( 301 );
        isSeeded = YES;
    }
    
    NSUInteger roll = 1;
    
    @try {
        roll = arc4random_uniform(sides) + 1;
        //roll = (NSUInteger) xor128() % sides + 1;  // simple 'repeatable' random
        //MLOG(@"roll=%d", roll);
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
