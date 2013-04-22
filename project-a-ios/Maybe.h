//  Maybe.h
//  project-a-ios
//
//  Created by Mike Bell on 4/19/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

@interface Maybe : NSObject {
    BOOL something;
    NSObject *just;
}

-(id) initWithSomething: (NSObject *) _something;
-(NSObject *) something;
-(BOOL) hasSomething;
+(Maybe *) something: (NSObject *) _something;
+(Maybe *) nothing;

@end
