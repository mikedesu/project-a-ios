//  DungeonTreeNode.h
//  project-a-ios
//
//  Created by Mike Bell on 2/22/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "DungeonFloor.h"

@interface DungeonTreeNode : NSObject {
    DungeonFloor *floor;
    NSArray *nodeArray;
}

@property (atomic) DungeonFloor *floor;
@property (atomic) NSArray *nodeArray;

@end
