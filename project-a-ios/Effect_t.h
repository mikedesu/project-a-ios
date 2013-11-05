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
//  Effect_t.h
//  project-a-ios
//
//  Created by Mike Bell on 4/4/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.



typedef enum {
    EFFECT_T_NONE,
    EFFECT_T_NUMTYPES
} Effect_t;


/*
@interface Effect_t : NSObject {
    NSInteger area;
    NSInteger distance;
    
    NSInteger damageNumRolls;
    NSInteger damageBaseRoll;
    NSInteger damageMod;
    
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
}

@property (atomic, assign) NSInteger area;
@property (atomic, assign) NSInteger distance;

@property (atomic, assign) NSInteger damageNumRolls;
@property (atomic, assign) NSInteger damageBaseRoll;
@property (atomic, assign) NSInteger damageMod;

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

-(id) init;

+(Effect_t *) attack: (NSInteger) numRolls withBaseRoll: (NSInteger) baseRoll withMod: (NSInteger) mod;

+(Effect_t *) noPrefix;

+(Effect_t *) firePrefix;
+(Effect_t *) icePrefix;
+(Effect_t *) waterPrefix;
+(Effect_t *) lightningPrefix;
+(Effect_t *) earthPrefix;


+(Effect_t *) weakPrefix;


@end
*/
