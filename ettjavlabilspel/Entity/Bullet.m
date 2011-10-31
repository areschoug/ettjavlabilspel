//
//  Bullet.m
//  ettjavlabilspel
//
//  Created by Andreas Areschoug on 2011-10-29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Bullet.h"


@implementation Bullet

-(Bullet *)init{
    self = [super init];
    if (self != nil) {
        NSLog(@"init Bullet - %p",self);
    }
    return self;
}

-(void)objectGoX:(int)distanceX objectGoY:(int)distanceY car:(CGPoint)carPosition{
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    
    if(self.position.y >= screenSize.height + self.contentSize.height/2)
        self.position = carPosition;
    
    [self goX:distanceX goY:distanceY];
}

-(void)dealloc{
    NSLog(@"DEALLOC BULLET - %p",self);
    [super dealloc];
}

@end
