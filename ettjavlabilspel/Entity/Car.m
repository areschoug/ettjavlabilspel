#import "Car.h"

@implementation Car

@synthesize spriteImage;

-(void) moveX:(float)accX moveY:(float)accY drunk:(BOOL)drunk{
    accY += 0.55;
    
    //MOVEMENT
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    
    int width = [self boundingBox].size.width;
    int height = [self boundingBox].size.height;
    
    int oldPosY = self.position.y;

    int donePosX;
    int donePosY;

    
    if(-0.05 < accX && 0.05 > accX){
        accX = 0;
    }
    
    if(-0.02 < accY && accY < 0.02){
        accY = 0;
    }
    
    int newPosX = self.position.x+(accX*35);
    int newPosY = self.position.y+((accY)*50);
    
    if(newPosX > screenSize.width-width/2){
        donePosX = screenSize.width-width/2;
    }else if(newPosX < 0+width/2){
        donePosX = 0+width/2;
    }else{
        donePosX = newPosX;
    }
    
    if(newPosY > screenSize.height-height/2){
        donePosY = screenSize.height - height/2;
    }else if(newPosY < 0 + height/2){
        donePosY = 0 + height/2;
    }else{
        donePosY = newPosY;
    }
    
    if(audioTicker < 0){
        if (oldPosY-15 > donePosY  ) {
            [[SimpleAudioEngine sharedEngine] playEffect:@"tirebreak.mp3"];
            audioTicker = 50;
        }
    
        if (oldPosY+15 < donePosY){
            [[SimpleAudioEngine sharedEngine] playEffect:@"accelerate.mp3"];    
            audioTicker = 50;
        }
    }
    
    audioTicker--;

    [self runAction:[CCMoveTo actionWithDuration:1/60 position:ccp(donePosX, donePosY)]];
    
    //IF DRUNK DO NOT ROTATE
    if (!drunk){
    //ROTATION
        float carRotation = 0;
    
        if (accX > 0.1 || accX < -0.1) {
            carRotation = self.rotation + (accX * 3);
            if(carRotation < 0 && accX > 0.2){
                carRotation = 0;
            }else if(carRotation > 0 && accX < -0.2){
                carRotation = 0;
            }
        }
    
        if ((accX < 0.1 && accX > -0.1)||donePosX < width || donePosX > 320-width) {
            if (self.rotation == 0) {
                carRotation = 0;
            }else if(self.rotation > 0){
                carRotation = self.rotation - 5;
                if (carRotation < 0) {
                    carRotation = 0;
                }
            }else{
                carRotation = self.rotation + 5;
                if(carRotation > 0){
                    carRotation = 0;
                }
            }
        }
    
        [self runAction:[CCRotateTo actionWithDuration:1/60 angle:carRotation]];    
    }
}

/*scoreMultiplier
 * 
 * depending on what position the car has the score intake increases.
 */

-(float)scoreMultiplier
{
    int carFeildPosition = self.position.y/5;
    float result;
    
    if (carFeildPosition < 20) {
        result = 1.0;
    }else if(carFeildPosition >= 20 && carFeildPosition < 40){
        result = 1.2;
    }else if(carFeildPosition >= 40 && carFeildPosition < 60){
        result = 1.4;
    }else if(carFeildPosition >= 60 && carFeildPosition < 80){
        result = 1.6;
    }else if(carFeildPosition >= 80){
        result = 1.8;
    }
    
    return result;
}

-(void)dealloc
{
    [spriteImage release];
    [super dealloc];

}
@end
