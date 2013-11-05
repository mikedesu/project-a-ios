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
