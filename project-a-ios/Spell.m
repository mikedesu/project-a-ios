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
//  Spell.m
//  project-a-ios
//
//  Created by Mike Bell on 5/20/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
#import "Spell.h"

@implementation SpellTools

+(NSString *) stringForSpell: (Spell_t) spell {
    NSString *string = @"";
    if ( spell == SPELL_T_CURELIGHTWOUNDS ) {
        string = @"Cure Light Wounds";
    }
    else {
        string = @"Unknown Name";
    }
    return string;
}

@end


/*

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
*/