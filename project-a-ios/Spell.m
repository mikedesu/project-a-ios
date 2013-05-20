//  Spell.m
//  project-a-ios
//
//  Created by Mike Bell on 5/20/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "Spell.h"

@implementation Spell

@synthesize name;
@synthesize spellType;
@synthesize components;
@synthesize range;
@synthesize target;
@synthesize duration;
@synthesize savingThrow;
@synthesize spellRes;

-(id) init {
    if ((self=[super init])) {
        name        = SPELLNAME_T_NONE;
        spellType   = SPELL_T_NONE;
        components  = SPELLCOMPONENT_T_NONE;
        range       = SpellRangeMake(0, 0);
        target      = SPELLTARGET_T_NONE;
        duration    = 0;
        savingThrow = SAVINGTHROW_T_NONE;
        spellRes    = 0;
    }
    return self;
}


+(Spell *) nothing {
    Spell *newSpell = [[Spell alloc] init];
    return newSpell;
}

+(Spell *) cureLightWounds {
    Spell *newSpell = [Spell nothing];
    newSpell.name        = SPELLNAME_T_CURELIGHTWOUNDS;
    newSpell.spellType   = SPELL_T_RESTORATION;
    newSpell.components  = SPELLCOMPONENT_T_RESTORATION;
    newSpell.range       = SpellRangeMake(1, 0);
    newSpell.target      = SPELLTARGET_T_TOUCH;
    newSpell.duration    = 0;
    newSpell.savingThrow = SAVINGTHROW_T_YES_WILL_HALF;
    newSpell.spellRes    = SPELLRES_T_YES_HARMLESS;
    return newSpell;
}

@end
