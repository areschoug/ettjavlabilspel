//
//  SceneManager.h
//  ettjavlabilspel
//
//  Created by Andreas Areschoug.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MenuLayer.h"
#import "GameOverLayer.h"
#import "GameLayer.h"
#import "HighScoreLayer.h"

@interface SceneManager : NSObject
{

}

+(void) goMenu;
+(void) goGame;
+(void) goHighScore;
+(void) goGameOver;

+(void) go: (CCLayer *) layer;
+(CCScene *)warp:(CCLayer *) layer;

@end
