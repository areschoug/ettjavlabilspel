//
//  InstructionsLayer.m

//  ettjavlabilspel
//
//  Created by Andreas Areschoug.
//

#import "InstructionsLayer.h"


@implementation InstructionsLayer

- (id)init {
    self = [super init];
    if (self) {
        
        background = [[CCSprite alloc] initWithFile:@"mainscreen-background.png"];
        background.position = ccp(160, 240);
        [self addChild:background];
        [background release];
        
        CCMenu *menu;
        
        CCMenuItemImage *back = [CCMenuItemImage itemFromNormalImage:@"back-button1.png" selectedImage:@"back-button2.png" target:self selector:@selector(backButtonClicked:)];
        back.position = ccp(250, 420);
        
        menu = [CCMenu menuWithItems:back, nil];
        menu.position = ccp(0, 0);
        [self addChild:menu];
    }
    return self;
}

-(void) backButtonClicked:(id)sender
{
    [SceneManager goMenu];
}

- (void)dealloc {
    [super dealloc];
}

@end
