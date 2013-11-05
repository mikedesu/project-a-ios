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
//  PlayerMenu.m
//  project-a-ios
//
//  Created by Mike Bell on 2/11/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "GameConfig.h"
#import "PlayerMenu.h"

@implementation PlayerMenu

@synthesize label;

/*
 ====================
 initWithColor: color width: w height: h
 
 initializes a new PlayerMenu with a set color, width, and height
 ====================
 */
-( id ) initWithColor:(ccColor4B)color width:(GLfloat)w height:(GLfloat)h {
    if ( ( self = [ super initWithColor: color width: w height: h ] ) ) {
        
        Color3_t fontColor = white3;
 
        int fontsize = 14;

        CCLabelTTF *menuItemLabelStatus         = [[CCLabelTTF alloc] initWithString:   @"Status"       fontName:@"Courier New" fontSize:fontsize ];
        menuItemLabelStatus.color               = fontColor;
        
        CCLabelTTF *menuItemLabelEquip          = [[CCLabelTTF alloc] initWithString:   @"Equip"       fontName:@"Courier New" fontSize:fontsize ];
        menuItemLabelEquip.color                = fontColor;
        
        CCLabelTTF *menuItemLabelCast           = [[CCLabelTTF alloc] initWithString:   @"Cast"       fontName:@"Courier New" fontSize:fontsize ];
        menuItemLabelCast.color                 = fontColor;
        
        
        
        CCLabelTTF *menuItemLabelInventory      = [[CCLabelTTF alloc] initWithString:   @"Inventory"    fontName:@"Courier New" fontSize:fontsize ];
        menuItemLabelInventory.color            = fontColor;
        
        CCLabelTTF *menuItemLabelPickup         = [[CCLabelTTF alloc] initWithString:   @"Pickup"       fontName:@"Courier New" fontSize:fontsize ];
        menuItemLabelPickup.color               = fontColor;
        
        
        CCLabelTTF *menuItemLabelDrop           = [[CCLabelTTF alloc] initWithString:   @"Drop"         fontName:@"Courier New" fontSize:fontsize ];
        menuItemLabelDrop.color                 = fontColor;
        
        CCLabelTTF *menuItemLabelAutostep       = [[CCLabelTTF alloc] initWithString:   @"Autostep"     fontName:@"Courier New" fontSize:fontsize ];
        menuItemLabelAutostep.color             = fontColor;
        
        CCLabelTTF *menuItemLabelMonitor        = [[CCLabelTTF alloc] initWithString:   @"Monitor"      fontName:@"Courier New" fontSize:fontsize ];
        menuItemLabelMonitor.color              = fontColor;
        
        CCLabelTTF *menuItemLabelHelp           = [[CCLabelTTF alloc] initWithString:   @"Help"         fontName:@"Courier New" fontSize:fontsize ];
        menuItemLabelHelp.color                 = fontColor;
        
        CCLabelTTF *menuItemLabelEntityInfo     = [[CCLabelTTF alloc] initWithString:   @"EntityInfo"   fontName:@"Courier New" fontSize:fontsize ];
        menuItemLabelEntityInfo.color           = fontColor;
        
        CCLabelTTF *menuItemLabelReset          = [[CCLabelTTF alloc] initWithString:   @"Reset"        fontName:@"Courier New" fontSize:fontsize ];
        menuItemLabelReset.color                = fontColor;
        
        NSInteger baseHeight = h;
        NSInteger hPad = 4;
        
        NSInteger pad = 10;
        
        CCMenuItem *menuItemStatus      = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabelStatus target:self selector:@selector(menuItemStatusPressed) ];
        int x = menuItemStatus.contentSize.width/2 + pad; // x wont change
        int y = baseHeight - menuItemStatus.contentSize.height/2;
        
        menuItemStatus.position         = ccp( x, y);
        
        CCMenuItem *menuItemEquip       = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabelEquip target:self selector:@selector(menuItemEquipPressed) ];
        y -= menuItemStatus.contentSize.height + hPad;
        menuItemEquip.position = ccp(x,y);
        
        CCMenuItem *menuItemCast       = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabelCast target:self selector:@selector(menuItemCastPressed) ];
        y -= menuItemStatus.contentSize.height + hPad;
        menuItemCast.position          = ccp(x,y);
        
        CCMenuItem *menuItemInventory   = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabelInventory target:self selector:@selector(menuItemInventoryPressed) ];
        y -= menuItemStatus.contentSize.height + hPad;
        menuItemInventory.position      = ccp( x,y);
        
        CCMenuItem *menuItemPickup      = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabelPickup target:self selector:@selector(menuItemPickupPressed) ];
        y -= menuItemStatus.contentSize.height + hPad;
        menuItemPickup.position         = ccp(x,y);
        
        /*
         ####################
             NEXT ROW!!!
         ####################
         */
        
        // drop the baseHeight so that calculations for height remain simple
        //baseHeight = baseHeight - menuItemStatus.contentSize.height - hPad;
        pad = 20;
        
        CCMenuItem *menuItemDrop        = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabelDrop target:self selector:@selector(menuItemDropPressed) ];
        y -= menuItemStatus.contentSize.height + hPad;
        menuItemDrop.position           = ccp(x,y);
        
        CCMenuItem *menuItemMonitor     = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabelMonitor target:self selector:@selector(menuItemMonitorPressed) ];
                y -= menuItemStatus.contentSize.height + hPad;
        menuItemMonitor.position        = ccp(x,y);
        
        CCMenuItem *menuItemHelp        = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabelHelp target:self selector:@selector(menuItemHelpPressed) ];
        y -= menuItemStatus.contentSize.height + hPad;
        menuItemHelp.position           = ccp(x,y);
        
        CCMenuItem *menuItemEntityInfo  = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabelEntityInfo target:self selector:@selector(menuItemEntityInfoPressed) ];
        y -= menuItemStatus.contentSize.height + hPad;
        menuItemEntityInfo.position     = ccp( x,y);
        
        CCMenuItem *menuItemReset       = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabelReset target:self selector:@selector(menuItemResetPressed) ];
        y -= menuItemStatus.contentSize.height + hPad;
        menuItemReset.position          = ccp( x,y);
        
        CCMenu *menu = [[ CCMenu alloc ] initWithArray: [NSArray arrayWithObjects:
                                                         //menuItemMinimize,
                                                         menuItemStatus,
                                                         menuItemEquip,
                                                         menuItemCast,
                                                         menuItemInventory,
                                                         menuItemPickup,
                                                         //menuItemStep,
                                                         //menuItemAutostep,
                                                         menuItemDrop,
                                                         menuItemMonitor,
                                                         menuItemHelp,
                                                         menuItemEntityInfo,
                                                         menuItemReset,
                                                         nil] ];
        menu.position = ccp( 0, 0 );
        [ self addChild: menu ];
    }
    return self;
}


