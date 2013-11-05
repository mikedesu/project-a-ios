/*
The MIT License (MIT)

Copyright (c) 2013 Mike Bell

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
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
