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
#import "Hole.h"
#import "DestroyedCar.h"

#import "Alcohol.h"
#import "Invincible.h"
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
    Hole *hole;
    DestroyedCar *destroyedCar;
    //POWERUPS
    Alcohol *bottle;
    Invincible *invincible;
    Small *small;
    Gun *gun;
    Bullet *bullet;
    Slow *slow;
    Fast *fast;
    //GUI
    CCLabelTTF *scoreLabel;
    CCMenu *menu;
    CCMenu *pauseMenu;
    CCMenuItemImage *musicButton;
    CCMenuItemImage *sfxButton;
    
    int gameSpeed;
    int realGameSpeed;
    int score;
    int changeTicker;
    int level;
    int repeatRate;
    BOOL textureChanged;
    BOOL playing;
}


-(void) menuItemClicked:(id) sender;
-(void) setTexture;
-(void) saveState;

@end
