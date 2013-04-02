//  Entity.m
//  project-a-ios
//
//  Created by Mike Bell on 2/10/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "Entity.h"
#import "GameConfig.h"

@implementation Entity

@synthesize isPC;
@synthesize isAlive;
@synthesize positionOnMap;
@synthesize texture;

@synthesize name;
@synthesize level;
@synthesize strength;
@synthesize dexterity;
@synthesize constitution;
@synthesize intelligence;
@synthesize wisdom;
@synthesize charisma;

@synthesize alignment;

@synthesize xp;
@synthesize totalxp;
@synthesize nextLevelXP;

@synthesize hitDie;
@synthesize hp;
@synthesize maxhp;
@synthesize ac;

@synthesize money;
@synthesize hunger;

@synthesize healingBonus;
@synthesize healingRollBase;

@synthesize foodBase;

@synthesize itemType;
@synthesize damageBonus;

@synthesize weight;
@synthesize durability;
@synthesize totalDurability;

@synthesize totalKills;

@synthesize inventoryArray;
@synthesize equippedArmsLeft;
@synthesize equippedArmsRight;
@synthesize equippedArmorChest;

@synthesize pathFindingAlgorithm;
@synthesize itemPickupAlgorithm;

@synthesize equipment;

@synthesize pathTaken;

@synthesize entityType;

@synthesize potionType;
@synthesize monsterType;

@synthesize monsterPrefixGroup;
@synthesize itemPrefixGroup;

/*
 ====================
 init
 
 initializes and returns the object
 ====================
 */
-( id ) init {
    if ( ( self = [super init] ) ) {
        //MLOG(@"init");
        isPC            = NO;
        isAlive         = YES;
        positionOnMap.x = 0;
        positionOnMap.y = 0;
        texture         = nil;
        
        name        = [ [ NSMutableString alloc ] init ];
        level       = 1;
        entityType  = ENTITY_T_VOID;
        potionType  = POTION_T_NONE;
        monsterType = MONSTER_T_NONE;
        itemType    = E_ITEM_T_NONE;

        monsterPrefixGroup  = MonsterPrefixGroup(0, 0, 0, 0);
        itemPrefixGroup     = ItemPrefixGroup(0, 0, 0, 0);
        
        NSInteger numEquipSlots = 19;
        //equipment = [NSMutableArray arrayWithCapacity: numEquipSlots];
        equipment = [NSMutableArray array];
        // add the 19 entity pointers
 
        MLOG(@"setting equipment...");
        for (int i=0; i<numEquipSlots; i++)
            //[equipment setObject:e atIndexedSubscript:i];
            [equipment addObject: [NSNull null] ];
        
        
        totalKills  = 0;
        
        itemType            = E_ITEM_T_NONE;
        damageRollBase      = 4;
        damageBonus         = 0;
        weight              = 0;
        durability          = 0;
        totalDurability     = 0;
        
        strength        = [Dice roll:6 nTimes:3];
        dexterity       = [Dice roll:6 nTimes:3];
        constitution    = [Dice roll:6 nTimes:3];
        intelligence    = [Dice roll:6 nTimes:3];
        wisdom          = [Dice roll:6 nTimes:3];
        charisma        = [Dice roll:6 nTimes:3];
        
        alignment       = ENTITYALIGNMENT_T_NEUTRAL_NEUTRAL;
        
        xp          = 0;
        totalxp     = 0;
        
#define DEFAULT_LVL1_NEXT_LEVEL_XP      10
        nextLevelXP = DEFAULT_LVL1_NEXT_LEVEL_XP;
        
        maxhp   = 0;
        hitDie  = 12;
        
        while ( maxhp == 0 ) {
            NSInteger conMod    = [ GameRenderer modifierForNumber: constitution ];
            maxhp               = [Dice roll:hitDie] + conMod;
            hp                  = maxhp;
            //MLOG(@"conMod = %d,  maxhp = %d", conMod, maxhp);
        }
        
        ac = 10; // the higher the better
        
        hunger  = 0;
        money   = 0;
        
        inventoryArray      = [ [ NSMutableArray alloc ] init ];
        equippedArmsLeft    = nil;
        equippedArmsRight   = nil;
        equippedArmorChest  = nil;
        
        pathTaken = [ [ NSMutableArray alloc ] init ];
        
        pathFindingAlgorithm    = ENTITYPATHFINDINGALGORITHM_T_RANDOM;
        itemPickupAlgorithm     = ENTITYITEMPICKUPALGORITHM_T_NONE;
        
    }
    return self;
}



