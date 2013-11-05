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
//
//  Armor.h
//  project-a-ios
//
//  Created by Mike Bell on 3/6/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameConfig.h"
#import "Cloth_t.h"

/*
 // moved to EntitySubtypeDefines.h
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
*/

@class Entity;
@interface Armor : NSObject {}
+(Entity *) smallShield: (NSInteger) bonus;

+(Entity *) leatherArmor: (NSInteger) bonus;
+(Entity *) robe: (Cloth_t) cloth bonus: (NSInteger) bonus;

+(Entity *) blindfold;
+(Entity *) bootsOfAntiacid;

//+(Entity *) plateArmor: (NSInteger) bonus;

//+(Entity *) GodArmor: (NSInteger) bonus;
@end
