//
//  Game.h
//  AccelerometerTest
//
//  Created by Andreas Areschoug on 2011-09-20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Hole.h"
#import "DestroyedCar.h"
#import "Alcohol.h"

@interface Game : CCNode
{
    //STATE
    @public int gameSpeed;
    @public BOOL drunk;
    @public int currentScore;
    @public BOOL music;
    
    //POSITION
    @public CGPoint carPosition;
    @public CGPoint holePosition;
    @public CGPoint bottlePosition;
    @public CGPoint destroyedCarPosition;
}

//STATE
@property(readwrite,assign) int gameSpeed;
@property(readwrite,assign) BOOL drunk;
@property(readwrite,assign) int currentScore;
@property(readwrite,assign) BOOL music;

//POSITION
@property(readwrite,assign) CGPoint carPosition;
@property(readwrite,assign) CGPoint holePosition;
@property(readwrite,assign) CGPoint bottlePosition;
@property(readwrite,assign) CGPoint destroyedCarPosition;


+(Game*)sharedGame;
-(void)resetGame;
-(int)highestScore:(NSArray *)highScore;
@end
