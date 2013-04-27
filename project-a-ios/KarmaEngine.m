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
