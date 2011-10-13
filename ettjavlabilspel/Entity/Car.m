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
    
    int oldPosX = self.position.x;
    int oldPosY = self.position.y;
    
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
    
    NSLog(@"%i < %i",oldPosX, donePosX);
    
    if (oldPosX+10 < donePosX ||oldPosX-10 > donePosX ) {
        NSLog(@"DEG");
        [[SimpleAudioEngine sharedEngine] playEffect:@"tirebreak.mp3"];
    }
    
    if (oldPosY+10 < donePosY){
        NSLog(@"KLE");
        [[SimpleAudioEngine sharedEngine] playEffect:@"accelerate.mp3"];    
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
    [self runAction:[CCRotateTo actionWithDuration:1/10 angle:carRotation]];    

}

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
    NSLog(@"CAR DEALOC - %p",self);
    [spriteImage release];
    [super dealloc];

}
@end
