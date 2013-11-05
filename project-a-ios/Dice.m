/*
The MIT License (MIT)

Copyright (c) 2013 Mike Bell

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
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
