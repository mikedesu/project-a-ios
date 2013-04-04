//  Prefix_t.m
//  project-a-ios
//
//  Created by Mike Bell on 4/4/13.

#import "Prefix_t.h"

@implementation Prefix_t

@synthesize name;
@synthesize effect;

-(id) init {
    if ((self=[super init])) {
        
    }
    return self;
}

+(Prefix_t *) effectWithName: (NSString *) _name {
    Prefix_t *prefix = [[Prefix_t alloc] init];
    prefix.name = _name;
    return prefix;
}


+(Prefix_t *) randomPrefix {
    
    NSInteger numPrefixes = 3;
    NSInteger roll = [Dice roll: numPrefixes];
    NSString *randomName;
    
    randomName =
    roll == 0 ? @""     :
    roll == 1 ? @"Fire" :
    roll == 2 ? @"Ice"  :
    @"Unknown";
    
    Prefix_t *prefix = [Prefix_t effectWithName: randomName];
    return prefix;
}



@end