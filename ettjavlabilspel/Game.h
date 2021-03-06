//
// Game.h
// ettjavlabilspel
//
// Created by Andreas Areschoug.
//
// This is a singelton-class wich keeps track of the current gamestate when the 
// gamelayer is initialized. It also containes the starting values and positions of
// ingame objects.


#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Obstacle.h"
#import "BigObstacle.h"
#import "MovingObstacle.h"
#import "Alcohol.h"
#import "Immortal.h"
#import "Small.h"
#import "Gun.h"
#import "Bullet.h"
#import "Slow.h"
#import "Fast.h"

@interface Game : CCNode
{
    //STATE
    @public int gameSpeed;
    @public int currentScore;
    @public int changeScore;
    @public int carColor;
    @public int state;
    @public int stateTimer;    
    @public int level;
    @public int repeatRate;
    @public BOOL music;
    @public BOOL musicPlaying;
    @public BOOL sfx;
    @public BOOL started;
    
    //POSITION
    @public CGPoint backgroundPosition;
    @public CGPoint carPosition;
    
    @public CGPoint obstacleOnePosition;
    @public CGPoint obstacleTwoPosition;    
    @public CGPoint bigObstaclePosition;
    @public CGPoint movingObstaclePosition;
    
    @public CGPoint bottlePosition;
    @public CGPoint immortalPosition;
    @public CGPoint smallPosition;
    @public CGPoint gunPosition;
    @public CGPoint bulletPosition;
    @public CGPoint carGunPosition;
    @public CGPoint fastPosition;
    @public CGPoint slowPosition;
    @public CGPoint tunnelPosition;
}

//STATE
@property(readwrite,assign) int gameSpeed;
@property(readwrite,assign) int currentScore;
@property(readwrite,assign) int changeScore;
@property(readwrite,assign) int carColor;
@property(readwrite,assign) int state;
@property(readwrite,assign) int stateTimer;
@property(readwrite,assign) int level;
@property(readwrite,assign) int repeatRate;
@property(readwrite,assign) BOOL music;
@property(readwrite,assign) BOOL musicPlaying;
@property(readwrite,assign) BOOL sfx;
@property(readwrite,assign) BOOL started;

//POSITION
@property(readwrite,assign) CGPoint backgroundPosition;
@property(readwrite,assign) CGPoint carPosition;

@property(readwrite,assign) CGPoint obstacleOnePosition;
@property(readwrite,assign) CGPoint obstacleTwoPosition;
@property(readwrite,assign) CGPoint bigObstaclePosition;
@property(readwrite,assign) CGPoint movingObstaclePosition;

@property(readwrite,assign) CGPoint bottlePosition;
@property(readwrite,assign) CGPoint immortalPosition;;
@property(readwrite,assign) CGPoint smallPosition;
@property(readwrite,assign) CGPoint gunPosition;
@property(readwrite,assign) CGPoint bulletPosition;
@property(readwrite,assign) CGPoint carGunPosition;
@property(readwrite,assign) CGPoint fastPosition;
@property(readwrite,assign) CGPoint slowPosition;
@property(readwrite,assign) CGPoint tunnelPosition;

+(Game*)sharedGame;
-(void)resetGame;
@end
