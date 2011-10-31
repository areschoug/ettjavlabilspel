//
//  MenuLayer.h
//  ettjavlabilspel
//
//  Created by Andreas Areschoug.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SceneManager.h"


#import "SimpleAudioEngine.h"
#import "CDAudioManager.h"
#import "CocosDenshion.h"

@interface MenuLayer : CCLayer
{
    
    CCSprite *background;
    CCSprite *backgroundCar;
    CCTexture2D *burningCarTexture1;
    CCTexture2D *burningCarTexture2;
    int texture;
}

-(void)onMenuItemClicked:(id)sender;
-(void)burningCar:(ccTime)dt;
@end
