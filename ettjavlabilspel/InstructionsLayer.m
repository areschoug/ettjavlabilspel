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
        
        
        
        NSString *text = [NSString stringWithFormat:@"The game is played only with the accelerometer of your smarthphone.\n\nAll you have to do is to let your car gas and tilt the phone to steer it.\n\nAvoid obstacles to not fail or pick up powerups to take advantage of special powers to benefit your drive.\n\nSurvive as long as you can to score the most points!"];
        
        CCLabelTTF *textLable = [CCLabelTTF labelWithString:text dimensions:CGSizeMake(300.0f, 350.0f) alignment:UITextAlignmentLeft fontName:@"helvetica" fontSize:18];
        textLable.position = ccp(160, 200);
        [self addChild:textLable];
        
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
