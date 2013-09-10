//  Items.m
//  project-a-ios
//
//  Created by Mike Bell on 3/6/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "Items.h"

@implementation Items

+( Entity * ) randomItem {
    Entity *e = nil;
    
    NSUInteger numItems = 14;
    NSUInteger roll = [Dice roll:numItems];
    
    if (roll==1)        e = [Items potionOfLightHealing:1];
    else if (roll==2)   e = [Items greenBlob];
    else if (roll==3)   e = [Items woodenFishingRod];
    else if (roll==4)   e = [Items catfish];
    
    else if (roll==5)   e = [Items catfish];
    //else if (roll==5)   e = [Items simpleDoor];
    
    else if (roll==6)   e = [Items simpleKey];
    else if (roll==7)   e = [Items poisonAntidote];
    else if (roll==8)   e = [Items scrollOfCureLightWounds];
    else if (roll==9)   e = [Items wandOfCureLightWounds];
    else if (roll==10)  e = [Items coin:[Dice roll:100]];
    else if (roll==11)  e = [Items ringOfRegeneration];
    else if (roll==12)  e = [Items ringOfAntihunger];
    else if (roll==13)  e = [Items note:[[HintGenerator sharedHintGenerator] getNextHint] ];
    else if (roll==14)  e = [Items basicBoulder];
    
    //e = [Items wandOfCureLightWounds];
    //e = [Items ringOfRegeneration];
    
    NSAssert( e!=nil, @"Random Item: roll failed to set entity" );
    
    return e;
}


+( Entity * ) bookOfAllKnowing {
    Entity *e = [[Entity alloc] init];
    e.entityType = ENTITY_T_ITEM;
    e.isPC = NO;
    [e.name setString: @"Book of All-Knowing" ];
    e.itemType = E_ITEM_T_BOOK;
    return e;
}


+( Entity * ) potionOfLightHealing: (NSInteger) bonus {
    Entity *e = [[Entity alloc] init];
    
    e.entityType    = ENTITY_T_ITEM;
    e.itemType      = E_ITEM_T_POTION;
    e.potionType    = POTION_T_HEALING;
    e.isPC          = NO;
    [e.name setString:@"Potion of Light Healing"];
    
    // now to define the effects of the potion when used
    e.healingRollBase   = 6;
    e.healingBonus      = bonus;
    e.weight            = 0.1;
    e.durability        = 1;
    e.totalDurability   = 1;
    return e;
}


+(Entity *) poisonAntidote {
    Entity *e = [[Entity alloc] init];
    e.entityType    = ENTITY_T_ITEM;
    e.itemType      = E_ITEM_T_POTION;
    e.potionType    = POTION_T_POISON_ANTIDOTE;
    e.isPC          = NO;
    [e.name setString:@"Potion of Antidote"];
    
    // now to define the effects of the potion when used
    e.healingRollBase   = 0;
    e.healingBonus      = 0;
    e.weight            = 0.1;
    e.durability        = 1;
    e.totalDurability   = 1;
    return e;
}


+(Entity *) greenBlob {
    Entity *e = [[Entity alloc] init];
    e.entityType    = ENTITY_T_ITEM;
    e.itemType      = E_ITEM_T_FOOD;
    [e.name setString:@"Green Blob"];
    e.isPC                  = NO;
    
    // now to define the effects of the food when used
    e.foodBase          = 10;
    e.weight            = 1;
    e.durability        = 100;
    e.totalDurability   = 100;
    return e;
}


+(Entity *) catfish {
    Entity *e = [[Entity alloc] init];
    e.entityType    = ENTITY_T_ITEM;
    e.itemType      = E_ITEM_T_FISH;
    [e.name setString:@"Catfish"];
    e.isPC                  = NO;
    
    // now to define the effects of the food when used
    e.foodBase          = 25;
    e.weight            = 1;
    e.durability        = 100;
    e.totalDurability   = 100;
    return e;
}


+(Entity *) woodenFishingRod {
    Entity *e = [[Entity alloc] init];
    e.entityType    = ENTITY_T_ITEM;
    e.itemType      = E_ITEM_T_FISHING_ROD;
    [e.name setString:@"Wooden Fishing Rod"];
    e.isPC                  = NO;
    e.weight            = 1;
    e.durability        = 100;
    e.totalDurability   = 100;
    return e;
}


+(Entity *) torch: (NSInteger) light {
    Entity *e = [[Entity alloc] init];
    e.entityType    = ENTITY_T_ITEM;
    e.itemType      = E_ITEM_T_TORCH;
    [e.name setString:@"Torch"];
    e.isPC                  = NO;
    e.weight            = 1;
    e.durability        = 512;
    e.totalDurability   = 512;
    e.lightLevel        = light;
    return e;    
}




