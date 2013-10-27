//  Monsters.h
//  project-a-ios
//
//  Created by Mike Bell on 3/11/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

typedef enum {
    MONSTER_T_NONE,
    
    MONSTER_T_CAT,
    
    MONSTER_T_DRAGON,
    
    MONSTER_T_DINOSAUR,
    
    MONSTER_T_ORC,
    MONSTER_T_OGRE,
    MONSTER_T_GOBLIN,
    MONSTER_T_TROLL,
    
    MONSTER_T_TREE,
    
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
    
    MONSTER_T_TOTORO,
    
    MONSTER_T_SQUID,
    MONSTER_T_GIANT_SQUID,
    MONSTER_T_KRAKEN,
    
    MONSTER_T_NUMTYPES
    
} Monster_t;



//typedef NSInteger MonsterPrefixGroup_t;

//#define MonsterPrefixGroup(a,b,c,d) (d + (c*MONSTERPREFIX_T_NUMTYPES) + (b*MONSTERPREFIX_T_NUMTYPES*2) + (a*MONSTERPREFIX_T_NUMTYPES*3))

#define MONSTER(n,r,t,m,l,h,str,dex,con,int,wis,cha,p,i,d,a) \
([[Entity alloc] \
initWithName:n \
withPrefixes: r \
withEntityType: ENTITY_T_NPC \
withThreat: t \
withMonsterType: m \
withItemType: E_ITEM_T_NONE \
withLevel:l \
withHitDie: h \
withStrength: str \
withDexterity: dex \
withConstitution: con \
withIntelligence: int \
withWisdom: wis \
withCharisma: cha \
withPFA: p \
withIPA: i \
withDamageRollBase: d \
withAttacks: a])

// Monster(
// name,
// prefix array/int,
// entity type,
// threat,
// monster type,
// level,
// hit die,
// str
// dex
// con
// int
// wis
// cha
// path finding algorithm,
// item pickup algorithm,
// damage roll base,
// attacks)

//#define N4M(m) ([NameEngine nameForMonsterType: m])

#define Monster(n,r,t,m,l,h,str,dex,con,int,wis,cha,p,i,d,a) \
MONSTER(n,r,t,m,l,h,str,dex,con,int,wis,cha,p,i,d,a)

//====================

#define Ghoul (Monster(@"Ghoul", PREFIX_T_NONE, \
THREAT_T_HOSTILE, MONSTER_T_GHOUL, 1, 6, 10, 10, 10, 10, 10, 10, \
ENTITYPATHFINDINGALGORITHM_T_SMART_RANDOM, ENTITYITEMPICKUPALGORITHM_T_NONE, 6, nil))

#define WeakGhoul (Monster(@"Ghoul", PREFIX_T_WEAK, \
THREAT_T_HOSTILE, MONSTER_T_GHOUL, 1, 6, 10, 10, 10, 10, 10, 10, \
ENTITYPATHFINDINGALGORITHM_T_SMART_RANDOM, ENTITYITEMPICKUPALGORITHM_T_NONE, 6, nil))

#define FireGhoul (Monster(@"Ghoul", PREFIX_T_FIRE, \
THREAT_T_HOSTILE, MONSTER_T_GHOUL, 1, 6, 10, 10, 10, 10, 10, 10, \
ENTITYPATHFINDINGALGORITHM_T_SMART_RANDOM, ENTITYITEMPICKUPALGORITHM_T_NONE, 6, nil))

#define IceGhoul (Monster(@"Ghoul", PREFIX_T_ICE, \
THREAT_T_HOSTILE, MONSTER_T_GHOUL, 1, 6, 10, 10, 10, 10, 10, 10, \
ENTITYPATHFINDINGALGORITHM_T_SMART_RANDOM, ENTITYITEMPICKUPALGORITHM_T_NONE, 6, nil))

#define WaterGhoul (Monster(@"Ghoul", PREFIX_T_WATER, \
THREAT_T_HOSTILE, MONSTER_T_GHOUL, 1, 6, 10, 10, 10, 10, 10, 10, \
ENTITYPATHFINDINGALGORITHM_T_SMART_RANDOM, ENTITYITEMPICKUPALGORITHM_T_NONE, 6, nil))

#define EarthGhoul (Monster(@"Ghoul", PREFIX_T_EARTH, \
THREAT_T_HOSTILE, MONSTER_T_GHOUL, 1, 6, 10, 10, 10, 10, 10, 10, \
ENTITYPATHFINDINGALGORITHM_T_SMART_RANDOM, ENTITYITEMPICKUPALGORITHM_T_NONE, 6, nil))

#define LightningGhoul (Monster(@"Ghoul", PREFIX_T_LIGHTNING, \
THREAT_T_HOSTILE, MONSTER_T_GHOUL, 1, 6, 10, 10, 10, 10, 10, 10, \
ENTITYPATHFINDINGALGORITHM_T_SMART_RANDOM, ENTITYITEMPICKUPALGORITHM_T_NONE, 6, nil))



#define Totoro (Monster(@"Totoro", PREFIX_T_NONE, \
THREAT_T_HOSTILE, MONSTER_T_TOTORO, 1, 6, 12, 8, 14, 10, 10, 10, \
ENTITYPATHFINDINGALGORITHM_T_SMART_RANDOM, ENTITYITEMPICKUPALGORITHM_T_NONE, 8, nil))

#define Tree (Monster(@"Tree", PREFIX_T_NONE, \
THREAT_T_HOSTILE, MONSTER_T_TREE, 1, 12, 12, 12, 12, 12, 12, 12, \
ENTITYPATHFINDINGALGORITHM_T_NONE, ENTITYITEMPICKUPALGORITHM_T_NONE, 8, nil))

#define Cat (Monster(@"Cat", PREFIX_T_NONE, \
THREAT_T_FRIENDLY, MONSTER_T_CAT, 1, 4, 12, 12, 12, 12, 12, 12, \
ENTITYPATHFINDINGALGORITHM_T_FRIENDLY_FOLLOW_PC_STRICT, ENTITYITEMPICKUPALGORITHM_T_NONE, 4, nil))
