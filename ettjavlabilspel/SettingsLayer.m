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
        
        background = [[CCSprite alloc] initWithFile:@"mainscreen-background.png"];
        background.position = ccp(160, 240);
        [self addChild:background];
        [background release];
        
        CCMenu *menu;

        CCLabelTTF *musicLabel = [CCLabelTTF labelWithString:[self checkMusic] fontName:@"Helvetica" fontSize:24];
        music = [CCMenuItemLabel itemWithLabel:musicLabel target:self selector:@selector(musicButtonClicked:)];
        music.position = ccp(160, 260);
        
        CCLabelTTF *sfxLabel = [CCLabelTTF labelWithString:[self checkSfx] fontName:@"Helvetica" fontSize:24];
        sfx = [CCMenuItemLabel itemWithLabel:sfxLabel target:self selector:@selector(sfxButtonClicked:)];
        sfx.position = ccp(160, 220);
        
        CCMenuItemImage *back = [CCMenuItemImage itemFromNormalImage:@"back-button1.png" selectedImage:@"back-button2.png" target:self selector:@selector(backButtonClicked:)];
        back.position = ccp(250, 420);
        
        menu = [CCMenu menuWithItems:music,sfx,back, nil];

        menu.position = ccp(0, 0);
        [self addChild:menu];
    }
    return self;
}

-(void)musicButtonClicked:(id)sender
{
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"mute"])
    {
        [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:1];
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"mute"];
    }
    else
    {
        [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:0];
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"mute"];
    }
    
    [music setString:[self checkMusic]];
}

-(void)sfxButtonClicked:(id)sender
{
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"muteSfx"])
    {
        [[SimpleAudioEngine sharedEngine] setEffectsVolume:1];
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"muteSfx"];
    }
    else
    {
        [[SimpleAudioEngine sharedEngine] setEffectsVolume:0];
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"muteSfx"];
    }
    
    [sfx setString:[self checkSfx]];
}

-(void) backButtonClicked:(id)sender
{
    [SceneManager goMenu];
}

-(NSString *)checkMusic
{
    NSString *musicString;    
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"mute"])
        musicString = @"Music: Off";
    else
        musicString = @"Music: On";
    
    return musicString;
}

-(NSString *) checkSfx
{
    NSString *sfxString;
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"muteSfx"])
        sfxString = @"Sfx: Off";
    else
        sfxString = @"Sfx: On";
    
    return sfxString;
}

- (void)dealloc {
    [super dealloc];
}

@end
