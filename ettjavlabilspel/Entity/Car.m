#import "Car.h"

@implementation Car

@synthesize carPosition;
@synthesize spriteImage;

-(void) moveX:(float)accX moveY:(float)accY{

    accY += 0.55;
    
    if(-0.05 < accX && 0.05 > accX){
        accX = 0;
    }
    
    
    if(-0.05 < accY && accY < 0.05){
        accY=0;
    }
    
    int width = [self boundingBox].size.width;
    int height = [self boundingBox].size.height;
    
    int newPosX = self.position.x+(accX*100);
    int newPosY = self.position.y+((accY)*100);

    int donePosX;
    int donePosY;
    
    if(newPosX > 320-width/2){
        donePosX = 320-width/2;
    }else if(newPosX < 0+width/2){
        donePosX = 0+width/2;
    }else{
        donePosX = newPosX;
    }
    
    if(newPosY > 480-height/2){
        donePosY = 480 - height/2;
    }else if(newPosY < 0 + height/2){
        donePosY = 0 + height/2;
    }else{
        donePosY = newPosY;
    }
    
    
    
    [self runAction:[CCMoveTo actionWithDuration:1/60 position:ccp(donePosX, donePosY)]];
}

-(void)dealloc
{
    NSLog(@"CAR DEALOC - %p",self);
    [spriteImage release];
    [super dealloc];

}
@end
