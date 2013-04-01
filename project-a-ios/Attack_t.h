//  Attack_t.h
//  project-a-ios
//
//  Created by Mike Bell on 4/1/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "GameConfig.h"
#import "AttackStatus_t.h"
#import "AttackElement_t.h"

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

//+(Attack_t *) attackWithString: (NSString *) _attackString;

+(Attack_t *) attackWithNumRolls: (NSInteger) _numRolls withDamageBase: (NSInteger) _damageBase withMod: (NSInteger) _mod withStatus: (AttackStatus_t) _status withElement: (AttackElement_t) _element;

@end
