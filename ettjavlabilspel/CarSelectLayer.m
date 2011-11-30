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
       
        background = [[CCSprite alloc] initWithFile:@"cityroad.png"];
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


        // WHICH CAR IS AVAILIBLE FOR THE USER
        if(highestScore < 200){
            CCMenuItemImage *lock = [CCMenuItemImage itemFromNormalImage:@"lock.png" selectedImage:@"lock.png"];
            [sportcar setNormalImage:lock];
            [sportcar   setSelectedImage:lock];            
            sportcar.position = ccp(sportcar.position.x - 10, sportcar.position.y);            
        }
        
        if(highestScore < 400){
            CCMenuItemImage *lock = [CCMenuItemImage itemFromNormalImage:@"lock.png" selectedImage:@"lock.png"];
            [jeep setNormalImage:lock];
            [jeep setSelectedImage:lock];
            jeep.position = ccp(jeep.position.x - 10, jeep.position.y);            
        }
        
        if(highestScore < 800){
            CCMenuItemImage *lock = [CCMenuItemImage itemFromNormalImage:@"lock.png" selectedImage:@"lock.png"];
            [bat setNormalImage:lock];
            [bat setSelectedImage:lock];            
            bat.position = ccp(bat.position.x - 10, bat.position.y);            
        }
        
        if(highestScore < 1600){
            CCMenuItemImage *lock = [CCMenuItemImage itemFromNormalImage:@"lock.png" selectedImage:@"lock.png"];
            [army setNormalImage:lock];
            [army setSelectedImage:lock];
            army.position = ccp(army.position.x - 10, army.position.y);            
        }
        
        if(highestScore < 3200){
            CCMenuItemImage *lock = [CCMenuItemImage itemFromNormalImage:@"lock.png" selectedImage:@"lock.png"];
            [dream setNormalImage:lock];
            [dream setSelectedImage:lock];
            dream.position = ccp(dream.position.x - 10, dream.position.y);
        }
        
        menu = [CCMenu menuWithItems:play, greencar, sportcar, jeep, bat, army, dream, back, nil];
        menu.position = ccp(0, 0);
        [self addChild:glow];
        [self addChild:menu];
    }
    return self;
}

/* backButtonClicked:(id)sender
 * 
 * go back to menu.
 */

-(void) backButtonClicked:(id)sender
{
    [SceneManager goMenu];
}

/* startGame:(id)sender
 *
 * starts the game
 */

-(void) startGame:(id)sender
{
    [[Game sharedGame]resetGame];
    [SceneManager goGame];
}


/* changeCarColor:(id)sender
 *
 * if the user is good enough to use the clicked car they will be able to.
 *
 */

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
            if(highestScore > 800){
                [Game sharedGame].carColor = 3;
                glow.position = bat.position;
            }
            break;
        case 4:
            if(highestScore > 1600){
                [Game sharedGame].carColor = 4;
                glow.position = army.position;
            }
            break;
        case 5:
            if(highestScore > 3200){    
                [Game sharedGame].carColor = 5;
                glow.position = dream.position;
            }
            break;                
        default:
            break;
    }
}

- (void)dealloc {
    [super dealloc];
}

@end
