//
//  GameOverScene.h
//  ettjavlabilspel
//
//  Created by Andreas Areschoug.
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
