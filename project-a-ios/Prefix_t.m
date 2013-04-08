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
        name = @"";
        effect = nil;
    }
    return self;
}

+(Prefix_t *) effectWithName: (NSString *) _name {
    Prefix_t *prefix = [[Prefix_t alloc] init];
    prefix.name     = _name;
    prefix.effect   = [[Effect_t alloc] init];
    return prefix;
}


+(Prefix_t *) randomPrefix {
    NSString *randomName = [Prefix_t randomPrefixName];
    
    Prefix_t *prefix = [Prefix_t effectWithName: randomName];
    
    if ([prefix.name isEqualToString:@""]) {
        // effect is none
    } else if ([prefix.name isEqualToString:@"Fire"]) {
        prefix.effect = [Effect_t firePrefix];
    } else if ([prefix.name isEqualToString:@"Ice"]) {
        prefix.effect = [Effect_t icePrefix];
    }
    else if ([prefix.name isEqualToString:@"Water"]) {
        prefix.effect = [Effect_t waterPrefix];
    }
    else if ([prefix.name isEqualToString:@"Lightning"]) {
        prefix.effect = [Effect_t lightningPrefix];
    }
    else if ([prefix.name isEqualToString:@"Earth"]) {
        prefix.effect = [Effect_t earthPrefix];
    }
    
    else if ([prefix.name isEqualToString:@"Weak"]) {
        prefix.effect = [Effect_t weakPrefix];
    }
    
    
    
    return prefix;
}

+(NSString *) randomPrefixName {
    NSArray *names = [NSArray arrayWithObjects:
                      @"",
                      @"Fire",
                      @"Ice",
                      @"Water",
                      @"Lightning",
                      @"Earth",
                      @"Weak",
                      nil];
    
    NSInteger roll = [Dice roll: names.count];
    return [names objectAtIndex:roll];
}



@end