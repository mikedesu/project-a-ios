//  Dungeon.m
//  project-a-ios
//
//  Created by Mike Bell on 2/12/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "Dungeon.h"

@implementation Dungeon

@synthesize floorArray;

-( id ) init {
    if ( ( self = [ super init ] ) ) {
        floorArray = [[ NSMutableArray alloc ] init ] ;
    }
    return self;
}

@end
