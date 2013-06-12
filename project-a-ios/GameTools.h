//  GameTools.h
//  project-a-ios
//
//  Created by Mike Bell on 6/12/13.
@class Tile;
@interface GameTools : NSObject;
+( NSInteger ) distanceFromTile: ( Tile * ) a toTile: ( Tile * ) b;
+( NSInteger ) distanceFromCGPoint: (CGPoint) a toCGPoint: (CGPoint) b;
@end