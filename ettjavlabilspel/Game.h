//
//  Game.h
//  ettjavlabilspel
//
//  Created by Andreas Areschoug.
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
    @public int currentScore;
    @public BOOL drunk;
    @public BOOL music;
    @public BOOL mute;
    @public BOOL sfx;
    @public BOOL started;
    
    //POSITION
    @public CGPoint backgroundPosition;
    @public CGPoint carPosition;
    @public CGPoint holePosition;
    @public CGPoint bottlePosition;
    @public CGPoint destroyedCarPosition;
}

//STATE
@property(readwrite,assign) int gameSpeed;
@property(readwrite,assign) int currentScore;
@property(readwrite,assign) BOOL drunk;
@property(readwrite,assign) BOOL music;
@property(readwrite,assign) BOOL mute;
@property(readwrite,assign) BOOL sfx;
@property(readwrite,assign) BOOL started;

//POSITION
@property(readwrite,assign) CGPoint backgroundPosition;
@property(readwrite,assign) CGPoint carPosition;
@property(readwrite,assign) CGPoint holePosition;
@property(readwrite,assign) CGPoint bottlePosition;
@property(readwrite,assign) CGPoint destroyedCarPosition;


+(Game*)sharedGame;
-(void)resetGame;
-(void)startGame;
-(int)highestScore:(NSArray *)highScore;
@end
