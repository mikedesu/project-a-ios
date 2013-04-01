//  Monsters.h
//  project-a-ios
//
//  Created by Mike Bell on 3/11/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "GameConfig.h"

#define MONSTER(n,l,h,p,i,d) \
([[Entity alloc] \
initWithName:n \
withType: ENTITY_T_NPC \
withLevel:l \
withHitDie: h \
withPFA: p \
withIPA: i \
withDamageRollBase: d \
withAttacks: nil])

#define Monster(n,l,h,p,i,d) MONSTER(n,l,h,p,i,d)

#define Ghoul \
(Monster(\
@"Ghoul", \
1, \
6, \
ENTITYPATHFINDINGALGORITHM_T_SMART_RANDOM, \
ENTITYITEMPICKUPALGORITHM_T_NONE, \
6))
