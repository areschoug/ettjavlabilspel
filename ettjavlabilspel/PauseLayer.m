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
//  - Pretty much everything. You can do it

#import "PauseLayer.h"


@implementation PauseLayer

-(id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    CCMenuItemImage *pausButton = [CCMenuItemImage itemFromNormalImage:@"pause.png" selectedImage:@"pause.png" target:self selector:@selector(menuItemClicked:)];
    menu = [CCMenu menuWithItems:pausButton, nil];
    menu.position = ccp(170, 455);
    
    [self addChild:menu];
    
    return self;
}

-(void)menuItemClicked:(id)sender{
    NSLog(@"heeeyyeyeye");
}

@end
