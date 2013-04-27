//  KarmaEngine.h
//  project-a-ios
//
//  Created by Mike Bell on 4/25/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

@interface KarmaEngine : NSObject {
    NSInteger karmaLevel;
    NSMutableArray *karma;
}

+(KarmaEngine *) sharedEngine;
-(id) init;
-(void) increaseKarma;
-(void) decreaseKarma;
-(void) zeroOutKarma;
-(NSInteger) getKarma;
-(void) addKarma: (NSInteger) k;
-(void) subKarma: (NSInteger) k;


@end
