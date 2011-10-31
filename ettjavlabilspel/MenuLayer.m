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
    background = [[CCSprite alloc] initWithFile:@"mainscreen-background.png"];
    background.position = ccp(160, 240);
    [self addChild:background];

    burningCarTexture1 = [[CCTexture2D alloc]initWithImage:[UIImage imageNamed:@"mainscreen-car1.png"]];
    burningCarTexture2 = [[CCTexture2D alloc] initWithImage:[UIImage imageNamed:@"mainscreen-car2.png"]];

    texture = 1;
    
    backgroundCar = [[CCSprite alloc] initWithFile:@"mainscreen-car1.png"];
    [backgroundCar setTexture:burningCarTexture1];
    backgroundCar.position = ccp(160, 150);
    [self addChild:backgroundCar];
    
    CCMenu *menu;
    
    CCMenuItemImage *logo = [CCMenuItemImage itemFromNormalImage:@"mainscreen-logo.png" selectedImage:@"mainscreen-logo.png"];
    CCMenuItemImage *newGameButton = [CCMenuItemImage itemFromNormalImage:@"mainscreen-newgame1.png" selectedImage:@"mainscreen-newgame2.png" target:self selector:@selector(onMenuItemClicked:)];
    CCMenuItemImage *highScoreButton = [CCMenuItemImage itemFromNormalImage:@"mainscreen-highscore1.png" selectedImage:@"mainscreen-highscore2.png" target:self selector:@selector(onMenuItemClicked:)];
    CCMenuItemImage *settingsButton = [CCMenuItemImage itemFromNormalImage:@"mainscreen-settings1.png" selectedImage:@"mainscreen-settings2.png" target:self selector:@selector(onMenuItemClicked:)];
    CCMenuItemImage *instructionsButton = [CCMenuItemImage itemFromNormalImage:@"mainscreen-instructions1.png" selectedImage:@"mainscreen-instructions2.png" target:self selector:@selector(onMenuItemClicked:)];
    [newGameButton setTag:1];
    [highScoreButton setTag:2];
    [settingsButton setTag:3];
    [instructionsButton setTag:4];
    
    logo.position = ccp(160, 400);
    newGameButton.position = ccp(135, 300);
    highScoreButton.position = ccp(220, 235);
    settingsButton.position = ccp(235, 170);
    instructionsButton.position = ccp(90, 200);

    menu = [CCMenu menuWithItems:logo,highScoreButton,newGameButton,settingsButton,instructionsButton, nil];
    menu.position = ccp(0, 0);
    
    //TÖM HIGHSCORE ARRAYEN
    /*
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:100];
    [[NSUserDefaults standardUserDefaults]setObject:array forKey:@"highScoreArray"];
     */    
    [self addChild:menu];
    
    if(![Game sharedGame].music)
    {
        [[SimpleAudioEngine sharedEngine]playBackgroundMusic:@"menu_music.mp3"];
        [Game sharedGame].music = YES;
    }

    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"mute"])
        [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:0];
    else
        [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:1];
    
    [self schedule:@selector(burningCar:) interval:.3];
    
    return self;
}

-(void)burningCar:(ccTime)dt
{
    if(texture == 1){
        texture = 2;
        [backgroundCar setTexture:burningCarTexture1];
    }else{
        texture = 1;
        [backgroundCar setTexture:burningCarTexture2];
    }
    
}

-(void)onMenuItemClicked:(id)sender
{
    switch ([sender tag]) {
        case 1:
            [SceneManager goCarSelect];
            break;
        case 2:
            [SceneManager goHighScore];
            break;
        case 3:
            [SceneManager goSettings];
            break;
        case 4:
            [SceneManager goInstructions];
            break;
        default:
            break;
    }
}

- (void)dealloc {
    [background release];
    [backgroundCar release];
    [super dealloc];
}

@end
