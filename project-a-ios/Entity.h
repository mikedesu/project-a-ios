//  Entity.h
//  project-a-ios
//
//  Created by Mike Bell on 2/10/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "EntitySubtypeDefines.h"
#import "EquipDefines.h"
#import "Attack_t.h"
#import "Monsters.h"
#import "Threat_t.h"
#import "Spell.h"

@class CCMutableTexture2D;
@class Attack_t;
@class Status;

@interface Entity : NSObject {
    BOOL isPC;
    BOOL isAlive;
 
    CGPoint positionOnMap;
    
    CCMutableTexture2D *texture;
    
    NSMutableString *name;
    EntityTypes_t entityType;
    
    NSInteger level;
    
    Threat_t threatLevel;
    
    NSUInteger strength;
    NSUInteger dexterity;
    NSUInteger constitution;
    NSUInteger intelligence;
    NSUInteger wisdom;
    NSUInteger charisma;
    
    NSInteger fireDamage;
    NSInteger iceDamage;
    NSInteger earthDamage;
    NSInteger waterDamage;
    NSInteger lightningDamage;
    
    EntityAlignment_t alignment;
    
    NSUInteger xp;
    NSUInteger totalxp;
    NSUInteger nextLevelXP;
    
    NSInteger hitDie;
    
    NSInteger hp;
    NSInteger maxhp;
    
    NSInteger ac; //armor class
    
    NSUInteger money;
    
    EntityItemTypes_t itemType;
    Monster_t monsterType;
    
    PotionTypes_t potionType;
    
    
    NSInteger damageRollBase; // x, where 1dx = damage roll
    NSInteger damageBonus; // weapon roll bonus, if any
    
    NSInteger weight;
    NSInteger durability; // mainly for items
    NSInteger totalDurability; // mainly for items
    
    NSInteger totalKills;
    
    EntityPathFindingAlgorithm_t pathFindingAlgorithm;
    
    EntityItemPickupAlgorithm_t itemPickupAlgorithm;
    
    
    // PC/NPC inventory/equipment
    NSMutableArray *inventoryArray;
    Entity *equippedArmsLeft;
    Entity *equippedArmsRight;
    Entity *equippedArmorChest;
    
    NSMutableArray *equipment;
    
    NSMutableArray *pathTaken;
    
    NSInteger hunger;
    NSInteger maxHunger;
    
    
    // for potions/wands/healing items/etc 
    NSInteger healingRollBase;
    NSInteger healingBonus;
    
    // for food
    NSInteger foodBase;
 
    NSMutableArray *prefixes;
    NSMutableArray *effects;
    
    BOOL wasBumped;
    
    BOOL doorOpen;
    BOOL doorLocked;
    
    
    Status *status;
    
    // for scrolls and wands
    Spell_t spell;
    NSInteger charges;
    NSInteger maxCharges;
    
    
}

@property (atomic, assign) BOOL wasBumped;

@property (atomic, assign) BOOL isPC;
@property (atomic, assign) BOOL isAlive;
@property (atomic, assign) CGPoint positionOnMap;
@property (atomic) CCMutableTexture2D *texture;

@property (atomic) NSMutableString *name;

@property (atomic, assign) EntityTypes_t entityType;
@property (atomic, assign) Threat_t threatLevel;

@property (atomic, assign) NSInteger level;
@property (atomic, assign) NSInteger totalKills;

@property (atomic, assign) NSUInteger strength;
@property (atomic, assign) NSUInteger constitution;
@property (atomic, assign) NSUInteger dexterity;
@property (atomic, assign) NSUInteger intelligence;
@property (atomic, assign) NSUInteger wisdom;
@property (atomic, assign) NSUInteger charisma;


@property (atomic, assign) NSInteger fireDamage;
@property (atomic, assign) NSInteger iceDamage;
@property (atomic, assign) NSInteger earthDamage;
@property (atomic, assign) NSInteger waterDamage;
@property (atomic, assign) NSInteger lightningDamage;

@property (atomic, assign) NSInteger fireRes;
@property (atomic, assign) NSInteger iceRes;
@property (atomic, assign) NSInteger earthRes;
@property (atomic, assign) NSInteger waterRes;
@property (atomic, assign) NSInteger lightningRes;

@property (atomic, assign) EntityAlignment_t alignment;

