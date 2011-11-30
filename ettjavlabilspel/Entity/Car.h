//
// Entity.h
// ettjavlabilspel
//
// Created by Andreas Areschoug.
//
// Car class.

#import "cocos2d.h"

#import "SimpleAudioEngine.h"
#import "CDAudioManager.h"
#import "CocosDenshion.h"


@interface Car : CCSprite {
    NSString *spriteImage;
    int audioTicker;
}

@property(nonatomic,retain) NSString *spriteImage;

-(void) moveX:(float)accX moveY:(float)accY drunk:(BOOL)drunk;
-(float)scoreMultiplier;
@end
