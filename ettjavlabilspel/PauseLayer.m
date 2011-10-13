//
//  PauseLayer.m
//  ettjavlabilspel
//
//  Created by Andreas Areschoug.
//
//  When the game is paused the game gets greyed out and a menu screen will pop-up. With 
//  options to quit,resume and settings.
//
//  TODO:
//  -work work

#import "PauseLayer.h"


@implementation PauseLayer

-(id)init
{
    if((self=[super init])){

        background = [[CCSprite alloc]initWithFile:@"road.png"];
        background.position = [Game sharedGame].backgroundPosition;
        
        
        CCMenuItemImage *returnButton = [CCMenuItemImage itemFromNormalImage:@"menu-continue.png" selectedImage:@"menu-continue.png" target:self selector:@selector(menuItemClicked:)];
        
        CCMenuItemImage *settingsButton = [CCMenuItemImage itemFromNormalImage:@"menu-settings.png" selectedImage:@"menu-settings.png" target:self selector:@selector(menuItemClicked:)];
        
        CCMenuItemImage *menuButton = [CCMenuItemImage itemFromNormalImage:@"menu-newgame.png" selectedImage:@"menu-newgame.png" target:self selector:@selector(menuItemClicked:)];
        
        returnButton.position = ccp(0, 100);
        settingsButton.position = ccp(0, 0);
        menuButton.position = ccp(0, -100);
        
        [returnButton setTag:1];
        [settingsButton setTag:2];
        [menuButton setTag:3];
        
        menu = [CCMenu menuWithItems:returnButton,settingsButton,menuButton, nil];
        
        [self addChild:background];
        [self addChild:menu];
    }
    
    return self;
}

-(void)menuItemClicked:(id)sender{
    

    switch ([sender tag]) {
        case 1:
            [SceneManager goGame];
            break;
        case 2:
            [SceneManager goPausSettings];
            break;
        case 3:
            [SceneManager goMenu];
            break;
        default:
            break;
    }
}


@end
