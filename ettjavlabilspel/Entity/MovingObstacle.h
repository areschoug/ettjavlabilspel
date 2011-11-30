//
// MovingObstacle.h
// ettjavlabilspel
//
// Created by Andreas Areschoug.
//
// Class for moving obstacles

#import "Entity.h"

@interface MovingObstacle : Entity {
    
}

-(void)movingObjectGoX:(int)distanceX movingObjectGoY:(int)distanceY;
-(CGPoint)getMovingStartPositions;

@end
