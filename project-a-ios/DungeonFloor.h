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
} DungeonFloorAlgorithm_t;

@interface DungeonFloor : NSObject {
    NSUInteger width;
    NSUInteger height;
    NSUInteger border;
    NSMutableArray *tileDataArray;
    NSUInteger floorNumber;
}

@property (atomic, assign) NSUInteger width;
@property (atomic, assign) NSUInteger height;
@property (atomic, assign) NSUInteger border;
@property (atomic) NSMutableArray *tileDataArray;
@property (atomic, assign) NSUInteger floorNumber;

+( DungeonFloor * ) newFloor;
+( DungeonFloor * ) newFloorWidth: (NSUInteger) w andHeight: (NSUInteger) h;
+( DungeonFloor * ) newFloorWidth: (NSUInteger) w andHeight: (NSUInteger) h andFloorNumber: (NSUInteger) floorNumber;

@end