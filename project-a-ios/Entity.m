//  Entity.m
//  project-a-ios
//
//  Created by Mike Bell on 2/10/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "Entity.h"

@implementation Entity

-( id ) init {
    if ( ( self = [super init] ) ) {
        name = [ [ NSMutableString alloc ] init ];
        positionOnMap.x = 0;
        positionOnMap.y = 0;
    }
    return self;
}

@end
