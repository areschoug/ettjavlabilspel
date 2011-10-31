//
//  InstructionsLayer.h
//  ettjavlabilspel
//
//  Created by Andreas Areschoug.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SceneManager.h"

@interface InstructionsLayer : CCLayer {
    CCSprite *background;
}

-(void) backButtonClicked:(id)sender;

@end
