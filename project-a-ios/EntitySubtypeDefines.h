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
//  EntitySubtypeDefines.h
//  project-a-ios
//
//  Created by Mike Bell on 3/13/13.

typedef enum {
    ENTITY_T_VOID=0,
    ENTITY_T_PC,
    ENTITY_T_NPC,
    ENTITY_T_ITEM
} EntityTypes_t;


// Items
typedef enum {
    E_ITEM_T_NONE,
    
    // Weapon Types
    E_ITEM_T_WEAPON,
    E_ITEM_T_WEAPON_SWORD,
    E_ITEM_T_WEAPON_BLUDGEON,
    E_ITEM_T_WEAPON_SPEAR,
    E_ITEM_T_WEAPON_AXE,
    E_ITEM_T_WEAPON_STAFF,
    E_ITEM_T_WEAPON_WAND,
    E_ITEM_T_WEAPON_BOW,
    E_ITEM_T_WEAPON_CROSSBOW,
    E_ITEM_T_WEAPON_GUN,
    
    // Ammo Types
    E_ITEM_T_WEAPON_AMMO_BULLET,
    E_ITEM_T_WEAPON_AMMO_ARROW,
    E_ITEM_T_WEAPON_AMMO_BOLT,
    
    // Tool Types
    
    // Lockpick Items
    E_ITEM_T_LOCKPICK,
    
    // Fishing Items
    E_ITEM_T_FISHING_ROD,
    E_ITEM_T_FISHING_LURE,
    E_ITEM_T_FISHING_BAIT,
    
    E_ITEM_T_FISH,
    
    // Armor Types - for each slot
    E_ITEM_T_ARMOR,
    E_ITEM_T_HELMET,
    E_ITEM_T_NECKLACE,
    E_ITEM_T_SHOULDER,
    E_ITEM_T_CAPE,
    E_ITEM_T_ARMGUARD,
    E_ITEM_T_GLOVE,
    E_ITEM_T_RING,
    E_ITEM_T_BELT,
    E_ITEM_T_LEGGUARD,
    E_ITEM_T_SHOE,
    
    // Consumables
    E_ITEM_T_POTION,
    E_ITEM_T_FOOD,
 
    // Reading Items
    E_ITEM_T_BOOK,
    E_ITEM_T_SCROLL,
    E_ITEM_T_NOTE,
    
    // Wands
    E_ITEM_T_WAND,
    
    // Boulders
    E_ITEM_T_BASICBOULDER,
    
    // Doors
    E_ITEM_T_DOOR_SIMPLE,
    
    // Keys
    E_ITEM_T_KEY_SIMPLE,
    
    // Coins
    E_ITEM_T_COIN,
    
    // Torches
    E_ITEM_T_TORCH,
    
    
    E_ITEM_T_NUMTYPES
} EntityItemTypes_t;




typedef enum {
    E_RING_T_REGENERATION,
    E_RING_T_ANTIHUNGER
} Ring_t;


typedef enum {
    ITEMPREFIX_T_NONE,
    
    ITEMPREFIX_T_NUMTYPES
} ItemPrefix_t;


typedef NSInteger ItemPrefixGroup_t;

#define ItemPrefixGroup(a,b,c,d) (d + (c*ITEMPREFIX_T_NUMTYPES) + (b*ITEMPREFIX_T_NUMTYPES*2) + (a*ITEMPREFIX_T_NUMTYPES*3))




typedef enum {
    POTION_T_NONE,
    POTION_T_HEALING,
    POTION_T_POISON_ANTIDOTE,
    POTION_T_NUMTYPES
} PotionTypes_t;


typedef enum {
    ARMOR_T_NONE,
    ARMOR_T_HELMET,
    ARMOR_T_NECKLACE,
    ARMOR_T_SHOULDERGUARD,
    ARMOR_T_CAPE,
    ARMOR_T_ARMGUARD,
    ARMOR_T_GLOVE,
    ARMOR_T_RING,
    ARMOR_T_BELT,
    ARMOR_T_LEGGUARD,
    ARMOR_T_SHOE,
    ARMOR_T_SHIELD,
    ARMOR_T_MAIL,
    ARMOR_T_VEST,
    ARMOR_T_ROBE,
    
    ARMOR_T_NUMTYPES
} Armor_t;



/*
typedef enum {
    RACE_T_NONE,
    RACE_T_UNDEAD_GENERIC,
    RACE_T_UNDEAD_GHOUL,
} RaceTypes_t;
*/



typedef struct {
    NSUInteger strength;
    NSUInteger dexterity;
    NSUInteger constitution;
    NSUInteger intelligence;
    NSUInteger wisdom;
    NSUInteger charisma;
} EntityStats_t;


typedef enum {
    ENTITYPATHFINDINGALGORITHM_T_NONE=0,
    ENTITYPATHFINDINGALGORITHM_T_RANDOM,
    ENTITYPATHFINDINGALGORITHM_T_SMART_RANDOM,
    ENTITYPATHFINDINGALGORITHM_T_TEMP_RANDOM,
    ENTITYPATHFINDINGALGORITHM_T_SIMPLE,
    ENTITYPATHFINDINGALGORITHM_T_SIMPLE_LEFT,
    ENTITYPATHFINDINGALGORITHM_T_FRIENDLY_SMART_RANDOM,
    ENTITYPATHFINDINGALGORITHM_T_FRIENDLY_FOLLOW_PC_STRICT,
    ENTITYPATHFINDINGALGORITHM_T_FOLLOW_PC_STRICT,
    
} EntityPathFindingAlgorithm_t;


typedef enum {
    ENTITYITEMPICKUPALGORITHM_T_NONE=0,
    ENTITYITEMPICKUPALGORITHM_T_AUTO_SIMPLE
} EntityItemPickupAlgorithm_t;


typedef enum {
    ENTITYALIGNMENT_T_LAWFUL_GOOD = 0,
    ENTITYALIGNMENT_T_LAWFUL_NEUTRAL,
    ENTITYALIGNMENT_T_LAWFUL_EVIL,
    
    ENTITYALIGNMENT_T_NEUTRAL_GOOD,
    ENTITYALIGNMENT_T_NEUTRAL_NEUTRAL,
    ENTITYALIGNMENT_T_NEUTRAL_EVIL,
    
    ENTITYALIGNMENT_T_CHAOTIC_GOOD,
    ENTITYALIGNMENT_T_CHAOTIC_NEUTRAL,
    ENTITYALIGNMENT_T_CHAOTIC_EVIL,
    
} EntityAlignment_t;

