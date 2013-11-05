/*
Project A
A dungeon crawler by Mike Bell

This file is part of Project A.
 
Project A is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Project A is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied
warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Foobar.  If not, see <http://www.gnu.org/licenses/>.
*/
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