-(Entity *) initWithHitDie: (NSInteger) hd {
    Entity *e   = [[Entity alloc] init];
    maxhp       = 0;
    hitDie      = hd;
    while ( maxhp == 0 ) {
        NSInteger conMod    = [ GameRenderer modifierForNumber: e.constitution ];
        maxhp               = [Dice roll:hitDie] + conMod;
        hp                  = maxhp;
    }
    return e;
}



-(Entity *) initWithLevel:(NSInteger)_level withHitDie: (NSInteger) hd {
    Entity *e = [[ Entity alloc ] initWithHitDie: hd];
    e.entityType = ENTITY_T_NPC;
    for ( int i = e.level; i < _level; i++ ) {
        [ e handleLevelUp ];
    }
    return e;
}


    
-(Entity *) initWithName: (NSString *) _name withEntityType: (EntityTypes_t) _entityType
  withMonsterPrefixGroup: (MonsterPrefixGroup_t) mPrefixGroup withMonsterType: (Monster_t) _monsterType withItemPrefixGroup: (ItemPrefixGroup_t) iPrefixGroup withItemType: (EntityItemTypes_t) _itemType withLevel: (NSInteger) _level withHitDie: (NSInteger) _hd withPFA: (EntityPathFindingAlgorithm_t) _pfa withIPA: (EntityItemPickupAlgorithm_t) _ipa withDamageRollBase: (NSInteger) _damageRollBase withAttacks: (NSArray *) _attacks {

    Entity *e               = [[Entity alloc] initWithHitDie:_hd];
    e.entityType            = _entityType;
    [e.name setString:      _name];
    e.pathFindingAlgorithm  = _pfa;
    e.itemPickupAlgorithm   = _ipa;
    e.damageRollBase        = _damageRollBase;
    
    e.monsterType           = _monsterType;
    e.itemType              = _itemType;
    
    e.monsterPrefixGroup    = mPrefixGroup;
    e.itemPrefixGroup       = iPrefixGroup;
    
    // currently not setting attack_t objects yet
    for (int i=e.level; i<_level; i++) {
        [e handleLevelUp];
    }
    return e;
}



-(Entity *) initWithLevel: (NSInteger) _level {
    Entity *e = [[ Entity alloc ] init];
    e.entityType = ENTITY_T_NPC;
    for ( int i = e.level; i < _level; i++ ) {
        [ e handleLevelUp ];
    }
    return e;
}


/*
 ====================
 attackBonus
 
 returns the entity's total attack bonus
 ====================
 */
-(NSInteger) attackBonus {
    NSInteger strengthBonus = [ GameRenderer modifierForNumber: strength ];
    
    // any items / equipped gear would be counted here
    NSInteger gearBonus = 0;
    
    
    if ( [[self.equipment objectAtIndex: EQUIPSLOT_T_LARMTOOL] isKindOfClass:NSClassFromString(@"Entity") ] ) {
        gearBonus += [(Entity *)[self.equipment objectAtIndex: EQUIPSLOT_T_LARMTOOL] damageBonus];
    }
    
    //if ( self.equippedArmsLeft != nil ) gearBonus += self.equippedArmsLeft.damageBonus;
    return strengthBonus + gearBonus;
}


/*
 ====================
 attackRoll
 
 returns the total attack roll for this entity
 ====================
 */
-( NSInteger ) attackRoll {
    //return rollDiceOnceWithModifier(20, self.attackBonus );
    return [Dice roll: 20] + self.attackBonus;
}


/*
 ====================
 damageRoll
 
 returns the total damage roll for this entity
 ====================
 */
