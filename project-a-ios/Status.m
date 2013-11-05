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
//  Status.m
//  project-a-ios
//
//  Created by Mike Bell on 5/18/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "Status.h"

@implementation Status

@synthesize base;
@synthesize poisonType;
@synthesize poisonDamageBase;
@synthesize poisonDamageMod;

-(id) init {
    if ((self=[super init])) {
        base = STATUS_T_NORMAL;
    }
    return self;
}

+(Status *) normal {
    Status *status = [[Status alloc] init];
    return status;
}

+(Status *) simplePoison {
    Status *status = [[Status alloc] init];
    status.base = STATUS_T_POISON;
    status.poisonType = POISON_T_HP_DAMAGE;
    status.poisonDamageBase = 6;
    status.poisonDamageMod = 0;
    return status;
}

@end