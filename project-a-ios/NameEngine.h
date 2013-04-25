//  NameEngine.h
//  project-a-ios
//
//  Created by Mike Bell on 4/25/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.

@interface NameEngine : NSObject {
    NSInteger catNameIndex;
    NSArray *catNameArray;
}

@property (atomic, assign) NSInteger catNameIndex;
@property (nonatomic) NSArray *catNameArray;

+(NameEngine *) sharedEngine;

-(NSString *) getNextCatName;
-(NSString *) getRandomCatName;

@end