-( NSInteger ) damageRoll {
    //return rollDiceOnce(6) + self.attackBonus;
    NSInteger roll = 0;
    if ( equippedArmsLeft == nil && equippedArmsRight == nil ) {
        roll = [Dice roll: damageRollBase] + self.attackBonus;
    }
    else {
        // weapon in left for now
        if ( equippedArmsLeft != nil )
            roll = [ Dice roll: equippedArmsLeft.damageRollBase ] + self.attackBonus;
    }
    return roll;
}


/*
 ====================
 damageRollBase
 
 returns the damage roll base for this entity
 ====================
 */
-( NSInteger ) damageRollBase {
    NSInteger base = damageRollBase;
    if ( equippedArmsLeft == nil && equippedArmsRight == nil ) {
        base = damageRollBase;
    }
    else {
        base = equippedArmsLeft.damageRollBase;
    }
    return base;
}

/*
 ====================
 setDamageRollBase: _damageRollBase
 
 sets the damage roll base
 ====================
 */
-(void) setDamageRollBase:(NSInteger) _damageRollBase {
    damageRollBase = _damageRollBase;
}





/*
 ====================
 ac
 
 returns the total ac 
 ====================
 */
-( NSInteger ) totalac {
    NSInteger dexterityBonus = [ GameRenderer modifierForNumber: dexterity ];
    NSInteger armorBonus = 0;
//    if ( equippedArmorChest != nil ) armorBonus = equippedArmorChest.ac;
    
    if ( [[self.equipment objectAtIndex: EQUIPSLOT_T_CHEST] isKindOfClass:NSClassFromString(@"Entity") ] ) {
        armorBonus = [(Entity *) [self.equipment objectAtIndex: EQUIPSLOT_T_CHEST] ac];
    }
    
    NSInteger total = ac + dexterityBonus + armorBonus;
    return total ;
}



/*
 ====================
 movement
 
 returns the total allowed move speed per turn
 ====================
 */
-( NSInteger ) movement {
    return 1;
}







/*
 ====================
 gainXP: exp
 
 adds exp to your xp and handles level ups
 ====================
 */
-( void ) gainXP: (NSInteger) exp {
    xp += exp;
    totalxp += exp;
    
    if ( xp >= nextLevelXP ) {
        [ self handleLevelUp ];
    }
}


/*
 ====================
 handleLevelUp
 
 manages level up events
 ====================
 */

-( void ) handleLevelUp {
    level++;
    xp = 0;
    nextLevelXP *= 2;
    
    // every 4 levels, up a stat at random (for now)
    if ( level % 4 == 0 ) {
        NSInteger r = [Dice roll:6];
        
        (r==1) ? strength++ :
        (r==2) ? dexterity++ :
        (r==3) ? constitution++ :
        (r==4) ? intelligence++ :
        (r==5) ? wisdom++ :
        (r==6) ? charisma++ :
        0;
    }
    
    // lets up our hp
    NSInteger conMod = [ GameRenderer modifierForNumber: constitution ];
    maxhp = maxhp + [Dice roll: hitDie ] + conMod;
    hp = maxhp;
}


/*
 ====================
 handleLevelDown
 
 handles the level down event (unfortunate!)
 ====================
 */
-( void ) handleLevelDown {
    level--;
    nextLevelXP /= 2;
}



/*
 ====================
 step
 
 steps the entity's logic one turn
 ====================
 */
-( void ) step {
    //MLOG( @"Entity step" );
}


/*
 ====================
 getHungry
 
 advances the entity's hunger
 ====================
 */
-( void ) getHungry {
    hunger++;
    
    // various levels of hunger...
    // lets start with
    // 50  = a little hungry
    // 100 = hungry
    // 150 = very hungry
    // 200 = starving
    // 250 = dead
    
    if ( hunger >= 250 ) {
        hp = 0;
        isAlive = NO;
        
    }
}



/*
 ====================
 equipItem: item forEquipSlot: equipSlot
 ====================
 */
-(void) equipItem: (Entity *) item forEquipSlot: (EquipSlot_t) equipSlot {
    MLOG(@"equipItem: %@ forEquipSlot: %@", item.name, EquipSlotToStr(equipSlot));
    [self.equipment setObject: item atIndexedSubscript: equipSlot];
}

@end
