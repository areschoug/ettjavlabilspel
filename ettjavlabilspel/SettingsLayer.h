//
//  SettingsLayer.h
//  ettjavlabilspel
//
//  Created by Andreas Areschoug.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SceneManager.h"
#import "Game.h"
#import "SimpleAudioEngine.h"

@interface SettingsLayer : CCLayer {
    CCMenuItemLabel *music;
    CCMenuItemLabel *sfx;
    CCSprite *background;
}

-(NSString *)checkMusic;
-(NSString *)checkSfx;

@end
