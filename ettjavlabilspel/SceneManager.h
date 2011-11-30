//
// SceneManager.h
// ettjavlabilspel
//
// Created by Andreas Areschoug.
//
// This class manage all the scenes and commits the changes of scenes
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MenuLayer.h"
#import "GameOverLayer.h"
#import "GameLayer.h"
#import "HighScoreLayer.h"
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
+(void) goGameOver;
+(void) goSettings;
+(void) goInstructions;

+(void) go: (CCLayer *) layer;
+(CCScene *)warp:(CCLayer *) layer;

@end