@property (atomic, assign) NSUInteger xp;
@property (atomic, assign) NSUInteger totalxp;
@property (atomic, assign) NSUInteger nextLevelXP;

@property (atomic, assign) NSInteger hitDie;
@property (atomic, assign) NSInteger hp;
@property (atomic, assign) NSInteger maxhp;
@property (atomic, assign) NSInteger ac;

@property (atomic, assign) EntityItemTypes_t itemType;
@property (atomic, assign) PotionTypes_t potionType;
@property (atomic, assign) Monster_t monsterType;

@property (atomic, assign) NSInteger damageRollBase;
@property (atomic, assign) NSInteger damageBonus;
@property (atomic, assign) NSInteger weight;
@property (atomic, assign) NSInteger durability;
@property (atomic, assign) NSInteger totalDurability;

@property (atomic, assign) EntityPathFindingAlgorithm_t pathFindingAlgorithm;
@property (atomic, assign) EntityItemPickupAlgorithm_t itemPickupAlgorithm;

@property (atomic, assign) NSUInteger money;
@property (atomic, assign) NSInteger hunger;
@property (atomic, assign) NSInteger maxHunger;
@property (atomic) NSMutableArray *inventoryArray;

@property (atomic) Entity *equippedArmsLeft;
@property (atomic) Entity *equippedArmsRight;
@property (atomic) Entity *equippedArmorChest;


@property (nonatomic) NSMutableArray *equipment;
@property (atomic) NSMutableArray *pathTaken;

@property (atomic) NSMutableArray *prefixes;
@property (atomic) NSMutableArray *effects;

@property (atomic, assign) NSInteger foodBase;
@property (atomic, assign) NSInteger healingRollBase;
@property (atomic, assign) NSInteger healingBonus;

@property (atomic, assign) BOOL doorOpen;
@property (atomic, assign) BOOL doorLocked;

@property (nonatomic) Status *status;

@property (atomic, assign) Spell_t spell;
@property (atomic, assign) NSInteger charges;
@property (atomic, assign) NSInteger maxCharges;

-(Entity *) init;
-(Entity *) initWithLevel: (NSInteger) _level;
-(Entity *) initWithHitDie: (NSInteger) hd ;
-(Entity *) initWithLevel:(NSInteger)_level withHitDie: (NSInteger) hd ;
-(Entity *) initWithName: (NSString *) _name withPrefixes: (NSArray *) _prefixes withEntityType: (EntityTypes_t) _entityType withThreat: (Threat_t) _threat withMonsterType: (Monster_t) _monsterType withItemType: (EntityItemTypes_t) _itemType withLevel: (NSInteger) _level withHitDie: (NSInteger) _hd withPFA: (EntityPathFindingAlgorithm_t) _pfa withIPA: (EntityItemPickupAlgorithm_t) _ipa withDamageRollBase: (NSInteger) _damageRollBase withAttacks: (NSArray *) _attacks;

-(Entity *) initWithName: (NSString *) _name withPrefixes: (NSArray *) _prefixes withEntityType: (EntityTypes_t) _entityType withThreat: (Threat_t) _threat withMonsterType: (Monster_t) _monsterType withItemType: (EntityItemTypes_t) _itemType withLevel: (NSInteger) _level withHitDie: (NSInteger) _hd withStrength: (NSInteger) _str withDexterity: (NSInteger) _dex withConstitution: (NSInteger) _con withIntelligence: (NSInteger) _int withWisdom: (NSInteger) _wis withCharisma: (NSInteger) _cha withPFA: (EntityPathFindingAlgorithm_t) _pfa withIPA: (EntityItemPickupAlgorithm_t) _ipa withDamageRollBase: (NSInteger) _damageRollBase withAttacks: (NSArray *) _attacks;

-( NSInteger ) attackBonus;
-( NSInteger ) attackRoll;
-( NSInteger ) totalac;
-( NSInteger ) damageRoll;
//-( NSInteger ) damageBonus;

-( NSInteger ) movement;

-( void ) gainXP: (NSInteger) exp;
-( void ) handleLevelUp;
-( void ) handleLevelDown;

-( void ) step;
-( void ) getHungry;

-( NSInteger ) damageRollBase ;
-( void ) setDamageRollBase: (NSInteger) _damageRollBase;

-(void) equipItem: (Entity *) item forEquipSlot: (EquipSlot_t) equipSlot;

@end