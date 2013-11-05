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
