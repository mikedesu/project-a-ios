//
//  AppDelegate.h
//  project-a-ios
//
//  Created by Mike Bell on 2/8/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"

@interface AppController : NSObject <UIApplicationDelegate, CCDirectorDelegate>
{
	UIWindow *window_;
	UINavigationController *navController_;

	CCDirectorIOS	*director_;							// weak ref
    
    
    NSInteger strength;
    NSInteger dexterity;
    NSInteger constitution;
    NSInteger intelligence;
    NSInteger wisdom;
    NSInteger charisma;
    
}

@property (nonatomic, retain) UIWindow *window;
@property (readonly) UINavigationController *navController;
@property (readonly) CCDirectorIOS *director;

@property (atomic, assign) NSInteger strength;
@property (atomic, assign) NSInteger dexterity;
@property (atomic, assign) NSInteger constitution;
@property (atomic, assign) NSInteger intelligence;
@property (atomic, assign) NSInteger wisdom;
@property (atomic, assign) NSInteger charisma;


@end
