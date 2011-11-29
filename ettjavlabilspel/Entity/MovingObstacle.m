//
//  MovingObstacle.m
//  ettjavlabilspel
//
//  Created by Andreas Areschoug on 2011-11-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MovingObstacle.h"


@implementation MovingObstacle

-(MovingObstacle *) init{
    self = [super init];
    if(self != nil){
        NSLog(@"init Hole - %p",self);
        [startingPoints addObject:@"100"];
        [startingPoints addObject:@"200"];
        [startingPoints addObject:@"300"];
        [startingPoints addObject:@"400"];
        startRate = 1000;
    }
    return self;
}

-(void)movingObjectGoX:(int)distanceX movingObjectGoY:(int)distanceY
{
    if(self.position.x >= startRate)
        self.position = [self getMovingStartPositions];
    
    [self goX:distanceX goY:distanceY];
}

-(CGPoint)getMovingStartPositions
{
    int x = -(self.contentSize.width/2+10);
    int y = [[startingPoints objectAtIndex:[self getRandomNumber:0 to:([startingPoints count]-1)]]intValue];
    return ccp(x, y);
}



-(void)dealloc{
    NSLog(@"DEALLOC HOLE - %p",self);
    [super dealloc];
}

@end
