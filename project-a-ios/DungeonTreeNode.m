//  DungeonTreeNode.m
//  project-a-ios
//
//  Created by Mike Bell on 2/22/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "DungeonTreeNode.h"

@implementation DungeonTreeNode

@synthesize floor;
@synthesize nodeArray;

-( id ) init {
    if ( self = [ super init ] ) {
        floor = nil;
        nodeArray = nil;
    }
    return self;
}

-( void ) dealloc {
    // [ super dealloc ];
}

@end
