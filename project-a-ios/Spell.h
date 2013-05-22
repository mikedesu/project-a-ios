//  Spell.h
//  project-a-ios
//
//  Created by Mike Bell on 5/20/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.


typedef enum {
    SPELL_T_NONE,
    
    SPELL_T_CURELIGHTWOUNDS,
    
    SPELL_T_COUNT
} Spell_t;



@interface SpellTools : NSObject {
    
}

+(NSString *) stringForSpell: (Spell_t) spell;

@end



