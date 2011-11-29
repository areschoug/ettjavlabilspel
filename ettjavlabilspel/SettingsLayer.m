//
//  SettingsLayer.m
//  ettjavlabilspel
//
//  Created by Andreas Areschoug.
//

#import "SettingsLayer.h"


@implementation SettingsLayer


- (id)init {
    self = [super init];
    if (self) {
        
        background = [[CCSprite alloc] initWithFile:@"cityroad.png"];
        background.position = ccp(160, 240);
        [self addChild:background];
        [background release];

        
        CCMenu *menu;
        music = [CCMenuItemImage itemFromNormalImage:@"sound-music1.png" selectedImage:@"sound-music1.png" target:self selector:@selector(musicButtonClicked:)];
        music.position = ccp(160, 300);

        sfx = [CCMenuItemImage itemFromNormalImage:@"sound-sfx1.png" selectedImage:@"sound-sfx1.png" target:self selector:@selector(sfxButtonClicked:)];
        sfx.position = ccp(160, 180);
        
        [self checkMusic];
        [self checkSfx];
                
        CCMenuItemImage *back = [CCMenuItemImage itemFromNormalImage:@"back-button1.png" selectedImage:@"back-button2.png" target:self selector:@selector(backButtonClicked:)];
        back.position = ccp(250, 420);
        
        menu = [CCMenu menuWithItems: music, sfx, back, nil];

        menu.position = ccp(0, 0);
        [self addChild:menu];
    }
    return self;
}

-(void)musicButtonClicked:(id)sender
{
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"music"]){
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"menu_music.mp3"];
        [Game sharedGame].musicPlaying = YES;
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"music"];        
    }else{
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        [Game sharedGame].musicPlaying = NO;
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"music"];        
    }
    
    [self checkMusic];
}

-(void)sfxButtonClicked:(id)sender
{
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"muteSfx"]){
        [[SimpleAudioEngine sharedEngine] setEffectsVolume:1];
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"muteSfx"];
    } else {
        [[SimpleAudioEngine sharedEngine] setEffectsVolume:0];
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"muteSfx"];
    }
    
    [self checkSfx];
}

-(void) backButtonClicked:(id)sender
{
    [SceneManager goMenu];
}

-(void)checkMusic
{
    NSString *musicImage;
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"music"])
        musicImage = @"sound-music2.png";
    else
        musicImage = @"sound-music1.png";
    
    
    CCMenuItemImage *musicButton = [CCMenuItemImage itemFromNormalImage:musicImage selectedImage:musicImage];
    [music setNormalImage:musicButton];
}

-(void) checkSfx
{
    NSString *sfxImage;
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"muteSfx"])
        sfxImage = @"sound-sfx2.png";
    else
        sfxImage = @"sound-sfx1.png";
    
    CCMenuItemImage *sfxButton = [CCMenuItemImage itemFromNormalImage:sfxImage selectedImage:sfxImage];
    [sfx setNormalImage:sfxButton];
}

- (void)dealloc {
    [super dealloc];
}

@end
