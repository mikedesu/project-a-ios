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