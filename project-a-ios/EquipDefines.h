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
//  EquipDefines.h
//  project-a-ios
//
//  Created by Mike Bell on 3/25/13.

typedef enum {
    EQUIPSLOT_T_HEAD,
    EQUIPSLOT_T_NECK,
    EQUIPSLOT_T_CHEST,
    EQUIPSLOT_T_LSHOULDER,
    EQUIPSLOT_T_RSHOULDER,
    EQUIPSLOT_T_BACK,
    EQUIPSLOT_T_LARM,
    EQUIPSLOT_T_RARM,
    EQUIPSLOT_T_LHAND,
    EQUIPSLOT_T_RHAND,
    EQUIPSLOT_T_LRING,
    EQUIPSLOT_T_RRING,
    EQUIPSLOT_T_WAIST,
    
    EQUIPSLOT_T_LEGS,
    EQUIPSLOT_T_FEET,
    
    
    //EQUIPSLOT_T_LLEG,
    //EQUIPSLOT_T_RLEG,
    //EQUIPSLOT_T_LFOOT,
    //EQUIPSLOT_T_RFOOT,
    EQUIPSLOT_T_LARMTOOL,
    EQUIPSLOT_T_RARMTOOL,
    
    EQUIPSLOT_T_NUMSLOTS
    
} EquipSlot_t;


#define EquipSlotToStr(n)   (\
n==EQUIPSLOT_T_HEAD      ? @"Head" : \
n==EQUIPSLOT_T_NECK      ? @"Neck" : \
n==EQUIPSLOT_T_CHEST     ? @"Chest" : \
n==EQUIPSLOT_T_LSHOULDER ? @"Left Shoulder" : \
n==EQUIPSLOT_T_RSHOULDER ? @"Right Shoulder" : \
n==EQUIPSLOT_T_BACK      ? @"Back" : \
n==EQUIPSLOT_T_LARM      ? @"Left Arm" : \
n==EQUIPSLOT_T_RARM      ? @"Right Arm" : \
n==EQUIPSLOT_T_LHAND     ? @"Left Hand" : \
n==EQUIPSLOT_T_RHAND     ? @"Right Hand" : \
n==EQUIPSLOT_T_LRING     ? @"Left Ring" : \
n==EQUIPSLOT_T_RRING     ? @"Right Ring" : \
n==EQUIPSLOT_T_WAIST     ? @"Waist" : \
n==EQUIPSLOT_T_LEGS      ? @"Legs" : \
n==EQUIPSLOT_T_FEET      ? @"Feet" : \
n==EQUIPSLOT_T_LARMTOOL  ? @"Left Arm Tool" : \
n==EQUIPSLOT_T_RARMTOOL  ? @"Right Arm Tool" : \
@"undefined")