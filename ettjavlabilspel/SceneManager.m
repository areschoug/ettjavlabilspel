//
//  SceneManager.m
//  ettjavlabilspel
//
//  Created by Andreas Areschoug.
//

#import "SceneManager.h"

@implementation SceneManager

+(void) goMenu
{
    CCLayer *layer = [MenuLayer node];
    [SceneManager go: layer];
}

+(void) goGame
{
    CCLayer *layer = [GameLayer node];
    [SceneManager go: layer];
}

+(void) goCarSelect
{
    CCLayer *layer = [CarSelectLayer node];
    [SceneManager go: layer];
}

+(void) goHighScore
{
    CCLayer *layer = [HighScoreLayer node];
    [SceneManager go: layer];

}

+(void) goGameOver
{
    CCLayer *layer = [GameOverLayer node];
    [SceneManager go:layer];
}

+(void) goSettings
{
    CCLayer *layer = [SettingsLayer node];
    [SceneManager go:layer];

}

+(void) goInstructions
{
    CCLayer *layer = [InstructionsLayer node];
    [SceneManager go:layer];

}

+(void) go:(CCLayer *)layer
{
    CCDirector *director = [CCDirector sharedDirector];
    CCScene *newScene = [SceneManager warp:layer];
    
    if([director runningScene])
        [director replaceScene:newScene];
    else
        [director runWithScene:newScene];
    
}

+(CCScene *) warp:(CCLayer *)layer
{
    CCScene *newScene = [CCScene node];
    [newScene addChild:layer];
    return newScene;
}

@end
