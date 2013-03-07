//
//  Weapons.h
//  project-a-ios
//
//  Created by Mike Bell on 3/6/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameConfig.h"

@interface Weapons : NSObject {
    
}
+(Entity *) shortSword: (NSInteger) bonus;
+(Entity *) longSword: (NSInteger) bonus;
+(Entity *) bastardSword: (NSInteger) bonus;

+(Entity *) Asura;

@end
