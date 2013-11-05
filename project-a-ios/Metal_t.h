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
