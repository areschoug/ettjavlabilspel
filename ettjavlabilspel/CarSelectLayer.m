//
//  CarSelectLayer.m
//  ettjavlabilspel
//
//  Created by Andreas Areschoug on 2011-10-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CarSelectLayer.h"


@implementation CarSelectLayer

- (id)init {
    self = [super init];
    if (self) {
        CCMenu *menu;
       
        background = [[CCSprite alloc] initWithFile:@"mainscreen-background.png"];
        background.position = ccp(160, 240);
        [self addChild:background];
        [background release];
        
        CCMenuItemImage *back = [CCMenuItemImage itemFromNormalImage:@"back-button1.png" selectedImage:@"back-button2.png" target:self selector:@selector(backButtonClicked:)];
        back.position = ccp(250, 420);
        
        CCMenuItemImage *play = [CCMenuItemImage itemFromNormalImage:@"play-button1.png" selectedImage:@"play-button2.png" target:self selector:@selector(startGame:)];
        play.position = ccp(160,75);
        
        red = [CCMenuItemImage itemFromNormalImage:@"red.png" selectedImage:@"red.png" target:self selector:@selector(changeCarColor:)];
        red.position = ccp(280, 240);
        red.tag = 0;

        green = [CCMenuItemImage itemFromNormalImage:@"gren.png" selectedImage:@"gren.png" target:self selector:@selector(changeCarColor:)];
        green.position = ccp(170, 240);
        green.tag = 1;
        
        blue = [CCMenuItemImage itemFromNormalImage:@"blue.png" selectedImage:@"blue.png" target:self selector:@selector(changeCarColor:)];
        blue.position = ccp(50, 240);
        blue.tag = 2;
        
        glow = [[CCSprite alloc] initWithFile:@"glow.png"];
        
        switch ([Game sharedGame].carColor) {
            case 0:
                glow.position = red.position;
                break;
            case 1:
                glow.position = green.position;
                break;
            case 2:
                glow.position = blue.position;
                break;
            default:
                break;
        }
        
        menu = [CCMenu menuWithItems:play,red,green,blue,back, nil];
        menu.position = ccp(0, 0);
        [self addChild:glow];
        [self addChild:menu];
    }
    return self;
}

-(void) backButtonClicked:(id)sender
{
    [SceneManager goMenu];
}

-(void) changeCarColor:(id)sender
{
    switch ([sender tag]) {
        case 0:
            [Game sharedGame].carColor = 0;
            glow.position = red.position;
            break;
        case 1:
            [Game sharedGame].carColor = 1;
            glow.position = green.position;
            break;
        case 2:
            [Game sharedGame].carColor = 2;
            glow.position = blue.position;
            break;
        default:
            break;
    }
}

-(void) startGame:(id)sender
{
    [[Game sharedGame]resetGame];
    [SceneManager goGame];
}

- (void)dealloc {
    [super dealloc];
}

@end
