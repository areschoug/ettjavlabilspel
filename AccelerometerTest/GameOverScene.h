//
//  GameOverScene.h
//  AccelerometerTest
//
//  Created by Andreas Areschoug on 2011-09-29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "HelloWorldLayer.h"
#import "Game.h"

@interface GameOverScene : CCLayer {
    
}

+(CCScene *) scene;
-(void)saveHighScore;

@end
