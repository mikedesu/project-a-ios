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
//  Prefix_t.m
//  project-a-ios
//
//  Created by Mike Bell on 4/4/13.

/*
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
 
    /*
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

    [Prefix_t setPrefixEffect: prefix];
    
    return prefix;
}

+(void) setPrefixEffect: (Prefix_t *) prefix {
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
}



+(Prefix_t *) firePrefix {
    Prefix_t *prefix = [Prefix_t effectWithName: @"Fire"];
    [Prefix_t setPrefixEffect: prefix];
    return prefix;
}

+(Prefix_t *) icePrefix {
    Prefix_t *prefix = [Prefix_t effectWithName: @"Ice"];
    [Prefix_t setPrefixEffect: prefix];
    return prefix;
}

+(Prefix_t *) waterPrefix {
    Prefix_t *prefix = [Prefix_t effectWithName: @"Water"];
    [Prefix_t setPrefixEffect: prefix];
    return prefix;
}

+(Prefix_t *) earthPrefix {
    Prefix_t *prefix = [Prefix_t effectWithName: @"Earth"];
    [Prefix_t setPrefixEffect: prefix];
    return prefix;
}

+(Prefix_t *) lightningPrefix {
    Prefix_t *prefix = [Prefix_t effectWithName: @"Lightning"];
    [Prefix_t setPrefixEffect: prefix];
    return prefix;
}

+(Prefix_t *) weakPrefix {
    Prefix_t *prefix = [Prefix_t effectWithName: @"Weak"];
    [Prefix_t setPrefixEffect: prefix];
    return prefix;
}

+(Prefix_t *) noPrefix {
    Prefix_t *prefix = [Prefix_t effectWithName:@""];
    prefix.effect = [Effect_t noPrefix];
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

*/
