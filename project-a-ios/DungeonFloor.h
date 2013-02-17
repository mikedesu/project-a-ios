//  DungeonFloor.h
//  project-a-ios
//
//  Created by Mike Bell on 2/12/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

@interface DungeonFloor : NSObject {
    NSUInteger width, height;
    NSMutableArray *tileDataArray;
}

@property (atomic, assign) NSUInteger width;
@property (atomic, assign) NSUInteger height;
@property (atomic) NSMutableArray *tileDataArray;

+( DungeonFloor * ) newFloor;

@end