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
//  NameEngine.m
//  project-a-ios
//
//  Created by Mike Bell on 4/25/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "NameEngine.h"
#import "Dice.h"

@implementation NameEngine

@synthesize catNameIndex;
@synthesize catNameArray;

static NameEngine *_sharedEngine;

+(NameEngine *) sharedEngine {
    static BOOL initialized = NO;
    if ( ! initialized ) {
        initialized = YES;
        _sharedEngine = [[ NameEngine alloc ] init ];
    }
    return _sharedEngine;
}


-(id) init {
    if ((self=[super init])) {
        catNameIndex = 0;
        catNameArray = [[NSArray alloc] initWithObjects:
                     @"Max",
                     @"Chloe",
                     @"Bella",
                     @"Oliver",
                     @"Asparagus",
                     @"Tiger",
                     @"Smokey",
                     @"Shadow",
                     @"Lucy",
                     @"Angel",
                        nil];
    }
    return self;
}


-(NSString *) getNextCatName {
    NSString *returnName = nil;
    
    if ( catNameIndex < [catNameArray count] && catNameIndex >= 0 ) {
        returnName = [catNameArray objectAtIndex: catNameIndex];
        catNameIndex++;
        if ( catNameIndex >= [catNameArray count] ) {
            catNameIndex = 0;
        }
    }
    
    //return returnName;
    return [NSString stringWithFormat: @"%@ the Cat", returnName];
}


-(NSString *) getRandomCatName {
    NSInteger index = [Dice roll:[catNameArray count]];
    //return [catNameArray objectAtIndex:index];
    return [NSString stringWithFormat: @"%@ the Cat", [catNameArray objectAtIndex:index]];
}




+(NSString *) nameForMonsterType: (Monster_t) monsterType {
    NSString *names[MONSTER_T_NUMTYPES];
    names[MONSTER_T_NONE]   = @"";
    names[MONSTER_T_CAT]    = @"Cat";
    names[MONSTER_T_GHOUL]  = @"Ghoul";
    names[MONSTER_T_TREE]   = @"Tree";
    names[MONSTER_T_TOTORO] = @"Totoro";
    return names[monsterType];
}




+(NSString *) randomNameForPrefix: (Prefix_t) prefix {
    NSString *fire[1] = { @"Fire" };
    NSString *ice[1] = { @"Ice" };
    NSString *water[1] = { @"Water" };
    NSString *earth[1] = { @"Earth" };
    NSString *lightning[1] = { @"Lightning" };
    NSString *weak[1] = { @"Weak" };

    NSString *retVal = @"";

    switch ( prefix ) {
        case PREFIX_T_NONE:
            retVal = @"";
            break;
        case PREFIX_T_FIRE:
            retVal = fire[0];
            break;
        case PREFIX_T_ICE:
            retVal = ice[0];
            break;
        case PREFIX_T_WATER:
            retVal = water[0];
            break;
        case PREFIX_T_EARTH:
            retVal = earth[0];
            break;
        case PREFIX_T_LIGHTNING:
            retVal = lightning[0];
            break;
        case PREFIX_T_WEAK:
            retVal = weak[0];
            break;
        default: break;
    }

    return retVal;
}


@end
