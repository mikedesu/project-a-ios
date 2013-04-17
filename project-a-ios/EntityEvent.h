//  EntityEvent.h
//  project-a-ios
//
//  Created by Mike Bell on 4/17/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "GameConfig.h"

@interface EntityEvent : NSObject {
    Entity *entity;
    Effect_t *effect;
}

@property (atomic) Entity *entity;
@property (atomic) Effect_t *effect;

-(id) initWithEntity: (Entity *) _entity withEffect: (Effect_t *) _effect;

@end
