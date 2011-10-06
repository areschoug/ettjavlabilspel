//
//  PauseLayer.m
//  AccelerometerTest
//
//  Created by Andreas Areschoug on 2011-10-06.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

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
