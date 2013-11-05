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
//  TestFlight+AsyncLogging.h
//  libTestFlight
//
//  Created by Jason Gregori on 2/12/13.
//  Copyright (c) 2013 TestFlight. All rights reserved.
//

/*

 When logging, it is important that logs are written synchronously. In the event of a crash, all logs that happened before the crash are gauranteed to be on disk. If they were written asynchronously and a crash occurs, you might lose some very valuable logs that might have helped fixed the crash.
 
 However, because TFLog waits until writing to disk is complete, it takes a while. If you have a very high preformance app that can't afford to wait for logs, these functions are for you.
 
 USE THESE, BUT KNOW YOU RISK LOSING SOME LOGS AT CRASH TIME
 
 */

#import "TestFlight.h"



#if __cplusplus
extern "C" {
#endif
    void TFLog_async(NSString *format, ...) __attribute__((format(__NSString__, 1, 2)));
    void TFLogv_async(NSString *format, va_list arg_list);
#if __cplusplus
}
#endif