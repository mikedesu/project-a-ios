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
