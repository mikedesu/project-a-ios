//  HintGenerator.m
//  project-a-ios
//
//  Created by Mike Bell on 6/27/13.

#import "HintGenerator.h"
#import "Dice.h"

@implementation HintGenerator

static HintGenerator *hintGenerator;
static BOOL isInitialized = NO;
static int currentIndex = 0;
static int maxIndex = 5;

static NSString *hints[ 9 ];

+( HintGenerator * ) sharedHintGenerator {
    if ( ! isInitialized ) {
        hintGenerator = [[HintGenerator alloc] init];
        //hints[0] = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
        hints[0] = @"This is a test hint";
        hints[1] = @"Green tiles are grass. Monsters spawn on grass.";
        hints[2] = @"Blue tiles are water. If you're hungry, try fishing!";
        hints[3] = @"Red tiles are lava and deal damage if you walk on them.";
        hints[4] = @"Dark green tiles are acid tiles and will deal lethal damage if you walk on them.";
        hints[5] = @"You're looking for the Book of All-Knowledge";
        
        hints[6] = @"There are different material types for Cloth, Metal, Stone, and Wood.";
        
        hints[7] = @"This is a hint designed to be a false hint. Beware of false hints!";
        hints[8] = @"Be very careful in proceeding through the dungeon...";
        
        
        isInitialized = YES;
    }
    return hintGenerator;
}


-( NSString * ) getNextHint {
    int roll = [Dice roll:50];
    MLOG(@"Degrading at %d...", roll);
    NSString *hintToReturn = [HintGenerator degradeString: hints[currentIndex] WithValue: roll];
    [ self incrementIndex ];
    return hintToReturn;
}


+( NSString * ) degradeString: (NSString *) str WithValue: (int) value {
    // randomly blank-out certain parts of text
    MLOG(@"...degrading %@...", str);
    MLOG(@"......value: %d stringLength: %d", value, str.length);
    NSString *returnStr = nil;
    if ( value <= 0 || value > 100 || str.length == 0 ) {
        MLOG(@"");
        returnStr = str;
    }
    else {
        MLOG(@"");
        NSMutableString *newStr = [NSMutableString stringWithFormat:@"%@", str];
        
        int numCharsToKill = (int)(((CGFloat)value/100) * str.length);
        MLOG(@"......numCharsToKill: %d", numCharsToKill);
        for ( int killedChars = 0; killedChars < numCharsToKill; killedChars++ ) {
            int indexToWipe = [Dice roll: newStr.length - 1 ] - 1;
            if ( indexToWipe < newStr.length-1 ) {
                MLOG(@"......wiping \"%@\" index %d", newStr, indexToWipe);
                [newStr setString: [newStr stringByReplacingCharactersInRange: NSMakeRange(indexToWipe, 1) withString: @" "]];
                //newStr = tmpStr;
            } else {
                indexToWipe = 0;
                MLOG(@"......ERROR: wiping \"%@\" index %d", newStr, indexToWipe);
                [newStr setString: [newStr stringByReplacingCharactersInRange: NSMakeRange(indexToWipe, 1) withString: @" "]];
                //tmpStr = [newStr stringByReplacingCharactersInRange: NSMakeRange(indexToWipe, indexToWipe+1) withString: @" "];
                //newStr = tmpStr;
            }
        }
        returnStr = newStr;
    }
    MLOG(@"returning %@", returnStr);
    
    return returnStr;
}



-( void ) incrementIndex {
    currentIndex++;
    if ( currentIndex == maxIndex ) {
        currentIndex = 0;
    }
}




-(id) init {
    if ((self=[super init])) {
        
    }
    return self;
}

@end
