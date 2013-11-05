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
//  Status.h
//  project-a-ios
//
//  Created by Mike Bell on 5/18/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.


typedef enum {
    STATUS_T_NORMAL,
    STATUS_T_POISON,
    
    STATUS_T_COUNT
} Status_t;




typedef enum {
    POISON_T_HP_DAMAGE,
    POISON_T_COUNT
} Poison_t;



@interface Status : NSObject {
    
    Status_t base;
    
    // Poison variables
    Poison_t poisonType;
    NSInteger poisonDamageBase;
    NSInteger poisonDamageMod;
    
}

@property (atomic, assign) Status_t base;
@property (atomic, assign) Poison_t poisonType;
@property (atomic, assign) NSInteger poisonDamageBase;
@property (atomic, assign) NSInteger poisonDamageMod;




+(Status *) normal;
+(Status *) simplePoison;

@end
