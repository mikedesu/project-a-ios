//  Spell.h
//  project-a-ios
//
//  Created by Mike Bell on 5/20/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.


typedef enum {
    SPELLNAME_T_NONE,
    
//    SPELLNAME_T_
    SPELLNAME_T_CURELIGHTWOUNDS,
    
    SPELLNAME_T_COUNT
} SpellName_t;

typedef enum {
    SPELL_T_NONE,
    SPELL_T_RESTORATION,
    SPELL_T_COUNT
} Spell_t;

typedef enum {
    SPELLCOMPONENT_T_NONE,
    SPELLCOMPONENT_T_RESTORATION,
    SPELLCOMPONENT_T_COUNT
} SpellComponent_t;

typedef CGSize SpellRange_t;

#define SpellRangeMake(x,y) CGSizeMake(x,y)

typedef NSInteger SpellDuration_t;

typedef enum {
    SPELLTARGET_T_NONE,
    SPELLTARGET_T_TOUCH,
    SPELLTARGET_T_COUNT
} SpellTarget_t;

typedef enum {
    SAVINGTHROW_T_NONE,
    
    SAVINGTHROW_T_YES_WILL_HALF,
    SAVINGTHROW_T_YES_WILL_NONE,
    
    SAVINGTHROW_T_COUNT
} SavingThrow_t;

typedef enum {
    SPELLRES_T_NONE,
    SPELLRES_T_YES_HARMLESS,
    SPELLRES_T_COUNT
} SpellRes_t;

@interface Spell : NSObject {
    
    SpellName_t         name;
    Spell_t             spellType;
    SpellComponent_t    components;
    SpellRange_t        range;
    SpellTarget_t       target;
    SpellDuration_t     duration;
    SavingThrow_t       savingThrow;
    SpellRes_t          spellRes;
}

@property (atomic, assign) SpellName_t         name;
@property (atomic, assign) Spell_t             spellType;
@property (atomic, assign) SpellComponent_t    components;
@property (atomic, assign) SpellRange_t        range;
@property (atomic, assign) SpellTarget_t       target;
@property (atomic, assign) SpellDuration_t     duration;
@property (atomic, assign) SavingThrow_t       savingThrow;
@property (atomic, assign) SpellRes_t          spellRes;

+(Spell *) nothing;
+(Spell *) cureLightWounds;

@end
