#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioServices.h>

#import "cocos2d.h"
#import "Car.h"
#import "Hole.h"
#import "HelloWorldLayer.h"
#import "Game.h"
#import "Entity.h"
#import "Alcohol.h"
#import "DestroyedCar.h"
#import "GameOverScene.h"

#import "PauseLayer.h"

@interface GameLayer : CCLayer {
    Car *car;
    Hole *hole;
    Entity *background;
    Alcohol *bottle;
    DestroyedCar *destroyedCar;
    
    CCLabelAtlas *scoreLabel;
    CCMenu *menu;
    
    int gameSpeed;
    int score;
}


-(void) menuItemClicked:(id) sender;
+(CCScene *) scene;

@end
