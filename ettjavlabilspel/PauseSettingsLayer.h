//
//  PauseSettingsLayer.h
//  ettjavlabilspel
//
//  Created by Andreas Areschoug on 2011-10-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SceneManager.h"

@interface PauseSettingsLayer : CCLayer {
    CCMenuItemLabel *music;
    CCMenuItemLabel *sfx;
    CCSprite *background;
}

-(NSString *)checkMusic;
-(NSString *)checkSfx;

@end
