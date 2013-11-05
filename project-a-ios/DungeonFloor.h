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
//  DungeonFloor.h
//  project-a-ios
//
//  Created by Mike Bell on 2/12/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

typedef enum
{
    DF_ALGORITHM_T_SMALLROOM=0,
    DF_ALGORITHM_T_LARGEROOM,
    DF_ALGORITHM_T_ALGORITHM0,
    DF_ALGORITHM_T_ALGORITHM0_FINALFLOOR,
} DungeonFloorAlgorithm_t;

@interface DungeonFloor : NSObject {
    NSUInteger width;
    NSUInteger height;
    NSUInteger border;
    NSMutableArray *tileDataArray;
    NSUInteger floorNumber;
    NSMutableArray *entityArray;
}

@property (atomic, assign) NSUInteger width;
@property (atomic, assign) NSUInteger height;
@property (atomic, assign) NSUInteger border;
@property (nonatomic) NSMutableArray *tileDataArray;
@property (atomic, assign) NSUInteger floorNumber;
@property (nonatomic) NSMutableArray *entityArray;

+( DungeonFloor * ) newFloor;
+( DungeonFloor * ) newFloorWidth: (NSUInteger) w andHeight: (NSUInteger) h;
+( DungeonFloor * ) newFloorWidth: (NSUInteger) w andHeight: (NSUInteger) h andFloorNumber: (NSUInteger) floorNumber;

@end