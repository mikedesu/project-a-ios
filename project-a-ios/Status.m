//  Status.m
//  project-a-ios
//
//  Created by Mike Bell on 5/18/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "Status.h"

@implementation Status

@synthesize base;
@synthesize poisonType;
@synthesize poisonDamageBase;
@synthesize poisonDamageMod;

-(id) init {
    if ((self=[super init])) {
        base = STATUS_T_NORMAL;
    }
    return self;
}

+(Status *) normal {
    Status *status = [[Status alloc] init];
    return status;
}

+(Status *) simplePoison {
    Status *status = [[Status alloc] init];
    status.base = STATUS_T_POISON;
    status.poisonType = POISON_T_HP_DAMAGE;
    status.poisonDamageBase = 6;
    status.poisonDamageMod = 0;
    return status;
}

@end