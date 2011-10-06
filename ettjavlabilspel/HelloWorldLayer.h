//
//  HelloWorldLayer.h
//  ettjavlabilspel
//
//  Created by Andreas Areschoug.
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
