//  EntityEvent.m
//  project-a-ios
//
//  Created by Mike Bell on 4/17/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "EntityEvent.h"

@implementation EntityEvent

@synthesize entity;
@synthesize effect;

-(id) initWithEntity: (Entity *) _entity withEffect: (Effect_t *) _effect {
    if ((self=[super init])) {
        entity = _entity;
        effect = _effect;
    }
    return self;
}

-(NSString *) string {
    return @"";
}

@end