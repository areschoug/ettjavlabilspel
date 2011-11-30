//
//  HighScoreLayer.h
//  ettjavlabilspel
//
//  Created by Andreas Areschoug.
//
//  The highscore scene shows the highscore. 

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SceneManager.h"

@interface HighScoreLayer : CCLayer {
    NSMutableData *responsData;
    CCLabelTTF *loading;
}
@end
