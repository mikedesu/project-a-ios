//  Maybe.m
//  project-a-ios
//
//  Created by Mike Bell on 4/19/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

#import "Maybe.h"
#import "MLog.h"

@implementation Maybe

-(id) initWithSomething:(NSObject *)_something {
    if ((self=[super init])) {
        if ( _something != nil ) {
            something = YES;
            just = _something;
        }
        else {
            something = NO;
        }
    }
    return self;
}



-(NSObject *) something {
    if ( [self hasSomething] ) {
        return just;
    }
    else {
        return [Maybe nothing];
    }
}


-(BOOL) hasSomething {
    return something;
}



+(Maybe *) something: (NSObject *) _something {
    Maybe *something = [[Maybe alloc] initWithSomething: _something];
    return something;
}



+(Maybe *) nothing {
    Maybe *nothing = [[Maybe alloc] initWithSomething: nil];
    return nothing;
}


@end
