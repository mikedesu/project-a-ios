//  Monsters.h
//  project-a-ios
//
//  Created by Mike Bell on 3/11/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "GameConfig.h"


typedef enum {
    MONSTER_T_NONE,
    
    MONSTER_T_CAT,
    
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



/*
typedef enum {
    
    MONSTERPREFIX_T_NONE,
    MONSTERPREFIX_T_FIRE,
    MONSTERPREFIX_T_WATER,
    MONSTERPREFIX_T_ICE,
    MONSTERPREFIX_T_WIND,
    MONSTERPREFIX_T_LIGHTNING,
    MONSTERPREFIX_T_ACID,
    MONSTERPREFIX_T_ROCK,
    MONSTERPREFIX_T_HOLY,
    MONSTERPREFIX_T_UNHOLY,
    MONSTERPREFIX_T_UNDEAD,
    MONSTERPREFIX_T_DEMONIC,
    MONSTERPREFIX_T_GHOSTLY,
    MONSTERPREFIX_T_BERSERK,
    MONSTERPREFIX_T_CAUSTIC,
    MONSTERPREFIX_T_BIZARRO,
    MONSTERPREFIX_T_NUMTYPES
    
} MonsterPrefix_t;
*/


//typedef NSInteger MonsterPrefixGroup_t;

//#define MonsterPrefixGroup(a,b,c,d) (d + (c*MONSTERPREFIX_T_NUMTYPES) + (b*MONSTERPREFIX_T_NUMTYPES*2) + (a*MONSTERPREFIX_T_NUMTYPES*3))

#define MONSTER(n,r,t,m,l,h,p,i,d,a) \
([[Entity alloc] \
initWithName:n \
withPrefixes: r \
withEntityType: ENTITY_T_NPC \
withThreat: t \
withMonsterType: m \
withItemType: E_ITEM_T_NONE \
withLevel:l \
withHitDie: h \
withPFA: p \
withIPA: i \
withDamageRollBase: d \
withAttacks: a])

// Monster(
// name,
// prefix array,
// entity type,
// threat,
// monster type,
// item type,
// level,
// hit die,
// path finding algorithm,
// item pickup algorithm,
// damage roll base,
// attacks)
#define Monster(n,r,t,m,l,h,p,i,d,a) MONSTER(n,r,t,m,l,h,p,i,d,a)


#define Ghoul \
(Monster(\
@"Ghoul", \
[NSArray arrayWithObject: [Prefix_t randomPrefix]], \
THREAT_T_HOSTILE, \
MONSTER_T_GHOUL, \
1, \
6, \
ENTITYPATHFINDINGALGORITHM_T_SMART_RANDOM, \
ENTITYITEMPICKUPALGORITHM_T_NONE, \
6, \
nil))


#define Cat \
(Monster(\
[[NameEngine sharedEngine] getNextCatName], \
[NSArray arrayWithObject: [Prefix_t noPrefix]], \
THREAT_T_FRIENDLY, \
MONSTER_T_CAT, \
1, \
4, \
ENTITYPATHFINDINGALGORITHM_T_FRIENDLY_FOLLOW_PC_STRICT, \
ENTITYITEMPICKUPALGORITHM_T_NONE, \
4, \
nil))
