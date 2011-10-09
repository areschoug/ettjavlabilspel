//
//  HelloWorldLayer.m
//  ettjavlabilspel
//
//  Created by Andreas Areschoug.
//
//  The main menu class that needs a rename.
//
//  TODO:
//  - implement nice graphics 
//  - setting btn
//  - rename this file to main something



// Import the interfaces
#import "HelloWorldLayer.h"

@implementation HelloWorldLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
        
        CCMenu *menu;
        
        
        CCMenuItemImage *newGameButton = [CCMenuItemImage itemFromNormalImage:@"menu-newgame.png" selectedImage:@"menu-newgame.png" target:self selector:@selector(menuItemClicked:)];
        
        CCMenuItemImage *continueButton = [CCMenuItemImage itemFromNormalImage:@"menu-continue.png" selectedImage:@"menu-continue.png" target:self selector:@selector(menuItemClicked:)];
        
        CCMenuItemImage *highScoreButton = [CCMenuItemImage itemFromNormalImage:@"menu-highscore.png" selectedImage:@"menu-highscore.png" target:self selector:@selector(menuItemClicked:)];
        
        [newGameButton setTag:1];
        [continueButton setTag:2];
        [highScoreButton setTag:3];
        
        newGameButton.position = ccp(0, 200);
        continueButton.position = ccp(0, 100);
        highScoreButton.position = ccp(0, 0);
        
        if([Game sharedGame].gameSpeed > 1){
            menu = [CCMenu menuWithItems:continueButton,newGameButton,highScoreButton, nil];
        }else{
            menu = [CCMenu menuWithItems:newGameButton,highScoreButton, nil];
            highScoreButton.position = ccp(0, highScoreButton.position.y + 100);
        }
        [self addChild:menu];

        [[SimpleAudioEngine sharedEngine]playBackgroundMusic:@"menu_music.mp3"];


	}
	return self;
}

-(void) menuItemClicked:(id)sender
{
    switch ([sender tag]) {
        case 1:
            [[Game sharedGame]resetGame];
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[GameLayer node]]];
            break;
        case 2:
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[GameLayer node]]];
            break;
        case 3:
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[HighScoreScene node]]];
            break;
        default:
            break;
    }
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
    NSLog(@"DELLOC - HELLO LAYER");
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)

	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
