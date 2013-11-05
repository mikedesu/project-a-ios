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
//  KarmaEngine.m
//  project-a-ios
//
//  Created by Mike Bell on 4/25/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "KarmaEngine.h"

@implementation KarmaEngine

static KarmaEngine *_sharedEngine;

+(KarmaEngine *) sharedEngine {
    static BOOL initialized = NO;
    if ( ! initialized ) {
        _sharedEngine = [[KarmaEngine alloc] init];
        initialized = YES;
    }
    return _sharedEngine;
}


-(id) init {
    if ((self=[super init])) {
        karmaLevel = 0;
        karma = [[NSMutableArray alloc] init];
    }
    return self;
}


-(void) increaseKarma {
    //karmaLevel++;
    //[karma addObject: [NSNumber numberWithInt:1]];
    [self addKarma:1];
}


-(void) decreaseKarma {
    //karmaLevel--;
    //[karma addObject: [NSNumber numberWithInt:-1]];
    [self subKarma:1];
}


-(void) zeroOutKarma {
    karmaLevel = 0;
    [karma removeAllObjects];
}


-(NSInteger) getKarma {
    return karmaLevel;
}


-(void) addKarma:(NSInteger)k {
    karmaLevel += k;
    [karma addObject: [NSNumber numberWithInt:k]];
}


-(void) subKarma:(NSInteger)k {
    karmaLevel -= k;
    [karma addObject: [NSNumber numberWithInt:-k]];
}

@end
