//  Prefix_t.h
//  project-a-ios
//
//  Created by Mike Bell on 4/2/13.


/*
 Prefixes are how we can modify entity statistics.
 
 For instance, a Short Sword +1 deals 1d6+1 damage.
 A Fire Short Sword deals 1d6 dmg + 1d4 fire dmg.
 A Flaming Short Sword deals 1d6 dmg + 1d6 fire dmg.
 etc etc.
 A normal goblin might have 8 str.
 A Mighty goblin might have 8 + 2 str.
 Floating Boots might allow you to cross water untouched.
 
 etc...
 
 These values will exist in the entity spec as an NSArray.
 
 The check for these values will occur...lazily? IDK yet (4/2/2013)
 
 */

/*
typedef enum {
    PREFIX_T_NONE=0,
    PREFIX_T_NUMTYPES
} Prefix_t;


#define NUM_PREFIXES 3

#define PREFIX(n) (\
n==0 ? @""     : \
n==1 ? @"Fire" : \
n==2 ? @"Ice"  : \
@"Unknown")

#define RANDOM_PREFIX ( PREFIX( arc4random_uniform( NUM_PREFIXES )))
*/

#import "GameConfig.h"

@interface Prefix_t : NSObject {
    NSString *name;
    
    // we need a way to describe the effect that the
    // prefix has on the entity
    
    Effect_t *effect;
}

+(Prefix_t *) effectWithName: (NSString *) _name ;
+(Prefix_t *) randomPrefix;

@property (atomic) NSString *name;
@property (atomic) Effect_t *effect;

@end








