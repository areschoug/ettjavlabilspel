//
//  PauseSettingsLayer.m
//  ettjavlabilspel
//
//  Created by Andreas Areschoug on 2011-10-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PauseSettingsLayer.h"


@implementation PauseSettingsLayer

- (id)init {
    self = [super init];
    if (self) {
        
        background = [[CCSprite alloc]initWithFile:@"road.png"];
        background.position = [Game sharedGame].backgroundPosition;
        
        CCMenu *menu;
        
        CCLabelTTF *musicLabel = [CCLabelTTF labelWithString:[self checkMusic] fontName:@"Helvetica" fontSize:24];
        music = [CCMenuItemLabel itemWithLabel:musicLabel target:self selector:@selector(musicButtonClicked:)];
        music.position = ccp(0, 100);
        
        CCLabelTTF *sfxLabel = [CCLabelTTF labelWithString:[self checkSfx] fontName:@"Helvetica" fontSize:24];
        sfx = [CCMenuItemLabel itemWithLabel:sfxLabel target:self selector:@selector(sfxButtonClicked:)];
        sfx.position = ccp(0, 0);
        
        CCLabelTTF *backLabel = [CCLabelTTF labelWithString:@"Back" fontName:@"Helvetica" fontSize:24];
        CCMenuItemLabel *back = [CCMenuItemLabel itemWithLabel:backLabel target:self selector:@selector(backButtonClicked:)];
        back.position = ccp(100, 200);
        
        menu = [CCMenu menuWithItems:music,sfx,back, nil];

        [self addChild:background];
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
    [SceneManager goPaus];
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



@end
