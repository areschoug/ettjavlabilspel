#import "Car.h"

@implementation Car

@synthesize carPosition;
@synthesize spriteImage;

-(void) moveX:(float)accX moveY:(float)accY{
    accY += 0.55;
    
    //MOVEMENT
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    
    int width = [self boundingBox].size.width;
    int height = [self boundingBox].size.height;
    
    int newPosX = self.position.x+(accX*100);
    int newPosY = self.position.y+((accY)*100);
    
    int donePosX;
    int donePosY;


    
    if(-0.05 < accX && 0.05 > accX){
        accX = 0;
    }
    
    
    if(-0.05 < accY && accY < 0.05){
        accY=0;
    }
    
    
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
    
    [self runAction:[CCMoveTo actionWithDuration:1/60 position:ccp(donePosX, donePosY)]];
    
    //ROTATION
    float carRotation;
    
    if (accX > 0.1 || accX < -0.1) {
        carRotation = self.rotation + (accX * 10);
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
    NSLog(@"carRotation - %f", carRotation);
    [self runAction:[CCRotateTo actionWithDuration:1/10 angle:carRotation]];    

}

-(float)scoreMultiplier
{
    //CGSize screenSize = [CCDirector sharedDirector].winSize;
    
    //int feilds = (screenSize.height/5)/64;
    
    //int carPosito
    
    //switch(self.position.y)
    
    
    return 0.2;
}

-(void)dealloc
{
    NSLog(@"CAR DEALOC - %p",self);
    [spriteImage release];
    [super dealloc];

}
@end
