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
//  AsyncObject.m
//  PixelPile
//
//  Created by Lam Pham on 1/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AsyncObject.h"

@implementation AsyncObject
@synthesize selector = selector_;
@synthesize target = target_;
@synthesize data = data_;
- (void) dealloc
{
	[target_ release];
	[data_ release];
	[super dealloc];
}
@end

