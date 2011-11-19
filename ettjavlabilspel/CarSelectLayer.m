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
        
        greencar = [CCMenuItemImage itemFromNormalImage:@"green-car.png" selectedImage:@"green-car.png" target:self selector:@selector(changeCarColor:)];
        greencar.position = ccp(50, 300);
        greencar.tag = 0;

        sportcar = [CCMenuItemImage itemFromNormalImage:@"sport-car.png" selectedImage:@"sport-car.png" target:self selector:@selector(changeCarColor:)];
        sportcar.position = ccp(170, 300);
        sportcar.tag = 1;
        
        jeep = [CCMenuItemImage itemFromNormalImage:@"jeep.png" selectedImage:@"jeep.png" target:self selector:@selector(changeCarColor:)];
        jeep.position = ccp(280, 300);
        jeep.tag = 2;
        
        bat = [CCMenuItemImage itemFromNormalImage:@"bat-car.png" selectedImage:@"bat-car.png" target:self selector:@selector(changeCarColor:)];
        bat.position = ccp(50, 200);
        bat.tag = 3;
        
        army = [CCMenuItemImage itemFromNormalImage:@"army.png" selectedImage:@"army.png" target:self selector:@selector(changeCarColor:)];
        army.position = ccp(170, 200);
        army.tag = 4;
        
        dream = [CCMenuItemImage itemFromNormalImage:@"dream-car.png" selectedImage:@"dream-car.png" target:self selector:@selector(changeCarColor:)];
        dream.position = ccp(280, 200);
        dream.tag = 5;
        
        glow = [[CCSprite alloc] initWithFile:@"glow.png"];
        
        switch ([Game sharedGame].carColor) {
            case 0:
                glow.position = greencar.position;
                break;
            case 1:
                glow.position = sportcar.position;
                break;
            case 2:
                glow.position = jeep.position;
                break;
            case 3:
                glow.position = bat.position;
                break;
            case 4:
                glow.position = army.position;
                break;
            case 5:
                glow.position = dream.position;
                break;                
            default:
                break;
        }
        
        highestScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"highestScore"];


        
        if(highestScore < 200){
            CCMenuItemImage *lock = [CCMenuItemImage itemFromNormalImage:@"glow.png" selectedImage:@"glow.png"];
            [sportcar setNormalImage:lock];
        }
        
        if(highestScore < 400){
            CCMenuItemImage *lock = [CCMenuItemImage itemFromNormalImage:@"glow.png" selectedImage:@"glow.png"];
            [jeep setNormalImage:lock];
        }
        
        if(highestScore < 600){
            CCMenuItemImage *lock = [CCMenuItemImage itemFromNormalImage:@"glow.png" selectedImage:@"glow.png"];
            [bat setNormalImage:lock];
        }
        
        if(highestScore < 1000){
            CCMenuItemImage *lock = [CCMenuItemImage itemFromNormalImage:@"glow.png" selectedImage:@"glow.png"];
            [army setNormalImage:lock];
        }
        
        if(highestScore < 1200){
            CCMenuItemImage *lock = [CCMenuItemImage itemFromNormalImage:@"glow.png" selectedImage:@"glow.png"];
            [dream setNormalImage:lock];
        }
        
        menu = [CCMenu menuWithItems:play, greencar, sportcar, jeep, bat, army, dream, back, nil];
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
            glow.position = greencar.position;
            break;
        case 1:
            if(highestScore > 200){
                [Game sharedGame].carColor = 1;
                glow.position = sportcar.position;
            }
            break;
        case 2:
            if(highestScore > 400){
                [Game sharedGame].carColor = 2;
                glow.position = jeep.position;
            }
            break;
        case 3:
            if(highestScore > 600){
                [Game sharedGame].carColor = 3;
                glow.position = bat.position;
            }
            break;
        case 4:
            if(highestScore > 800){
                [Game sharedGame].carColor = 4;
                glow.position = army.position;
            }
            break;
        case 5:
            if(highestScore > 1000){    
                [Game sharedGame].carColor = 5;
                glow.position = dream.position;
            }
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
