//
//  GameOverScene.m
//  ettjavlabilspel
//
//  Created by Andreas Areschoug.
//
//  When the car crashed or w/e the run ends this scene will be shown
//
//  TODO:
//  - implement nice graphics 
//  - a play again button


#import "GameOverLayer.h"


@implementation GameOverLayer

+(CCScene *) scene
{
    CCScene *scene = [CCScene node];
    
    GameOverLayer *layer = [GameOverLayer node];
    
    [scene addChild:layer];
    
    return scene;
}

-(id)init
{
    if((self=[super init]))
    {
        [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
        //SAVE HIGHSCORE
        [self saveHighScore];
        
        //MENU
        CCMenu *menu;
        CCMenuItemImage *backButton = [CCMenuItemImage itemFromNormalImage:@"pause.png" selectedImage:@"pause.png" target:self selector:@selector(backButtonClicked:)];
        menu = [CCMenu menuWithItems:backButton, nil];
        menu.position = ccp(270, 455);
        
        //SCORELABLE
        CCLabelAtlas *scoreLabel = [CCLabelAtlas labelWithString:[NSString stringWithFormat:@"%i",[Game sharedGame].currentScore] charMapFile:@"fps_images.png" itemWidth:16 itemHeight:48 startCharMap:'.'];
        scoreLabel.position = ccp(160, 240);
        
        CCLabelAtlas *scoreLabel2 = [CCLabelAtlas labelWithString:[NSString stringWithFormat:@"%i",[[Game sharedGame]highestScore:[[NSUserDefaults standardUserDefaults]arrayForKey:@"highScoreArray"]]] charMapFile:@"fps_images.png" itemWidth:16 itemHeight:48 startCharMap:'.'];
        scoreLabel2.color = ccc3(250, 0, 0);
        scoreLabel2.position = ccp(160, 200);

        [scoreLabel setAnchorPoint:ccp(0.5f, 0.5f)];
        [scoreLabel2 setAnchorPoint:ccp(0.5f, 0.5f)];
        
        if([Game sharedGame].currentScore == [[Game sharedGame]highestScore:[[NSUserDefaults standardUserDefaults]arrayForKey:@"highScoreArray"]]){
            id action = [CCScaleBy actionWithDuration:0.3 scale:1.1];
            id action2 = [action reverse];
            id seq = [CCSequence actionOne:action two:action2];
            [scoreLabel2 runAction:[CCRepeatForever actionWithAction:seq]];
        }else{
            [self addChild:scoreLabel];
        }
        
        [self addChild:scoreLabel2];
        [self addChild:menu];
    }
    return self;
}

-(void)backButtonClicked:(id)sender
{
    [SceneManager goMenu];
}

-(void)saveHighScore
{
    int newScore = [Game sharedGame].currentScore;
    NSMutableArray *highScoreArray = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"highScoreArray"]];
    
    [highScoreArray addObject:[NSNumber numberWithInt:newScore]];

    [[NSUserDefaults standardUserDefaults]setObject:highScoreArray forKey:@"highScoreArray"];
    [highScoreArray release];
}

-(void)dealloc
{
    NSLog(@"DEALLOC - GAME OVER SCENE %@",self);
    
    [super dealloc];
}
@end
