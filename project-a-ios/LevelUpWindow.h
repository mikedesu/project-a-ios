/*
The MIT License (MIT)

Copyright (c) 2013 Mike Bell

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/
//  LevelUpWindow.h
//  project-a-ios
//
//  Created by Mike Bell on 6/6/13.

#import "cocos2d.h"

@interface LevelUpWindow : CCLayerColor {
    CCLabelTTF      *message, *label0, *label1, *label2, *label3, *label4, *label5;
    CCMenuItemLabel *menuLabel0, *menuLabel1, *menuLabel2, *menuLabel3, *menuLabel4, *menuLabel5;
    CCMenu          *menu;
}

@property (atomic) CCLabelTTF *message;
@property (atomic) CCLabelTTF *label0;
@property (atomic) CCLabelTTF *label1;
@property (atomic) CCLabelTTF *label2;
@property (atomic) CCLabelTTF *label3;
@property (atomic) CCLabelTTF *label4;
@property (atomic) CCLabelTTF *label5;

@property (atomic) CCMenuItemLabel *menuLabel0;
@property (atomic) CCMenuItemLabel *menuLabel1;
@property (atomic) CCMenuItemLabel *menuLabel2;
@property (atomic) CCMenuItemLabel *menuLabel3;
@property (atomic) CCMenuItemLabel *menuLabel4;
@property (atomic) CCMenuItemLabel *menuLabel5;

@property (atomic) CCMenu *menu;

@end
