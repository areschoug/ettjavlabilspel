//
// GameOverScene.h
// ettjavlabilspel
//
// Created by Andreas Areschoug.
//  
// Shown when the player crashed whit the car 

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SceneManager.h"
#import "Game.h"

@interface GameOverLayer : CCLayer {
    CCSprite *background;
    CCSprite *highscoreBackgound;
    CCSprite *tunnel;
    CCSprite *car;
    //OBSTACLE
    CCSprite *obstacleOne;
    CCSprite *obstacleTwo;    
    CCSprite *bigObstacle;
    CCSprite *movingObstacle;    
    //POWERUPS
    CCSprite *bottle;
    CCSprite *immortal;
    CCSprite *small;
    CCSprite *gun;
    CCSprite *bullet;
   
    CCSprite *slow;
    CCSprite *fast;
    
    int level;
}

-(void)saveHighScore;
-(void)setTexture;
@end
