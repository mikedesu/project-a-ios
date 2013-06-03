//  CharacterCreationScreen.h
//  project-a-ios
//
//  Created by Mike Bell on 6/3/13.

#import "cocos2d.h"

@interface CharacterCreationScreen : CCLayerColor {
    NSInteger strength,
    constitution,
    dexterity,
    intelligence,
    wisdom,
    charisma;
    
    CCLabelTTF *stat0;
    CCLabelTTF *stat1;
    CCLabelTTF *stat2;
    CCLabelTTF *stat3;
    CCLabelTTF *stat4;
    CCLabelTTF *stat5;

}

//+(CCScene *) scene;
-(void) rollStats;

@end
