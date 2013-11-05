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
//  Attack_t.h
//  project-a-ios
//
//  Created by Mike Bell on 4/1/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "GameConfig.h"
#import "AttackStatus_t.h"
#import "AttackElement_t.h"


#define ATTACK(n,d,m,s,e) \
[Attack attackWithNumRolls: n \
withDamageBase: d \
withMod: m \
withStatus: s \
withElement: e]

#define Attack(n,d,m,s,e) ATTACK(n,d,m,s,e)

#define BasicAttack(d) (Attack(1,d,0,ATTACKSTATUS_T_NONE,ATTACKELEMENT_T_NONE))



@interface Attack_t : NSObject {
    NSInteger numRolls;
    NSInteger damageBase;
    NSInteger modifier;
    
    AttackStatus_t status;
    AttackElement_t element;
}

@property (atomic, assign) NSInteger numRolls;
@property (atomic, assign) NSInteger damageBase;
@property (atomic, assign) NSInteger modifier;

@property (atomic, assign) AttackStatus_t status;
@property (atomic, assign) AttackElement_t element;


-(id) init;

+(Attack_t *) attackWithNumRolls: (NSInteger) _numRolls withDamageBase: (NSInteger) _damageBase withMod: (NSInteger) _mod withStatus: (AttackStatus_t) _status withElement: (AttackElement_t) _element;

@end
