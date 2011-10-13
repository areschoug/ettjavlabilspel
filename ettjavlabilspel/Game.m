//
//  Game.m
//  ettjavlabilspel
//
//  Created by Andreas Areschoug.
//
//  A singelton class that keeps track of all the entities position when the game is paused.
//  When the game is ended the game score is saved to be put in the highscore array
//  TODO:
//  - proably something but not atm

#import "Game.h"

@implementation Game

static Game* _sharedGame = nil;

//CURENT STATE
@synthesize gameSpeed;
@synthesize currentScore;
@synthesize drunk;
@synthesize music;
@synthesize mute;
@synthesize sfx;
@synthesize started;

//POSITION
@synthesize backgroundPosition;
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

    //CURRENTSCORE
    self.currentScore = 0;
    
    //DRUNK
    self.drunk = NO;
    
    //MUSIC
    self.music = NO;
    
    //CAR
    self.carPosition = ccp(160,50);

    //BACKGROUND
    self.backgroundPosition = ccp(160, 240-20);
    
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
    NSArray *sortedArray = [highScore sortedArrayUsingSelector:@selector(compare:)];
    int sortedArrayCount = [sortedArray count];
    int retrunInt = [[sortedArray objectAtIndex:(sortedArrayCount-1)]intValue];

    return retrunInt;
}

-(void)startGame
{
    self.started = YES;
    //MUSIC
    self.music = NO;
    self.mute = NO;
    
    //SOUND EFFECTS
    self.sfx = YES;
    NSLog(@"START GAME KÖR");
}

-(void)dealloc
{
    NSLog(@"GAME DEALLOC");
    [_sharedGame release];
    [super dealloc];
}

@end