/*
Project A
A dungeon crawler by Mike Bell

This file is part of Project A.
 
Project A is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Project A is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied
warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Foobar.  If not, see <http://www.gnu.org/licenses/>.
*/
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
        if ( _something != nil &&
             ! [_something isEqual: [NSNull null]]
            ) {
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
