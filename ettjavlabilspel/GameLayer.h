//
//  GameLayer.h
//  ettjavlabilspel
//
//  Created by Andreas Areschoug.
//


#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioServices.h>

#import "SceneManager.h"

#import "cocos2d.h"
#import "Game.h"

#import "Entity.h"
#import "Car.h"
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


@interface GameLayer : CCLayer {
    Entity *background;
    Entity *tunnel;
    Car *car;
    //OBSTACLE
    Obstacle *obstacleOne;
    Obstacle *obstacleTwo;    
    BigObstacle *bigObstacle;
    MovingObstacle *movingObstacle;
    //POWERUPS
    Alcohol *bottle;
    Immortal *immortal;
    Small *small;
    Gun *gun;
    Bullet *bullet;
    CCSprite *carGun;
    Slow *slow;
    Fast *fast;
    //GUI
    CCLabelTTF *scoreLabel;
    CCMenu *menu;
    CCMenu *pauseMenu;
    CCMenuItemImage *music;
    CCMenuItemImage *sfx;
    
    CCTexture2D *movingTexture1;
    CCTexture2D *movingTexture2;
    
    float gameSpeed;
    int realGameSpeed;
    int score;
    int changeScore;
    int changeTicker;
    int level;
    int repeatRate;
    int movingTexture;
    
    float accX;
    float accY;
    
    BOOL textureChanged;
    BOOL tunnlePlaced;
    BOOL playing;
    BOOL drunk;
}


-(void) menuItemClicked:(id) sender;
-(void) setTexture;
-(void) saveState;
-(void) checkMusic;
-(void) checkSfx;
-(void) movingTexture:(ccTime) dt;

@end
