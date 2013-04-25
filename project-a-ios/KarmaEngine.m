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
    }
    return self;
}


-(void) increaseKarma {
    karmaLevel++;
}


-(void) decreaseKarma {
    karmaLevel--;
}


-(void) zeroOutKarma {
    karmaLevel = 0;
}


-(NSInteger) getKarma {
    return karmaLevel;
}

@end
