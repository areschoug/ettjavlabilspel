//
//  CarSelectLayer.h
//  ettjavlabilspel
//
//  Created by Andreas Areschoug on 2011-10-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SceneManager.h"
#import "Game.h"

@interface CarSelectLayer : CCLayer {
    CCSprite *glow;
    CCMenuItemImage *greencar;
    CCMenuItemImage *sportcar;
    CCMenuItemImage *jeep;
    CCMenuItemImage *bat;
    CCMenuItemImage *army;
    CCMenuItemImage *dream;
    CCSprite *background;
    
    int highestScore;
}

-(void) backButtonClicked:(id)sender;
-(void) changeCarColor:(id)sender;
-(void) startGame:(id)sender;
@end
