//  Effect_t.m
//  project-a-ios
//
//  Created by Mike Bell on 4/4/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "Effect_t.h"

@implementation Effect_t

@synthesize area;
@synthesize distance;

@synthesize damageBaseRoll;
@synthesize damageNumRolls;
@synthesize damageMod;

@synthesize strength;
@synthesize constitution;
@synthesize dexterity;
@synthesize intelligence;
@synthesize wisdom;
@synthesize charisma;

@synthesize fireDamage;
@synthesize iceDamage;
@synthesize waterDamage;
@synthesize lightningDamage;
@synthesize earthDamage;

-(id) init {
    if ((self=[super init])) {
        area            =
        distance        =
        damageNumRolls  =
        damageBaseRoll  =
        damageMod       =
        
        strength        =
        constitution    =
        dexterity       =
        intelligence    =
        wisdom          =
        charisma        =
        
        fireDamage      =
        iceDamage       =
        earthDamage     =
        waterDamage     =
        lightningDamage =
        
        0;
    }
    return self;
}

+(Effect_t *) attack: (NSInteger) numRolls withBaseRoll: (NSInteger) baseRoll withMod:                (NSInteger) mod {
    
    Effect_t *attackEffect      = [[Effect_t alloc] init];
    
    attackEffect.damageNumRolls = numRolls;
    attackEffect.damageBaseRoll = baseRoll;
    attackEffect.damageMod      = mod;
    
    return attackEffect;
}


+(Effect_t *) firePrefix {
    Effect_t *effect    = [[Effect_t alloc] init];
    effect.fireDamage   = 1;
    return effect;
}

+(Effect_t *) icePrefix {
    Effect_t *effect    = [[Effect_t alloc] init];
    effect.iceDamage    = 1;
    return effect;
}

+(Effect_t *) lightningPrefix {
    Effect_t *effect    = [[Effect_t alloc] init];
    effect.lightningDamage    = 1;
    return effect;
}

+(Effect_t *) waterPrefix {
    Effect_t *effect    = [[Effect_t alloc] init];
    effect.waterDamage    = 1;
    return effect;
}

+(Effect_t *) earthPrefix {
    Effect_t *effect    = [[Effect_t alloc] init];
    effect.earthDamage    = 1;
    return effect;
}

+(Effect_t *) weakPrefix {
    Effect_t *effect    = [[Effect_t alloc] init];
    effect.fireDamage    = -4;
    return effect;
}








@end
