//  GameTools.m
//  project-a-ios
//
//  Created by Mike Bell on 6/12/13.

#import "GameTools.h"
#import "GameConfig.h"

@implementation GameTools

/*
 ====================
 distanceFromTile: toTile:
 
 returns distance from a tile to another
 ====================
 */
+( NSInteger ) distanceFromTile: ( Tile * ) a toTile: ( Tile * ) b {
    return [GameTools distanceFromCGPoint:a.position toCGPoint:b.position];
}

/*
 ====================
 distanceFromCGPoint: toCGPoint:
 
 returns distance from a cgpoint to another
 ====================
 */
+( NSInteger ) distanceFromCGPoint: (CGPoint) a toCGPoint: (CGPoint) b {
    return ccpDistance(a, b);
}

@end
