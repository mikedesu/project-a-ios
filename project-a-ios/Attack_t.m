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