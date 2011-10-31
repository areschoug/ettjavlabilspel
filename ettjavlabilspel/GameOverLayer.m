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

-(id)init
{
    if((self=[super init]))
    {
        
        NSLog(@"Game over layer init");
        [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
        //SAVE HIGHSCORE
        [self saveHighScore];
        
        //MUSIC
        if(![Game sharedGame].music)
        {
            [[SimpleAudioEngine sharedEngine]playBackgroundMusic:@"menu_music.mp3"];
            [Game sharedGame].music = YES;
        }
        
        //BACKGROUND
        background = [[CCSprite alloc]initWithFile:@"road.png"];
        background.position = [Game sharedGame].backgroundPosition;
        [self addChild:background];
        
        //ENTITIES
        hole = [[CCSprite alloc]initWithFile:@"hinder3.png"];
        hole.position = [Game sharedGame].holePosition;
        [self addChild:hole];
        
        destroyedCar = [[CCSprite alloc]initWithFile:@"dubbelhinder.png"];
        destroyedCar.position = [Game sharedGame].destroyedCarPosition;
        [self addChild:destroyedCar];

        car = [[CCSprite alloc]initWithFile:@"car3-dead.png"];
        car.position = [Game sharedGame].carPosition;
        [self addChild:car];
        
        
        //MENU
        CCMenu *menu;
        
        CCMenuItemImage *backButton = [CCMenuItemImage itemFromNormalImage:@"back-button1.png" selectedImage:@"back-button2.png" target:self selector:@selector(backButtonClicked:)];
        backButton.position = ccp(250, 420);        
        

        CCMenuItemImage *retryButton = [CCMenuItemImage itemFromNormalImage:@"retry-button1.png" selectedImage:@"retry-button2.png" target:self selector:@selector(retryButtonClicked:)];
        retryButton.position = ccp(160,75);
        
        menu = [CCMenu menuWithItems:retryButton,backButton, nil];
        menu.position = ccp(0, 0);

        //SCORELABLE


        CCLabelTTF *scoreLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i",[Game sharedGame].currentScore] fontName:@"helvetica" fontSize:22];
        
        scoreLabel.position = ccp(160, 240);
        
        CCLabelTTF *scoreLabel2 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i",[[Game sharedGame]highestScore:[[NSUserDefaults standardUserDefaults]arrayForKey:@"highScoreArray"]]] fontName:@"helvetica" fontSize:22];
        
        scoreLabel2.color = ccc3(250, 0, 0);
        scoreLabel2.position = ccp(160, 200);
        
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

-(void)retryButtonClicked:(id)sender
{
    [[Game sharedGame]resetGame];
    [SceneManager goGame];
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
