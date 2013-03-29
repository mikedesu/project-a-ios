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
    
    // Tool Types
    E_ITEM_T_FISHING_ROD,
    E_ITEM_T_FISHING_LURE,
    E_ITEM_T_FISHING_BAIT,
    
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
    
    E_ITEM_T_POTION,
    
    E_ITEM_T_FOOD,
    
    E_ITEM_T_BOOK,
} EntityItemTypes_t;





typedef enum {
    POTION_T_NONE,
    POTION_T_HEALING,
} PotionTypes_t;





typedef enum {
    RACE_T_NONE,
    RACE_T_UNDEAD_GENERIC,
    RACE_T_UNDEAD_GHOUL,
} RaceTypes_t;




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

