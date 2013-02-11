//  Colors.h
//  project-a-macosx
//
//  Created by Mike Bell on 1/31/13.

#ifndef project_a_macosx_Colors_h
#define project_a_macosx_Colors_h


//#define CC4B_  ccc4( 0x00, 0x00, 0x00, 0xFF )

#import "cocos2d.h"

#define CC4B_BLACK_ALPHA(a)  ccc4( 0x00, 0x00, 0x00, a )
#define CC4B_WHITE_ALPHA(a)  ccc4( 0xFF, 0xFF, 0xFF, a )
#define CC4B_GRAY_ALPHA(a)  ccc4( 0xCC, 0xCC, 0xCC, a )
#define CC4B_DARKGRAY_ALPHA(a) ccc4( 0x55, 0x55, 0x55, a )


#define CC4B_RED_ALPHA(a)    ccc4( 0xFF, 0x00, 0x00, a )
#define CC4B_GREEN_ALPHA(a)  ccc4( 0x00, 0xFF, 0x00, a )
#define CC4B_BLUE_ALPHA(a)   ccc4( 0x00, 0x00, 0xFF, a )


#define CC4B_RANDOM_ALPHA(a) ccc4( random() % 255, random() % 255, random() % 255, a )


#define CC4B_BLACK           CC4B_BLACK_ALPHA( 0xFF )
#define CC4B_WHITE           CC4B_WHITE_ALPHA( 0xFF )
#define CC4B_GRAY            CC4B_GRAY_ALPHA( 0xFF )
#define CC4B_DARKGRAY        CC4B_DARKGRAY_ALPHA( 0xFF )

#define CC4B_RED             CC4B_RED_ALPHA( 0xFF )
#define CC4B_GREEN           CC4B_GREEN_ALPHA( 0xFF )
#define CC4B_BLUE            CC4B_BLUE_ALPHA( 0xFF )
#define CC4B_RANDOM          CC4B_RANDOM_ALPHA( 0xFF )

/* ==================== */
/* ==================== */
/* ==================== */

#define black       CC4B_BLACK
#define white       CC4B_WHITE
#define gray        CC4B_GRAY
#define darkgray    CC4B_DARKGRAY

#define red    CC4B_RED
#define green  CC4B_GREEN
#define blue   CC4B_BLUE

#define random_color CC4B_RANDOM

#define black_alpha(a) CC4B_BLACK_ALPHA(a)
#define red_alpha(a)   CC4B_RED_ALPHA(a)
#define green_alpha(a) CC4B_GREEN_ALPHA(a)
#define blue_alpha(a)  CC4B_BLUE_ALPHA(a)
#define random_alpha(a) CC4B_RANDOM_ALPHA(a)

#define newColor(r,g,b,a) ccc4(r,g,b,a)

typedef ccColor4B Color_t;

#endif
