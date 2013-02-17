//  Tile.m
//  project-a-ios
//
//  Created by Mike Bell on 2/10/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "GameConfig.h"

@implementation Tile

@synthesize tileType;
@synthesize isSelected;
@synthesize needsRedraw;
@synthesize texture;
@synthesize position;
@synthesize contents;

/*
 ====================
 init
 ====================
 */
-( id ) init {
    if ( ( self = [ super init ] ) ) {
        self->tileType = TILE_DEFAULT;
        self->isSelected = NO;
        self->needsRedraw = YES;
        //self->tileSprite = nil;
        self->texture = [[ CCMutableTexture2D alloc ] initWithSize:CGSizeMake(TILE_SIZE, TILE_SIZE) pixelFormat:kCCTexture2DPixelFormat_Default ];
        self->position = ccp( 0, 0 );
        self->contents = [ [ NSMutableArray alloc ] init ];
    }
    return self;
}


/*
 ====================
 initWithTileType: tileType
 ====================
 */
-( id ) initWithTileType: ( Tile_t ) tileType {
    if ( ( self = [ super init ] ) ) {
        self->tileType = tileType;
        self->isSelected = NO;
        self->needsRedraw = YES;
        //self->tileSprite = nil;
        self->texture = [[ CCMutableTexture2D alloc ] initWithSize:CGSizeMake(TILE_SIZE, TILE_SIZE) pixelFormat:kCCTexture2DPixelFormat_Default ];
        self->position = ccp( 0, 0 );
        self->contents = [ [ NSMutableArray alloc ] init ];
    }
    return self;
}


/*
 ====================
 newTileWithType: tileType withPosition: position
 ====================
 */
+( Tile * ) newTileWithType: ( Tile_t ) tileType withPosition: ( CGPoint ) position {
    //MLOG( @"newTileWithType: withPosition: (%f,%f)", position.x, position.y );
    Tile *tile = [[ Tile alloc ] initWithTileType: tileType ];
    tile->position.x = position.x;
    tile->position.y = position.y;
    //MLOG( @"end newTileWithType" );
    return tile;
}


/*
 ====================
 renderSpriteForTile: tile
 ====================
 */
+( void ) renderTextureForTile: ( Tile * ) tile {
    if ( tile->texture == nil ) {
        [ tile->texture setAliasTexParameters ];
        [ tile->texture fill: black ];
        
        Tile_t tileType = tile->tileType;
        
        // Select our primary working color based on tileType
        Color_t color =
        (tileType==TILE_VOID) ?  black :
        (tileType==TILE_FLOOR_GRASS) ? green :
        (tileType==TILE_FLOOR_STONE) ? gray :
        blue ;
        
        if (  tile->isSelected ) {
            Color_t tmpColor = newColor( color.r + 0xAA , color.g + 0xAA , color.b + 0x00, color.a );
            color = tmpColor;
        }
        
        // in most cases, we will fill our texture
        [ tile->texture fill: color ];
        [ tile->texture apply ];
        
        for (Entity *entity in tile->contents) {
            if ( [[entity name] isEqualToString: @"Hero" ] ) {
                // draw on the texture
                if ( tile->isSelected ) {
                    [ tile->texture fill: blue_alpha( 255 ) ];
                    [ tile->texture apply ];
                } else {
                    [ tile->texture fill: white ];
                    [ tile->texture apply ];
                }
            } else if ( [ [entity name] isEqualToString: @"Test1" ] ) {
                // Test1 will get rendered as colorFuzz
                for ( int i = 0; i < 16; i++ ) {
                    for ( int j = 0; j < 16; j++ ) {
                        [ tile->texture setPixelAt: ccp(i, j) rgba: random_color ];
                    }
                }
                [ tile->texture apply ];
            }
        }
    }
}
@end