-( id ) initWithColor:(ccColor4B)color width:(GLfloat)w height:(GLfloat)h isMinimized:(BOOL)isMin {
    if ( ( self = [ super initWithColor: color width: w height: h ] ) ) {
        
        if ( isMin ) {
            // close button
            CCLabelTTF *menuItemLabelClose = [[CCLabelTTF alloc] initWithString: @"Maximize" fontName:@"Courier New" fontSize:16 ];
            menuItemLabelClose.color = white3;
 
            CCMenuItem *menuItemClose = [ [ CCMenuItemLabel alloc ] initWithLabel:menuItemLabelClose  target:self selector:@selector(menuItemClosePressed)];
            menuItemClose.position = ccp( 0 + menuItemClose.contentSize.width/2, h - 24 );
            
            CCMenu *menu = [[ CCMenu alloc ] initWithArray: [NSArray arrayWithObjects:
                                                             menuItemClose,
                                                             nil] ];
            menu.position = ccp( 0, 0 );
            [ self addChild: menu ];
            
        } else {
            self = [ self initWithColor:color width:w height:h];
        }
    }
    return self;
}



#define MENUITEMCLOSE_NOTIFICATIONNAME @"PlayerMenuCloseNotification"
-( void ) menuItemClosePressed {
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: MENUITEMCLOSE_NOTIFICATIONNAME  object:self];
}

-( void ) menuItemStatusPressed {
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: @"PlayerMenuStatusNotification"  object:self];
}

-( void ) menuItemEquipPressed {
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: @"PlayerMenuEquipNotification"  object:self];
}

-( void ) menuItemInventoryPressed {
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: @"PlayerMenuInventoryNotification"  object:self];
}

-( void ) menuItemPickupPressed {
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: @"PlayerMenuPickupNotification"  object:self];
}


-( void ) menuItemDropPressed {
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: @"PlayerMenuDropNotification"  object:self];
}


-( void ) menuItemStepPressed {
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: @"PlayerMenuStepNotification"  object:self];
}



-( void ) menuItemAutostepPressed {
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: @"PlayerMenuAutostepNotification"  object:self];
}

-( void ) menuItemMonitorPressed {
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: @"PlayerMenuMonitorNotification"  object:self];
}


-( void ) menuItemTogglePositionPressed {
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: @"PlayerMenuTogglePositionNotification"  object:self];
}

-( void ) menuItemToggleHUDsPressed {
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: @"PlayerMenuToggleHUDsNotification"  object:self];
}

-( void ) menuItemResetPressed {
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: @"PlayerMenuResetNotification"  object:self];
}

-( void ) menuItemHelpPressed {
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: @"PlayerMenuHelpNotification"  object:self];
}

-(void) menuItemEntityInfoPressed {
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: @"PlayerMenuEntityInfoNotification"  object:self];
}

-(void) menuItemCastPressed {
    [ [ NSNotificationCenter defaultCenter ] postNotificationName: @"PlayerMenuCastNotification"  object:self];
}

@end
