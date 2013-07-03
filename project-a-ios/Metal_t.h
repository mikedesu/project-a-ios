//  Metal_t.h
//  project-a-ios
//
//  Created by Mike Bell on 7/1/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.




/*

 Explanation:
 
 In the game, we have various items that have a primary construction of metal:
 
 -swords
 -shields
 -various armor pieces
 -raw ore
 -etc
 
 The deeper we go into the dungeon, the construction of the floors will change.
 
 This all necessitates the existence of a Metal_t in the game.
 
 The Metal_t is simply a reference point into a table of values for those metals 
    as well as Alloys.
 
 There will likely also be a Textile_t for non-warrior armor pieces, 
    as well as a Wood_t
 
 
*/


typedef enum {
    
    METAL_T_NONE,
    
    //METAL_T_ALUMINUM,
    METAL_T_IRON,
    METAL_T_STEEL,
    //METAL_T_ELVISH_STEEL,
    //METAL_T_DWARVISH_STEEL,
    
    //METAL_T_SILVER,
    //METAL_T_GOLD,
    //METAL_T_IMPERIAL_GOLD,
    
    //METAL_T_REDSTONE,
    
    //METAL_T_CARBON_STEEL,
    //METAL_T_SULFUR,
    //METAL_T_TITANIUM,
    
    
    //METAL_T_URANIUM,
    //METAL_T_PLUTONIUM,
    
    //METAL_T_MYTHRIL,
    //METAL_T_ADAMANTIUM,
    //METAL_T_ORICHALCUM,
    //METAL_T_WARPSTONE,
    //METAL_T_TACHYON,
    
    METAL_T_COUNT
    
} Metal_t;
