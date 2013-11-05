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
//  Zodiac.h
//  project-a-ios
//
//  Created by Mike Bell on 6/25/13.

#define ZODIAC_CYCLE_TURN_COUNT         1728  // 12^3
#define ZODIAC_FULL_CYCLE_TURN_COUNT    20736 // 12^4

typedef enum {
    //ZODIAC_T_NONE,
    
    ZODIAC_T_ARIES,
    ZODIAC_T_TAURUS,
    ZODIAC_T_GEMINI,
    ZODIAC_T_CANCER,
    ZODIAC_T_LEO,
    ZODIAC_T_VIRGO,
    ZODIAC_T_LIBRA,
    ZODIAC_T_SCORPIO,
    ZODIAC_T_SAGITTARIUS,
    ZODIAC_T_CAPRICORNUS,
    ZODIAC_T_AQUARIUS,
    ZODIAC_T_PISCES,
    
    ZODIAC_T_COUNT
} Zodiac_t;


#define ZODIAC_STRING(sign) \
(\
sign==ZODIAC_T_ARIES        ? @"Aries" : \
sign==ZODIAC_T_TAURUS       ? @"Taurus" : \
sign==ZODIAC_T_GEMINI       ? @"Gemini" : \
sign==ZODIAC_T_CANCER       ? @"Cancer" : \
sign==ZODIAC_T_LEO          ? @"Leo" : \
sign==ZODIAC_T_VIRGO        ? @"Virgo" : \
sign==ZODIAC_T_SCORPIO      ? @"Scorpio" : \
sign==ZODIAC_T_SAGITTARIUS  ? @"Sagittarius" : \
sign==ZODIAC_T_CAPRICORNUS  ? @"Capricornus" : \
sign==ZODIAC_T_AQUARIUS     ? @"Aquarius" : \
sign==ZODIAC_T_PISCES       ? @"Pisces" : \
sign==ZODIAC_T_LIBRA        ? @"Libra" : \
@"Unknown Zodiac")


