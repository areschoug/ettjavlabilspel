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
#import "Invincible.h"
#import "Small.h"
#import "Gun.h"
#import "Bullet.h"
#import "Slow.h"
#import "Fast.h"

@interface Game : CCNode
{
    //STATE
    @public int gameSpeed;
    @public int currentScore;
    @public int carColor;
    @public int state;
    @public int stateTimer;    
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
    @public CGPoint inviciblePosition;
    @public CGPoint smallPosition;
    @public CGPoint gunPosition;
    @public CGPoint bulletPosition;
    @public CGPoint fastPosition;
    @public CGPoint slowPosition;
}

//STATE
@property(readwrite,assign) int gameSpeed;
@property(readwrite,assign) int currentScore;
@property(readwrite,assign) int carColor;
@property(readwrite,assign) int state;
@property(readwrite,assign) int stateTimer;
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
@property(readwrite,assign) CGPoint inviciblePosition;;
@property(readwrite,assign) CGPoint smallPosition;
@property(readwrite,assign) CGPoint gunPosition;
@property(readwrite,assign) CGPoint bulletPosition;
@property(readwrite,assign) CGPoint fastPosition;
@property(readwrite,assign) CGPoint slowPosition;


+(Game*)sharedGame;
-(void)resetGame;
-(void)startGame;
-(int)highestScore:(NSArray *)highScore;
@end
