//
//  MovingObstacle.h
//  ettjavlabilspel
//
//  Created by Andreas Areschoug on 2011-11-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Entity.h"

@interface MovingObstacle : Entity {
    
}

-(void)movingObjectGoX:(int)distanceX movingObjectGoY:(int)distanceY;
-(CGPoint)getMovingStartPositions;

@end
