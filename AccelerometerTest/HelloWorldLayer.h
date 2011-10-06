//
//  HelloWorldLayer.h
//  AccelerometerTest
//
//  Created by Andreas Areschoug on 2011-09-12.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "GameLayer.h"
#import "HighScoreScene.h"

#import "SimpleAudioEngine.h"
#import "CDAudioManager.h"
#import "CocosDenshion.h"

#import "Game.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{

}

// returns a CCScene that contains the HelloWorldLayer as the only child

+(CCScene *) scene;

@end
