//
//  GameLayer.m
//  ettjavlabilspel
//
//  Created by Andreas Areschoug.
//
//  The highscore scene. Currently the highscore only showes top five on your the handset.
//
//  TODO:
//  - implement nice graphics 
//  - get pause button to work correctly


#import "GameLayer.h"

@implementation GameLayer

CCSprite *paus;
bool drunk;
int drunkTimer;

+(CCScene *) scene
{
    CCScene *scene = [CCScene node];
    
    GameLayer *layer = [GameLayer node];
    
    [scene addChild:layer];
    
    return scene;
}

-(id)init
{
    if((self=[super init])){
        //STATE
        gameSpeed = [Game sharedGame].gameSpeed;
        drunk = [Game sharedGame].drunk;
        score = [Game sharedGame].currentScore;
        self.isAccelerometerEnabled = YES;
        [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
        
        //MUSIC
        [[SimpleAudioEngine sharedEngine]playBackgroundMusic:@"music.mp3"];
        
        //MENU
        CCMenuItemImage *pausButton = [CCMenuItemImage itemFromNormalImage:@"pause.png" selectedImage:@"pause.png" target:self selector:@selector(menuItemClicked:)];
        menu = [CCMenu menuWithItems:pausButton, nil];
        menu.position = ccp(270, 455);
        
        //HIGHSCORE
        scoreLabel = [CCLabelAtlas labelWithString:[NSString stringWithFormat:@"%i",score] charMapFile:@"fps_images.png" itemWidth:16 itemHeight:48 startCharMap:'.'];
        scoreLabel.position = ccp(15, 430);
        
        //init background
        background = [[Entity alloc]initWithFile:@"road.png"];
        background.position=ccp(160, 240-20);
        
        //init car
        car = [[Car alloc] initWithFile:@"bil.png"];
        car.position = [Game sharedGame].carPosition;
        
        //init hole
        hole = [[Hole alloc] initWithFile:@"hinder3.png"];
        hole.position = [Game sharedGame].holePosition;

        //init bottle
        bottle = [[Alcohol alloc] initWithFile:@"flaska2.png"];
        bottle.position = [Game sharedGame].bottlePosition;
        [bottle runAction:[CCRepeatForever actionWithAction:[CCRotateBy actionWithDuration:1 angle:360]]];        
        
        //init destroyed car
        destroyedCar = [[DestroyedCar alloc] initWithFile:@"dubbelhinder.png"];
        destroyedCar.position = [Game sharedGame].destroyedCarPosition;
        
        //lowest is ontop
        [self addChild:background];
        [self addChild:hole];
        [self addChild:bottle];
        [self addChild:destroyedCar];
        [self addChild:car];
        [self addChild:menu];
        [self addChild:scoreLabel];
        
        [[UIAccelerometer sharedAccelerometer]setUpdateInterval:1/10];
        [self schedule:@selector(callEveryFrame:)];
        [self schedule:@selector(speedChange:) interval:3];
    }
    return self;
}

- (void)accelerometer:(UIAccelerometer*)accelerometer didAccelerate: (UIAcceleration*)acceleration{
    
    float accX = ceilf([acceleration x] * 100 + 0.5) / 100;
    float accY = ceilf([acceleration y] * 100 + 0.5) / 100;    


    //If drunk revert the steering(right-left) by multiply with -1 
    if(drunk){
        accX = accX *-1;
        drunkTimer -= 1;
    }
    
    [car moveX:accX moveY:accY];
    
    //Collision by car results in a game ending tragedy
    if([destroyedCar collision:car] || [hole collision:car]){
        [Game sharedGame].gameSpeed = 0;
        [Game sharedGame].currentScore = score/10;
        [SceneManager goGameOver];
    }
    
    // When drunktime is 0 the player becomes sober again, and the steering
    // will go back to normal.
    if(drunk && drunkTimer < 1){
        drunk = NO;
    }
    
    //If the player isn't drunk and collide with a bottle of alcohol the player
    //becomes drunk, and the bottel will be moved of screen
    if(!drunk && [bottle collision:car]){
        drunk = YES;
        drunkTimer = 50;
        bottle.position = ccp(-100, 100);
        score += 100 * gameSpeed;
    }
    
    /*
    // Vibration i kanten
    // Ta bort?
    NSLog(@"%f och %f",car.position.x, car.position.y);
    if(car.position.x < 30|| car.position.x > 290){
        NSLog(@"här");
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
    }
    */
}
    /* menuItemClicked: (id)sender
     *
     * The pause button gets clicked. 
     * The state and position of all objects gets saved in to the Game-class
     *
     * (id)sender:(no used)
     */
-(void)menuItemClicked: (id)sender{
    //STATE
    [Game sharedGame].gameSpeed = gameSpeed; 
    [Game sharedGame].drunk = drunk;
    [Game sharedGame].currentScore = score/10;
    //POSITION
    [Game sharedGame].carPosition = car.position;
    [Game sharedGame].holePosition = hole.position;
    [Game sharedGame].bottlePosition = bottle.position;
    [Game sharedGame].destroyedCarPosition = destroyedCar.position; 
    //Change the scene
    [SceneManager goMenu];
    
}

-(void)callEveryFrame:(ccTime)dt{
    
    //BACKGROUND
    if (background.position.y <= 240-20) {
        background.position = ccp(160, background.position.y+40);
    }
    
    //HOLE
    if(hole.position.y < 0 - hole.contentSize.height/2){
        hole.position = [hole getStartPositions:300];
    }    
    
    //BOTLLE
    if (bottle.position.y <= 0 - bottle.contentSize.height/2){
        bottle.position = [bottle getStartPositions:1000];
    }
    
    //DESTROYED CAR
    if(destroyedCar.position.y <= 0 - destroyedCar.contentSize.height/2){
        destroyedCar.position = [destroyedCar getStartPositions:1000];
    }
    
    //MOVE
    [background     goX:0   goY:-gameSpeed];
    [hole           goX:0   goY:-gameSpeed];
    [bottle         goX:0   goY:-gameSpeed]; 
    [destroyedCar   goX:0   goY:-gameSpeed];
    
    //CURRENTSCORE
    score += 1;
    [scoreLabel setString:[NSString stringWithFormat:@"%i",score/10]];
}

-(void)speedChange:(ccTime) dt{
    gameSpeed += 1;
}

- (void) dealloc
{
    NSLog(@"DELLOC GAMELAYER - %@",self);
    [car release];
    background = nil;

    [background release];
    hole = nil;
    [hole release];
    bottle = nil;
    [bottle release];
    scoreLabel = nil;
    [scoreLabel release];
    [paus release];
	[super dealloc];
}

@end
