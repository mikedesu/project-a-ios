//
//  HintGenerator.h
//  project-a-ios
//
//  Created by Mike Bell on 6/27/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameConfig.h"

@interface HintGenerator : NSObject;
+(HintGenerator *) sharedHintGenerator;
-(NSString *) getNextHint;
-(void) incrementIndex;
+( NSString * ) degradeString: (NSString *) str WithValue: (int) value ;
@end