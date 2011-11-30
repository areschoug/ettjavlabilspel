//
//  MovingObstacle.m
//  ettjavlabilspel
//
//  Created by Andreas Areschoug.
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

/* movingObjectGoX:(int)distanceX movingObjectGoY:(int)distanceY
 *
 * move the object and moves it back when its out of its startingRate
 *
 */
-(void)movingObjectGoX:(int)distanceX movingObjectGoY:(int)distanceY
{
    if(self.position.x >= startRate)
        self.position = [self getMovingStartPositions];
    
    [self goX:distanceX goY:distanceY];
}

/* getMovingStartPositions
 *
 * get a random start position
 *
 */
-(CGPoint)getMovingStartPositions
{
    int x = -(self.contentSize.width/2+10);
    int y = [[startingPoints objectAtIndex:[self getRandomNumber:0 to:([startingPoints count]-1)]]intValue];
    return ccp(x, y);
}

-(void)dealloc{
    [super dealloc];
}

@end
