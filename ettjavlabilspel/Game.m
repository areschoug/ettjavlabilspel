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
@synthesize changeScore;
@synthesize carColor;
@synthesize state;
@synthesize stateTimer;
@synthesize level;
@synthesize repeatRate;
@synthesize music;
@synthesize musicPlaying;
@synthesize sfx;
@synthesize started;

//POSITION
@synthesize backgroundPosition;
@synthesize carPosition;

@synthesize obstacleOnePosition;
@synthesize obstacleTwoPosition;
@synthesize bigObstaclePosition;

@synthesize bottlePosition;
@synthesize inviciblePosition;
@synthesize smallPosition;
@synthesize gunPosition;
@synthesize bulletPosition;
@synthesize fastPosition;
@synthesize slowPosition;
@synthesize tunnelPosition;

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
    
    //CHANGESCORE
    self.changeScore = 400;
    
    //STATE
    self.state = 0;
    
    //LEVEL
    self.level = 1;
    
    //REPEAT RATE
    self.repeatRate = 80;
   
    //CAR
    self.carPosition = ccp(160,50);

    //BACKGROUND
    self.backgroundPosition = ccp(160, 240-20);
    
    //TUNNEL
    self.tunnelPosition = ccp(-400, 100000);
    
    //HOLE
    Obstacle *obstacle = [[Obstacle alloc] init];
    self.obstacleOnePosition = [obstacle getStartPositions:obstacle.startRate];
    self.obstacleTwoPosition = [obstacle getStartPositions:obstacle.startRate];
    [obstacle release];
    obstacle =nil;
    
    //DESTROYED CAR
    BigObstacle *bigObstacle = [[BigObstacle alloc] init];
    self.bigObstaclePosition = [bigObstacle getStartPositions:bigObstacle.startRate];
    [bigObstacle release];
    bigObstacle = nil;
    
    //BOTTLE
    Alcohol *bottle = [[Alcohol alloc] init];
    self.bottlePosition = [bottle getStartPositions:bottle.startRate];
    [bottle release];
    bottle = nil;
    
    //INVINVIBLE
    Immortal *invicible = [[Immortal alloc] init];
    self.inviciblePosition = [invicible getStartPositions:invicible.startRate];
    [invicible release];
    invicible = nil;
    
    //SMALL
    Small *small = [[Small alloc] init];
    self.smallPosition = [small getStartPositions:small.startRate];
    [small release];
    small = nil;
    
    //GUN
    Gun *gun = [[Gun alloc] init];
    self.gunPosition = [gun getStartPositions:gun.startRate];
    [gun release];
    gun = nil;
    
    //BULLET
    self.bulletPosition = ccp(1000, 1000);
    
    //SLOW
    Slow *slow = [[Slow alloc] init];
    self.slowPosition = [slow getStartPositions:slow.startRate];
    [slow release];
    slow = nil;
    
    //FAST
    Fast *fast = [[Fast alloc] init];
    self.fastPosition = [fast getStartPositions:fast.startRate];
    [fast release];
    fast = nil;
    
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
    self.musicPlaying = NO;
    
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