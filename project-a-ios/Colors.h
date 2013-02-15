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


#define CC3B_WHITE          ccc3( 0xff, 0xff, 0xff )
#define CC3B_BLACK          ccc3( 0x00, 0x00, 0x00 )

#define CC3B_RED            ccc3( 0xff, 0x00, 0x00 )
#define CC3B_GREEN          ccc3( 0x00, 0xff, 0x00 )
#define CC3B_BLUE           ccc3( 0x00, 0x00, 0xff )

#define CC3B_RANDOM         ccc3( random() % 255, random() % 255, random() % 255 )

#define white3              CC3B_WHITE
#define black3              CC3B_BLACK
#define red3                CC3B_RED
#define green3              CC3B_GREEN
#define blue3               CC3B_BLUE

#define random_color3        CC3B_RANDOM


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

#define random_color4 CC4B_RANDOM
#define random_color  random_color4

#define black_alpha(a) CC4B_BLACK_ALPHA(a)

#define gray_alpha(a) CC4B_GRAY_ALPHA(a)
#define darkgray_alpha(a) CC4B_DARKGRAY_ALPHA(a)

#define red_alpha(a)   CC4B_RED_ALPHA(a)
#define green_alpha(a) CC4B_GREEN_ALPHA(a)
#define blue_alpha(a)  CC4B_BLUE_ALPHA(a)
#define random_alpha(a) CC4B_RANDOM_ALPHA(a)

#define newColor(r,g,b,a) ccc4(r,g,b,a)
#define newColor3(r,g,b) ccc3(r,g,b)


typedef ccColor4B Color4_t;
typedef ccColor3B Color3_t;

typedef Color4_t Color_t;

#endif