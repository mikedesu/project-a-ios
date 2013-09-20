//  MLog.h
//  project-a-macosx
//
//  Created by Mike Bell on 11/29/2012.

#define MDEBUG_MODE 1

#ifdef MDEBUG_MODE
#define MLOG( s, ... ) NSLog( @"<%p %@:(%d)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define MLOG( s, ... )
#endif



//#define M2DEBUG_MODE 1

#ifdef M2DEBUG_MODE
#define M2LOG( s, ... ) NSLog( @"<%p %@:(%d)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define M2LOG( s, ... )
#endif


//#define M3DEBUG_MODE 1

#ifdef M3DEBUG_MODE
#define M3LOG( s, ... ) NSLog( @"<%p %@:(%d)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define M3LOG( s, ... )
#endif




