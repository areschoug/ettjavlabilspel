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
@synthesize movingObstaclePosition;

@synthesize bottlePosition;
@synthesize immortalPosition;
@synthesize smallPosition;
@synthesize gunPosition;
@synthesize bulletPosition;
@synthesize carGunPosition;
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


/** resetGame
 *
 * This method set the starting values for all in game objects.
 *
 */
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
    
    //OBSTACLE
    Obstacle *obstacle = [[Obstacle alloc] init];
    self.obstacleOnePosition = [obstacle getStartPositions:obstacle.startRate];
    self.obstacleTwoPosition = [obstacle getStartPositions:obstacle.startRate];
    [obstacle release];
    
    //BIG OBSTACLE
    BigObstacle *bigObstacle = [[BigObstacle alloc] init];
    self.bigObstaclePosition = [bigObstacle getStartPositions:bigObstacle.startRate];
    [bigObstacle release];
    
    //MOVING OBSTACLE
    MovingObstacle *movingObstacle = [[MovingObstacle alloc] init];
    self.movingObstaclePosition = [movingObstacle getMovingStartPositions];
    [movingObstacle release];
    
    //BOTTLE
    Alcohol *bottle = [[Alcohol alloc] init];
    self.bottlePosition = [bottle getStartPositions:bottle.startRate];
    [bottle release];
    
    //INVINVIBLE
    Immortal *immortal = [[Immortal alloc] init];
    self.immortalPosition = [immortal getStartPositions:immortal.startRate];
    [immortal release];
    
    //SMALL
    Small *small = [[Small alloc] init];
    self.smallPosition = [small getStartPositions:small.startRate];
    [small release];
    
    //GUN
    Gun *gun = [[Gun alloc] init];
    self.gunPosition = [gun getStartPositions:gun.startRate];
    [gun release];
    
    //BULLET
    self.bulletPosition = ccp(1000, 1000);
    
    //CARGUN
    self.carGunPosition = ccp(1000, 1000);
    
    //SLOW
    Slow *slow = [[Slow alloc] init];
    self.slowPosition = [slow getStartPositions:7000];
    [slow release];
    
    //FAST
    Fast *fast = [[Fast alloc] init];
    self.fastPosition = [fast getStartPositions:7000];
    [fast release];
    
}


-(void)dealloc
{
    NSLog(@"GAME DEALLOC");
    [_sharedGame release];
    [super dealloc];
}

@end