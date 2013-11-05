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
//  MaterialTypes.h
//  project-a-ios
//
//  Created by Mike Bell on 3/28/13.

typedef enum {
    // pc/npc entities won't have a material type
    MATERIAL_T_NONE,
    
    // Armor Material Types
    MATERIAL_T_LEATHER,
    MATERIAL_T_CHAIN,
    MATERIAL_T_IRON_PLATE,
    MATERIAL_T_STEEL_PLATE,
    MATERIAL_T_HIDE,
    MATERIAL_T_DRAGON_BONE,
    MATERIAL_T_DRAGON_SCALE,
    MATERIAL_T_DRAGON_PLATE,
    MATERIAL_T_DIAMOND,
    
    
    // Weapon / Tool Material Types not listed above
    MATERIAL_T_WOOD,
    MATERIAL_T_IRON,
    MATERIAL_T_STEEL,
    MATERIAL_T_NICKEL,
    MATERIAL_T_TITANIUM,
    MATERIAL_T_MITHRIL,
    MATERIAL_T_ADAMANTIUM,
    MATERIAL_T_DRAGON_TOOTH,
    MATERIAL_T_DRAGON_EYE,
    MATERIAL_T_DRAGON_GUTS,
    MATERIAL_T_PURE_ENERGY,
    
} Material_t;