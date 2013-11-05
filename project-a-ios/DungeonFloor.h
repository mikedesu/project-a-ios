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