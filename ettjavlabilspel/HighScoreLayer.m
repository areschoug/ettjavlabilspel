//
//  HighScoreLayer.m
//  ettjavlabilspel
//
//  Created by Andreas Areschoug.
//
//  The highscore scene. Currently the highscore only showes top five on your the handset.
//
//  TODO:
//  - implement nice graphics 
//  - less than five highscore (fix)
//  - global highscore and your position in the world highscore
//  - possible your friends highscore
//  - possible post score to twitter,facebook or something.

#import "HighScoreLayer.h"


@implementation HighScoreLayer

-(id)init
{
    if((self=[super init])){

        NSArray *highScores,*sorted;
        highScores = [[NSUserDefaults standardUserDefaults]arrayForKey:@"highScoreArray"];
        sorted = [highScores sortedArrayUsingSelector:@selector(compare:)];
        int distance = 400;
        
        for (int i = ([sorted count] - 1); ([sorted count]-6) < i; i--) {
            distance -= 50;
            
            CCLabelAtlas *scoreLabel = [CCLabelAtlas labelWithString:[NSString stringWithFormat:@"%@", [sorted objectAtIndex:i]] charMapFile:@"fps_images.png" itemWidth:16 itemHeight:48 startCharMap:'.'];
            scoreLabel.position = ccp(15, (distance));
            [self addChild:scoreLabel];
        }
        
        
        CCMenu *menu;
        
        CCMenuItemImage *backButton = [CCMenuItemImage itemFromNormalImage:@"pause.png" selectedImage:@"pause.png" target:self selector:@selector(backButtonClicked:)];
                
        menu = [CCMenu menuWithItems:backButton, nil];
        menu.position = ccp(270, 455);

        [self addChild:menu];
    }
    return self;
}

-(void)backButtonClicked:(id) sender{  
    [SceneManager goMenu];
}

-(void)dealloc{
    NSLog(@"DEALLOC - HIGH SCORE SCENE ENDED %@",self);
    [super dealloc];
}

@end
