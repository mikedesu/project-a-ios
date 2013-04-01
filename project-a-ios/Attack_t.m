//  Attack_t.m
//  project-a-ios
//
//  Created by Mike Bell on 4/1/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "Attack_t.h"

@implementation Attack_t

@synthesize numRolls;
@synthesize damageBase;
@synthesize modifier;
@synthesize status;
@synthesize element;


-(id) init {
    if ((self=[super init])) {
        numRolls    = 0;
        damageBase  = 0;
        modifier    = 0;
        status      = ATTACKSTATUS_T_NONE;
        element     = ATTACKELEMENT_T_NONE;
    }
    return self;
}


+(Attack_t *) attackWithNumRolls: (NSInteger) _numRolls withDamageBase: (NSInteger) _damageBase withMod: (NSInteger) _mod withStatus: (AttackStatus_t) _status withElement: (AttackElement_t) _element {
    Attack_t *attack = [[Attack_t alloc] init];
    attack.numRolls     = _numRolls;
    attack.damageBase   = _damageBase;
    attack.modifier     = _mod;
    attack.status       = _status;
    attack.element      = _element;
    return attack;
}

@end