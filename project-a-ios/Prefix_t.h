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
 
(10/27/13) changed to a simple enum for now

 */

typedef enum {
    PREFIX_T_NONE=0,
    PREFIX_T_FIRE,
    PREFIX_T_WATER,
    PREFIX_T_EARTH,
    PREFIX_T_ICE,
    PREFIX_T_LIGHTNING,
    PREFIX_T_WEAK,

    PREFIX_T_NUMTYPES
} Prefix_t;



/*
#define NUM_PREFIXES 3

#define PREFIX(n) (\
n==0 ? @""     : \
n==1 ? @"Fire" : \
n==2 ? @"Ice"  : \
@"Unknown")

#define RANDOM_PREFIX ( PREFIX( arc4random_uniform( NUM_PREFIXES )))

#import "GameConfig.h"

@interface Prefix_t : NSObject {
    NSString *name;
    
    // we need a way to describe the effect that the
    // prefix has on the entity
    
    Effect_t *effect;
}

+(Prefix_t *) effectWithName: (NSString *) _name ;
+(Prefix_t *) randomPrefix;

+(void) setPrefixEffect: (Prefix_t *) prefix;
+(Prefix_t *) noPrefix;

@property (atomic) NSString *name;
@property (atomic) Effect_t *effect;

@end

*/







