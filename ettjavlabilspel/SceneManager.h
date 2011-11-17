//
//  SceneManager.h
//  ettjavlabilspel
//
//  Created by Andreas Areschoug.
//1u

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MenuLayer.h"
#import "GameOverLayer.h"
#import "GameLayer.h"
#import "HighScoreLayer.h"
#import "GlobalHighScoreLayer.h"
#import "SettingsLayer.h"
#import "InstructionsLayer.h"
#import "CarSelectLayer.h"

@interface SceneManager : NSObject
{

}

+(void) goMenu;
+(void) goGame;
+(void) goCarSelect;
+(void) goHighScore;
+(void) goGlobalHighScore;
+(void) goGameOver;
+(void) goSettings;
+(void) goInstructions;

+(void) go: (CCLayer *) layer;
+(CCScene *)warp:(CCLayer *) layer;

@end
