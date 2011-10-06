//
//  Game.m
//  AccelerometerTest
//
//  Created by Andreas Areschoug on 2011-09-20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Game.h"

@implementation Game

static Game* _sharedGame = nil;

//CURENT STATE
@synthesize drunk;
@synthesize gameSpeed;
@synthesize currentScore;
@synthesize music;

//POSITION
@synthesize carPosition;
@synthesize holePosition;
@synthesize bottlePosition;
@synthesize destroyedCarPosition;



+(Game*)sharedGame
{
    @synchronized([Game class])
    {
        if(!_sharedGame)
            _sharedGame = [[self alloc]init];
        
        return _sharedGame;
    }
}

+(id)alloc
{
    @synchronized([Game class])
    {
        NSAssert(_sharedGame == nil, @"Atempted to allocate a second intance of a singelton.");
        _sharedGame = [super alloc];
        return _sharedGame;
    }
}

-(void)resetGame
{

    //SPEED
    self.gameSpeed = 1;

    //DRUNK
    self.drunk = NO;
    
    //MUSIC
    self.music = NO;
    
    //CURRENTSCORE
    self.currentScore = 0;
    
    //CAR
    self.carPosition = ccp(160,50);

    //HOLE
    Hole *hole = [[Hole alloc] init];
    self.holePosition = [hole getStartPositions:100];
    [hole release];
    hole =nil;
    
    //DESTROYED CAR
    DestroyedCar *destroyedCar = [[DestroyedCar alloc] init];
    self.destroyedCarPosition = [destroyedCar getStartPositions:1000];
    [destroyedCar release];
    destroyedCar = nil;
    
    //BOTTLE
    Alcohol *bottle = [[Alcohol alloc] init];
    self.bottlePosition = [bottle getStartPositions:1000];
    [bottle release];
    bottle = nil;
}

-(int)highestScore:(NSArray *)highScore
{
//    NSArray *sorted = [[NSArray alloc]initWithArray:[[NSUserDefaults standardUserDefaults]arrayForKey:@"highScoreArray"]];
    NSArray *sortedArray = [highScore sortedArrayUsingSelector:@selector(compare:)];
    int sortedArrayCount = [sortedArray count];
    int retrunInt = [[sortedArray objectAtIndex:(sortedArrayCount-1)]intValue];

    return retrunInt;
}


-(void)dealloc
{
    NSLog(@"GAME DEALLOC");
    [_sharedGame release];
    [super dealloc];
}

@end