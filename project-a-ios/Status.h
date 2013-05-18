//  Status.h
//  project-a-ios
//
//  Created by Mike Bell on 5/18/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.


typedef enum {
    STATUS_T_NORMAL,
    STATUS_T_POISON,
    
    STATUS_T_COUNT
} Status_t;




typedef enum {
    POISON_T_HP_DAMAGE,
    POISON_T_COUNT
} Poison_t;



@interface Status : NSObject {
    
    Status_t base;
    
    // Poison variables
    Poison_t poisonType;
    NSInteger poisonDamageBase;
    NSInteger poisonDamageMod;
    
}

@property (atomic, assign) Status_t base;
@property (atomic, assign) Poison_t poisonType;
@property (atomic, assign) NSInteger poisonDamageBase;
@property (atomic, assign) NSInteger poisonDamageMod;




+(Status *) normal;
+(Status *) simplePoison;

@end
