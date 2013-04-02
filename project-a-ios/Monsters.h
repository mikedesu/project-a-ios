//  Monsters.h
//  project-a-ios
//
//  Created by Mike Bell on 3/11/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "GameConfig.h"


typedef enum {
    MONSTER_T_NONE,
    
    MONSTER_T_DRAGON,
    
    MONSTER_T_DINOSAUR,
    
    MONSTER_T_ORC,
    MONSTER_T_OGRE,
    MONSTER_T_GOBLIN,
    MONSTER_T_TROLL,
    
    MONSTER_T_SLIME,
    MONSTER_T_FUNGUS,
    MONSTER_T_GELANTONOUS_CUBE,
    
    MONSTER_T_ELEMENTAL,
    
    MONSTER_T_DEMIGOD,
    MONSTER_T_GOD,
    
    MONSTER_T_MIMIC,
    
    MONSTER_T_DOMESTIC_ANIMAL,
    MONSTER_T_WILD_ANIMAL,
    
    MONSTER_T_SPIRIT,
    MONSTER_T_DEMON,
    MONSTER_T_ANGEL,
    
    MONSTER_T_GOLEM,
    
    MONSTER_T_GHOUL,
    
    MONSTER_T_SQUID,
    MONSTER_T_GIANT_SQUID,
    MONSTER_T_KRAKEN,
    
    MONSTER_T_NUMTYPES
    
} Monster_t;




typedef enum {
    
    MONSTERPREFIX_T_FIRE,
    MONSTERPREFIX_T_WATER,
    MONSTERPREFIX_T_ICE,
    MONSTERPREFIX_T_WIND,
    MONSTERPREFIX_T_LIGHTNING,
    
    MONSTERPREFIX_T_ACID,
    MONSTERPREFIX_T_POISON,
    MONSTERPREFIX_T_DISEASED,
    
    MONSTERPREFIX_T_DEMONIC,
    MONSTERPREFIX_T_ANGELIC,
    
    MONSTERPREFIX_T_STONE,
    
    MONSTERPREFIX_T_UNDEAD,
    MONSTERPREFIX_T_GHOSTLY,
    
    MONSTERPREFIX_T_DRUNK,
    MONSTERPREFIX_T_INTOXICATED,
    
    MONSTERPREFIX_T_SLEEPY,
    
    MONSTERPREFIX_T_FUNGAL,
    
    MONSTERPREFIX_T_BERSERK,
    
    MONSTERPREFIX_T_NUMTYPES
    
} MonsterPrefix_t;



#define MONSTER(n,m,l,h,p,i,d,a) \
([[Entity alloc] \
initWithName:n \
withEntityType: ENTITY_T_NPC \
withMonsterType: m \
withItemType: E_ITEM_T_NONE \
withLevel:l \
withHitDie: h \
withPFA: p \
withIPA: i \
withDamageRollBase: d \
withAttacks: a])

#define Monster(n,m,l,h,p,i,d,a) MONSTER(n,m,l,h,p,i,d,a)

#define Ghoul \
(Monster(\
@"Ghoul", \
MONSTER_T_GHOUL, \
1, \
6, \
ENTITYPATHFINDINGALGORITHM_T_SMART_RANDOM, \
ENTITYITEMPICKUPALGORITHM_T_NONE, \
6, \
nil))