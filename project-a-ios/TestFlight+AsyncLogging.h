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