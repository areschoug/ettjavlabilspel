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
//  - global highscore and your position in the world highscore
//  - possible your friends highscore
//  - possible post score to twitter,facebook or something.

#import "HighScoreLayer.h"


@implementation HighScoreLayer

-(id)init
{
    if((self=[super init])){

        background = [[CCSprite alloc] initWithFile:@"mainscreen-background.png"];
        background.position = ccp(160, 240);
        [self addChild:background];
        [background release];
        
        NSArray *highScores,*sorted;
        highScores = [[NSUserDefaults standardUserDefaults]arrayForKey:@"highScoreArray"];
        sorted = [highScores sortedArrayUsingSelector:@selector(compare:)];
        int distance = 400;
        
        if([sorted count] < 6){
            for (int i = ([sorted count] - 1); [sorted count] > i; i--) {
                distance -= 50;
                CCLabelTTF *scoreLable = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@",[sorted objectAtIndex:i]] fontName:@"helvetica" fontSize:22];
                scoreLable.position = ccp(160, (distance));
                [self addChild:scoreLable];
               
            }
        } else {
            for (int i = ([sorted count] - 1); ([sorted count] - 6) < i; i--) {
                distance -= 50;
                CCLabelTTF *scoreLable = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@",[sorted objectAtIndex:i]] fontName:@"helvetica" fontSize:22];
                scoreLable.position = ccp(160, (distance));
                [self addChild:scoreLable];
            }
        }
        
        CCMenu *menu;
        
        CCMenuItemImage *backButton = [CCMenuItemImage itemFromNormalImage:@"back-button1.png" selectedImage:@"back-button2.png" target:self selector:@selector(backButtonClicked:)];
        backButton.position = ccp(250, 420);        
        menu = [CCMenu menuWithItems:backButton, nil];
        menu.position = ccp(0, 0);;

        [self addChild:menu];
    }
    return self;
}

-(void)backButtonClicked:(id) sender{  
    [SceneManager goMenu];
}

- (void)dealloc {
    [super dealloc];
}

@end
