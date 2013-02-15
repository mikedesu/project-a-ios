//  Dice.c
//  project-a-ios
//
//  Created by Mike Bell on 2/15/13.

#include "Dice.h"
#include <stdlib.h>
#include <time.h>

static int isSeeded = 0;

long int rollDiceOnce( int sides ) {
    if ( ! isSeeded ) {
        srand( time( NULL ) ) ;
    }
    return ROLL_DICE_ONCE(sides);
}

long int rollDiceOnceWithModifier( int sides, int modifier ) {
    return rollDiceOnce(sides) + modifier;
}

long int rollDice( int sides, int times ) {
    long int sum = 0;
    int i = 0;
    while ( i < times ) {
        sum += rollDiceOnce( sides );
        i++;
    }
    return sum;
}

long int rollDiceWithModifier( int sides, int modifier, int times ) {
    long int sum = 0;
    int i = 0;
    while ( i < times ) {
        sum += rollDiceOnceWithModifier(sides, modifier);
        i++;
    }
    return sum;
}