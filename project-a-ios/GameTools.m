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
    /*
     NSInteger ax = (NSInteger)a.position.x;
    NSInteger bx = (NSInteger)b.position.x;
    NSInteger ay = (NSInteger)a.position.y;
    NSInteger by = (NSInteger)b.position.y;
     */
    //return sqrt( (bx-ax)*(bx-ax) + (by-ay)*(by-ay) );
    return [GameTools distanceFromCGPoint:a.position toCGPoint:b.position];
}

/*
 ====================
 distanceFromCGPoint: toCGPoint:
 
 returns distance from a cgpoint to another
 ====================
 */
+( NSInteger ) distanceFromCGPoint: (CGPoint) a toCGPoint: (CGPoint) b {
    //MLOG( @"distanceFromTile: a toTile: b" );
    /*
    NSInteger ax = (NSInteger)a.x;
    NSInteger bx = (NSInteger)b.x;
    NSInteger ay = (NSInteger)a.y;
    NSInteger by = (NSInteger)b.y;
     */
    //return sqrt( (bx-ax)*(bx-ax) + (by-ay)*(by-ay) );
    return ccpDistance(a, b);
}

@end
