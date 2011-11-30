//
// SettingsLayer.h
// ettjavlabilspel
//
// Created by Andreas Areschoug.
//
// Settings the user can choose to turn on/off music and sfx

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SceneManager.h"
#import "Game.h"
#import "SimpleAudioEngine.h"

@interface SettingsLayer : CCLayer {
    CCMenuItemImage *music;
    CCMenuItemImage *sfx;
    CCSprite *background;
}

-(void)checkMusic;
-(void)checkSfx;

@end