+(Entity *) basicBoulder {
    Entity *e = [[Entity alloc] init];
    e.entityType    = ENTITY_T_ITEM;
    e.itemType      = E_ITEM_T_BASICBOULDER;
    [e.name setString:@"Basic Boulder"];
    e.isPC                  = NO;
    e.weight            = 1;
    e.durability        = 100;
    e.totalDurability   = 100;
    return e;
}


+(Entity *) simpleDoor {
    Entity *e = [[Entity alloc] init];
    e.entityType    = ENTITY_T_ITEM;
    e.itemType      = E_ITEM_T_DOOR_SIMPLE;
    [e.name setString:@"Door, Simple"];
    e.doorOpen              = NO;
    e.doorLocked            = YES;
    e.isPC                  = NO;
    e.weight            = 1;
    e.durability        = 100;
    e.totalDurability   = 100;
    return e;
}


+(Entity *) simpleKey {
    Entity *e = [[Entity alloc] init];
    e.entityType    = ENTITY_T_ITEM;
    e.itemType      = E_ITEM_T_KEY_SIMPLE;
    [e.name setString:@"Key, Simple"];
    e.isPC                  = NO;
    e.weight            = 1;
    e.durability        = 100;
    e.totalDurability   = 100;
    return e;
}


+(Entity *) scrollOfCureLightWounds {
    Entity *e = [[Entity alloc] init];
    e.entityType    = ENTITY_T_ITEM;
    e.itemType      = E_ITEM_T_SCROLL;
    e.isPC                  = NO;
    e.weight            = 1;
    e.durability        = 100;
    e.totalDurability   = 100;
    e.spell             = SPELL_T_CURELIGHTWOUNDS;
    [e.name setString:  [NSString stringWithFormat:@"Scroll of %@",
                         [SpellTools stringForSpell:e.spell]
                         ]];
    return e;
}


+(Entity *) wandOfCureLightWounds {
    Entity *e = [[Entity alloc] init];
    e.entityType    = ENTITY_T_ITEM;
    e.itemType      = E_ITEM_T_WAND;
    e.isPC                  = NO;
    e.weight            = 1;
    e.durability        = 100;
    e.totalDurability   = 100;
    
    e.spell             = SPELL_T_CURELIGHTWOUNDS;
    e.charges           = 5;
    e.maxCharges        = 5;
    
    [e.name setString:  [NSString stringWithFormat:@"Wand of %@",
                         [SpellTools stringForSpell:e.spell]
                         ]];
    return e;
}



+(Entity *) ringOfRegeneration {
    Entity *e = [[Entity alloc] init];
    e.entityType    = ENTITY_T_ITEM;
    e.itemType      = E_ITEM_T_RING;
    e.ringType      = E_RING_T_REGENERATION;
    e.isPC                  = NO;
    e.weight            = 1;
    e.durability        = 100;
    e.totalDurability   = 100;
    [e.name setString:  [NSString stringWithFormat:@"Ring of Regeneration"]];
    return e;
}


+(Entity *) ringOfAntihunger {
    Entity *e = [[Entity alloc] init];
    e.entityType    = ENTITY_T_ITEM;
    e.itemType      = E_ITEM_T_RING;
    e.ringType      = E_RING_T_ANTIHUNGER;
    e.isPC                  = NO;
    e.weight            = 1;
    e.durability        = 100;
    e.totalDurability   = 100;
    [e.name setString:  [NSString stringWithFormat:@"Ring of Antihunger"]];
    return e;
}


+(Entity *) coin: (NSInteger) coinValue {
    Entity *e = [[Entity alloc] init];
    e.entityType    = ENTITY_T_ITEM;
    e.itemType      = E_ITEM_T_COIN;
    e.isPC                  = NO;
    e.weight            = 1;
    e.durability        = 100;
    e.totalDurability   = 100;
    
    // coin has to have some value > 0
    if ( coinValue <= 1 ) {
        e.money = 1;
        [e.name setString:  [NSString stringWithFormat:@"A coin"]];
    }
    else {
        e.money = coinValue;
        [e.name setString:  [NSString stringWithFormat:@"%d coins", coinValue]];
    }
    return e;
}


+(Entity *) note:(NSString *)text {
    Entity *e = [[Entity alloc] init];
    e.entityType    = ENTITY_T_ITEM;
    e.itemType      = E_ITEM_T_NOTE;
    e.isPC                  = NO;
    e.weight            = 1;
    e.durability        = 100;
    e.totalDurability   = 100;
    [e.name setString:  [NSString stringWithFormat:@"A note"]];
    e.notetext = text;
    return e;
}

@end