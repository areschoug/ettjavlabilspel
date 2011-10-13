#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "SimpleAudioEngine.h"
#import "CDAudioManager.h"
#import "CocosDenshion.h"

@interface Car : CCSprite {
    CGPoint carPosition;
    NSString *spriteImage;
}

@property CGPoint carPosition;
@property(nonatomic,retain) NSString *spriteImage;

-(void) moveX:(float)accX moveY:(float)accY;
-(float)scoreMultiplier;
@end
