//  Monsters.m
//  project-a-ios
//
//  Created by Mike Bell on 3/11/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

//#import "Monsters.h"

//@implementation Monsters


/*
 
 monsterSpawnScript
 
 new Ghoul( levelRange, hitDie, damageRollBase, 
 

#define MONSTER(n,l,h,p,i,d) \
([[Entity alloc] \
initWithName:n \
withLevel:l \
withHitDie: h\
withPFA: p\
withIPA: i\
withDamageRollBase: d\
withAttacks: nil)

#define Monster(n,l,h,p,i,d) MONSTER(n,l,h,p,i,d)

#define Ghoul (Monster(@"Ghoul", 1, 6, ENTITYPATHFINDINGALGORITHM_T_SMART_RANDOM, ENTITYITEMPICKUPALGORITHM_T_NONE, 6))

 */


/*
+(Entity *) ghoul {
    NSInteger level             = 1;
    NSInteger hd                = 6;
    NSInteger damageRollBase    = 6;
    
    NSMutableString *name   = [ NSMutableString stringWithString:@"Ghoul" ];
    Entity *e = [[Entity alloc] initWithName: name withLevel:level withHitDie:hd withPFA:ENTITYPATHFINDINGALGORITHM_T_SMART_RANDOM withIPA:ENTITYITEMPICKUPALGORITHM_T_NONE  withDamageRollBase:damageRollBase withAttacks:nil];;
    
    return e;
}*/

//@end
