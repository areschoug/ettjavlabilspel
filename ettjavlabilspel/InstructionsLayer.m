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
        
        CCMenu *menu;
        
        CCLabelTTF *backLabel = [CCLabelTTF labelWithString:@"Back" fontName:@"Helvetica" fontSize:24];
        CCMenuItemLabel *back = [CCMenuItemLabel itemWithLabel:backLabel target:self selector:@selector(backButtonClicked:)];
        back.position = ccp(100, 200);
        
        menu = [CCMenu menuWithItems:back, nil];
        [self addChild:menu];
    }
    return self;
}

-(void) backButtonClicked:(id)sender
{
    [SceneManager goMenu];
}

@end
