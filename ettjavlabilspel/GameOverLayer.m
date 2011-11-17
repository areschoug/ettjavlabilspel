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
        
        level = [Game sharedGame].level;
        
        //SAVE HIGHSCORE
        [self saveHighScore];
        
        //MUSIC
        if(![Game sharedGame].music)
        {
            [[SimpleAudioEngine sharedEngine]playBackgroundMusic:@"menu_music.mp3"];
            [Game sharedGame].music = YES;
        }
        
        //init background
        background = [[CCSprite alloc]initWithFile:@"cityroad.png"];
        background.position = [Game sharedGame].backgroundPosition;
        
        //init tunnel
        tunnel = [[CCSprite alloc] initWithFile:@"tunnel.png"];
        tunnel.position = [Game sharedGame].tunnelPosition;
        
        car = [[CCSprite alloc]initWithFile:@"car3-dead.png"];
        car.position = [Game sharedGame].carPosition;
               
        //OBSTACLES
        
        //init hole
        hole = [[CCSprite alloc] initWithFile:@"hinder3.png"];
        hole.position = [Game sharedGame].holePosition;
        
        //init destroyed car
        destroyedCar = [[CCSprite alloc] initWithFile:@"dubbelhinder.png"];
        destroyedCar.position = [Game sharedGame].destroyedCarPosition;
        
        //POWERUPS
        
        //init bottle
        bottle = [[CCSprite alloc] initWithFile:@"flaska2.png"];
        bottle.position = [Game sharedGame].bottlePosition;
        
        //init invicible
        invincible = [[CCSprite alloc] initWithFile:@"invicible.png"];
        invincible.position = [Game sharedGame].inviciblePosition;
        
        //init small
        small = [[CCSprite alloc] initWithFile:@"small.png"];
        small.position = [Game sharedGame].smallPosition;
        
        //init gun
        gun = [[CCSprite alloc] initWithFile:@"gun.png"];
        gun.position = [Game sharedGame].gunPosition;
        
        //init bullet
        bullet = [[CCSprite alloc] initWithFile:@"bullet.png"];
        bullet.position = [Game sharedGame].bulletPosition;
        
        //init slow
        slow = [[CCSprite alloc] initWithFile:@"slow.png"];
        slow.position = [Game sharedGame].slowPosition;
        
        //init fast
        fast = [[CCSprite alloc] initWithFile:@"fast.png"];
        fast.position = [Game sharedGame].fastPosition;
        if (level != 1) {
            [self setTexture];
        }
        
        //lowest is ontop
        [self addChild:background];
        [self addChild:hole];
        [self addChild:destroyedCar];
        [self addChild:bottle];
        [self addChild:invincible];
        [self addChild:small];
        [self addChild:gun];
        [self addChild:slow];
        [self addChild:fast];
        [self addChild:bullet];
        [self addChild:car];
        [self addChild:tunnel];
        
        
        //MENU
        CCMenu *menu;
        
        CCMenuItemImage *backButton = [CCMenuItemImage itemFromNormalImage:@"pause-mainmenu1.png" selectedImage:@"pause-mainmenu2.png" target:self selector:@selector(backButtonClicked:)];
        backButton.position = ccp(160, 80);        

        CCMenuItemImage *retryButton = [CCMenuItemImage itemFromNormalImage:@"retry-button1.png" selectedImage:@"retry-button2.png" target:self selector:@selector(retryButtonClicked:)];
        retryButton.position = ccp(160,210);
        retryButton.scale = 0.87;
        
        menu = [CCMenu menuWithItems:retryButton,backButton, nil];
        menu.position = ccp(0, 0);

        //SCORELABLE
        CCLabelTTF *scoreLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i",[Game sharedGame].currentScore] fontName:@"helvetica" fontSize:22];
        
        scoreLabel.position = ccp(160, 320);
        
        CCLabelTTF *scoreLabel2 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i",[[NSUserDefaults standardUserDefaults] integerForKey:@"highestScore"]] fontName:@"helvetica" fontSize:22];
        
        scoreLabel2.color = ccc3(250, 0, 0);
        scoreLabel2.position = ccp(160, 345);
        
        if([Game sharedGame].currentScore == [[NSUserDefaults standardUserDefaults] integerForKey:@"highestScore"]){
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

-(void) setTexture
{
    CCTexture2D *roadTexture;
    CCTexture2D *holeTexture;
    CCTexture2D *destroyedCarTexture;
    
    if(level == 2){
        roadTexture = [[CCTexture2D alloc] initWithImage:[UIImage imageNamed:@"sandroad.png"]];
        holeTexture = [[CCTexture2D alloc] initWithImage:[UIImage imageNamed:@"snowman.png"]];
        destroyedCarTexture = [[CCTexture2D alloc] initWithImage:[UIImage imageNamed:@"snowhole.png"]];    
    }else if (level == 3){
        roadTexture = [[CCTexture2D alloc] initWithImage:[UIImage imageNamed:@"iceroad.png"]];
        holeTexture = [[CCTexture2D alloc] initWithImage:[UIImage imageNamed:@"snowman.png"]];
        destroyedCarTexture = [[CCTexture2D alloc] initWithImage:[UIImage imageNamed:@"snowhole.png"]];
    }else if(level >= 4){
        roadTexture = [[CCTexture2D alloc] initWithImage:[UIImage imageNamed:@"rainbow.png"]];
        holeTexture = [[CCTexture2D alloc] initWithImage:[UIImage imageNamed:@"star.png"]];
        destroyedCarTexture = [[CCTexture2D alloc] initWithImage:[UIImage imageNamed:@"unicorn.png"]];
    }
    
    [background setTexture:roadTexture];
    [hole setTexture:holeTexture];
    [destroyedCar setTexture:destroyedCarTexture];
    
    [roadTexture release];
    [holeTexture release];
    [destroyedCarTexture release];
    
}

-(void)saveHighScore
{
    int newScore = [Game sharedGame].currentScore;
    
    int oldScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"highestScore"];
    
    if(newScore > oldScore)
        [[NSUserDefaults standardUserDefaults] setInteger:newScore forKey:@"highestScore"];
}

-(void)dealloc
{
    NSLog(@"DEALLOC - GAME OVER SCENE %@",self);
    
    [background release];
    [tunnel release];
    [hole release];
    [bottle release];
    [invincible release];
    [small release];
    [fast release];
    [slow release];
    [gun release];
    [bullet release];
    
    [CCSpriteFrameCache purgeSharedSpriteFrameCache];
    [CCTextureCache purgeSharedTextureCache];    
    [super dealloc];
}
@end
