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
#import "SettingsLayer.h"
#import "InstructionsLayer.h"
#import "PauseLayer.h"
#import "PauseSettingsLayer.h"

@interface SceneManager : NSObject
{

}

+(void) goMenu;
+(void) goGame;
+(void) goHighScore;
+(void) goGameOver;
+(void) goSettings;
+(void) goInstructions;
+(void) goPaus;
+(void) goPausSettings;

+(void) go: (CCLayer *) layer;
+(CCScene *)warp:(CCLayer *) layer;

@end
