//
//  Armor.h
//  project-a-ios
//
//  Created by Mike Bell on 3/6/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameConfig.h"

@class Entity;
@interface Armor : NSObject {
    
}
+(Entity *) leatherArmor: (NSInteger) bonus;

+(Entity *) plateArmor: (NSInteger) bonus;

+(Entity *) GodArmor: (NSInteger) bonus;

@end
