//
//  MenuLayer.m
//  ettjavlabilspel
//
//  Created by Andreas Areschoug.
//

#import "MenuLayer.h"

@implementation MenuLayer

- (id)init
{
    NSLog(@"MenuLayer init");
    self = [super init];
    
    CCMenu *menu;
        
    CCMenuItemImage *newGameButton = [CCMenuItemImage itemFromNormalImage:@"menu-newgame.png" selectedImage:@"menu-newgame.png" target:self selector:@selector(onMenuItemClicked:)];
    CCMenuItemImage *highScoreButton = [CCMenuItemImage itemFromNormalImage:@"menu-highscore.png" selectedImage:@"menu-highscore.png" target:self selector:@selector(onMenuItemClicked:)];
    CCMenuItemImage *settingsButton = [CCMenuItemImage itemFromNormalImage:@"menu-settings.png" selectedImage:@"menu-highscore.png" target:self selector:@selector(onMenuItemClicked:)];
    CCMenuItemImage *instructionsButton = [CCMenuItemImage itemFromNormalImage:@"menu-instructions.png" selectedImage:@"menu-highscore.png" target:self selector:@selector(onMenuItemClicked:)];
    [newGameButton setTag:1];
    [highScoreButton setTag:2];
    [settingsButton setTag:3];
    [instructionsButton setTag:4];
    
    newGameButton.position = ccp(0, 200);
    highScoreButton.position = ccp(0, 100);
    settingsButton.position = ccp(0, 0);
    instructionsButton.position = ccp(0, -100);

    menu = [CCMenu menuWithItems:newGameButton,highScoreButton,settingsButton,instructionsButton, nil];

    [self addChild:menu];
    
    [[SimpleAudioEngine sharedEngine]playBackgroundMusic:@"menu_music.mp3"];
    
    return self;
}

-(void)onMenuItemClicked:(id)sender
{
    switch ([sender tag]) {
        case 1:
            [[Game sharedGame]resetGame];
            [SceneManager goGame];
            break;
        case 2:
            [SceneManager goHighScore];
            break;
        case 3:
            break;
        case 4:
            break;
        default:
            break;
    }
}


@end
