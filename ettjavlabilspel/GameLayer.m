//
//  GameLayer.m
//  ettjavlabilspel
//
//  Created by Andreas Areschoug.
//
//  The highscore scene. Currently the highscore only showes top five on your the handset.
//
//  TODO:


#import "GameLayer.h"

@implementation GameLayer

CCSprite *paus;
int state;
int stateTimer;

-(id)init
{
    if((self=[super init])){
        //STATE
        gameSpeed = [Game sharedGame].gameSpeed;
        state = [Game sharedGame].state;
        score = [Game sharedGame].currentScore;
        repeatRate = [Game sharedGame].repeatRate;
        level = [Game sharedGame].level;
        
        self.isAccelerometerEnabled = YES;
        [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
        
        playing = YES;

        
        //MUSIC
        if(![Game sharedGame].music)
        {
            if ([[MPMusicPlayerController iPodMusicPlayer] playbackState] != MPMusicPlaybackStatePlaying) {
                [[SimpleAudioEngine sharedEngine]playBackgroundMusic:@"menu_music.mp3"];
            }   
        }
          
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"muteSfx"])
            [[SimpleAudioEngine sharedEngine] setEffectsVolume:0];
        else
            [[SimpleAudioEngine sharedEngine] setEffectsVolume:1];
        
        //MENU
        CCMenuItemImage *pausButton = [CCMenuItemImage itemFromNormalImage:@"ingame-pause1.png" selectedImage:@"ingame-pause2.png" target:self selector:@selector(menuItemClicked:)];
        pausButton.position = ccp(265, 460);
        menu = [CCMenu menuWithItems:pausButton, nil];
        menu.position = ccp(0, 0);
        
        //SCORE
        scoreLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%i",score]] fontName:@"helvetica" fontSize:22];
        scoreLabel.position = ccp(65, 465);

        CCSprite *scoreBackground = [CCSprite spriteWithFile:@"ingame-score.png"];
        scoreBackground.position = ccp(92, 462);
        
        
        //init background
        background = [[Entity alloc]initWithFile:@"cityroad.png"];
        background.position = [Game sharedGame].backgroundPosition;
        
        //init tunnel
        tunnel = [[Entity alloc] initWithFile:@"tunnel.png"];
        tunnel.position = [Game sharedGame].tunnelPosition;
        
        //init car
        NSString *carColor;
        
        switch ([Game sharedGame].carColor) {
            case 0:
                carColor = @"red.png";
                break;
            case 1:
                carColor = @"gren.png";
                break;
            case 2:
                carColor = @"blue.png";
                break;
            default:
                break;
        }
        
        car = [[Car alloc] initWithFile:carColor];
        car.position = [Game sharedGame].carPosition;

        //OBSTACLES
        
        //init hole
        hole = [[Hole alloc] initWithFile:@"hinder3.png"];
        hole.position = [Game sharedGame].holePosition;

        //init destroyed car
        destroyedCar = [[DestroyedCar alloc] initWithFile:@"dubbelhinder.png"];
        destroyedCar.position = [Game sharedGame].destroyedCarPosition;
        
        //POWERUPS
        
        //init bottle
        bottle = [[Alcohol alloc] initWithFile:@"flaska2.png"];
        bottle.position = [Game sharedGame].bottlePosition;
        [bottle runAction:[CCRepeatForever actionWithAction:[CCRotateBy actionWithDuration:1 angle:360]]];        

        //init invicible
        invincible = [[Invincible alloc] initWithFile:@"invicible.png"];
        invincible.position = [Game sharedGame].inviciblePosition;
        [invincible runAction:[CCRepeatForever actionWithAction:[CCRotateBy actionWithDuration:1 angle:360]]];
        
        //init small
        small = [[Small alloc] initWithFile:@"small.png"];
        small.position = [Game sharedGame].smallPosition;
        [small runAction:[CCRepeatForever actionWithAction:[CCRotateBy actionWithDuration:1 angle:360]]];
        
        //init gun
        gun = [[Gun alloc] initWithFile:@"gun.png"];
        gun.position = [Game sharedGame].gunPosition;
        [gun runAction:[CCRepeatForever actionWithAction:[CCRotateBy actionWithDuration:1 angle:360]]];
        
        //init bullet
        bullet = [[Bullet alloc] initWithFile:@"bullet.png"];
        bullet.position = [Game sharedGame].gunPosition;

        //init slow
        slow = [[Slow alloc] initWithFile:@"slow.png"];
        slow.position = [Game sharedGame].slowPosition;
        //[slow runAction:[CCRepeatForever actionWithAction:[CCRotateBy actionWithDuration:1 angle:360]]];
        
        //init fast
        fast = [[Fast alloc] initWithFile:@"fast.png"];
        fast.position = [Game sharedGame].fastPosition;
        //[fast runAction:[CCRepeatForever actionWithAction:[CCRotateBy actionWithDuration:1 angle:360]]];
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
        [self addChild:menu];
        [self addChild:scoreBackground];
        [self addChild:scoreLabel];
        
        [[UIAccelerometer sharedAccelerometer]setUpdateInterval:1/60];
        [self schedule:@selector(callEveryFrame:)];
        [self schedule:@selector(speedChange:) interval:10];
    }
    return self;
}

- (void)accelerometer:(UIAccelerometer*)accelerometer didAccelerate: (UIAcceleration*)acceleration
{

    if(playing){
    float accX = ceilf([acceleration x] * 100 + 0.5) / 100;
    float accY = ceilf([acceleration y] * 100 + 0.5) / 100;    
    

    //If drunk revert the steering(right-left) by multiply with -1 
    if(state == 1){
        //DRUNK
        accX = accX *-1;

    }
    
    if(state != 0)
        stateTimer -= 1;
    
    [car moveX:accX moveY:accY];

   
    //RESETER
    if(state > 0 && stateTimer < 1){
        switch (state) {
            case 1:
                //DRUNK
                break;
            case 2:
                //INVICIBLE
                car.opacity = 255;
                break;
            case 3:
                //SMALL
                [car runAction:[CCScaleTo actionWithDuration:.3 scale:1]];
                [car runAction:[CCScaleTo actionWithDuration:.3 scale:0.9]];
                [car runAction:[CCScaleTo actionWithDuration:.3 scale:1]];
                break;
            case 4:
                bullet.position = ccp(1000, 1000);
                break;
            case 5:
                //SLOW
                gameSpeed = realGameSpeed;
                break;
            case 6:
                //FAST
                gameSpeed = realGameSpeed;
                break;
            default:
                break;
        }
        state = 0;
    }
    
    //If the player isn't affected by a powerup and collide with a bottle of alcohol the player
    //becomes drunk, and the bottle will be moved off screen
    if(state == 0  && [bottle collision:car]){
        state = 1;
        stateTimer = 50;
        bottle.position = ccp(-100, 100);
        //score += 100 * gameSpeed;
    }
    
    //If the player isn't affected by a powerup and collide with an unit of invicibility the player
    //becomes invnicible, and the unit of invicibility will be moved off screen
    if (state == 0 && [invincible collision:car]) {
        state = 2;
        stateTimer = 50;
        invincible.position = ccp(-100, 100);
        car.opacity = 160;
    }
    
    
    if (state == 0 && [small collision:car]) {
        state = 3;
        stateTimer = 50;
        small.position = ccp(-100, 100);
        [car runAction:[CCScaleTo actionWithDuration:.3 scale:0.75]];
        [car runAction:[CCScaleTo actionWithDuration:.3 scale:0.9]];
        [car runAction:[CCScaleTo actionWithDuration:.3 scale:0.75]];
    }
    
    if (state == 0 && [gun collision:car]) {
        state = 4;
        stateTimer = 50;
        gun.position = ccp(-100, 100);
        bullet.position = car.position;
    }
    
    //SLOW
    if (state == 0 && [slow collision:car]){
        state = 5;
        stateTimer = 50;
        realGameSpeed = gameSpeed;
        gameSpeed -= gameSpeed/2;
    }

    //FAST
    if (state == 0 && [fast collision:car]){
        state = 5;
        stateTimer = 50;
        realGameSpeed = gameSpeed;
        gameSpeed += gameSpeed/2;
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
}

    /* menuItemClicked: (id)sender
     *
     * The pause button gets clicked. 
     * The state and position of all objects gets saved in to the Game-class
     *
     * (id)sender:(no used)
     */
-(void)menuItemClicked: (id)sender
{
    
    if(![[CCDirector sharedDirector] isPaused]){
        [menu setOpacity:0];
        
        [[CCDirector sharedDirector] pause];
        
        CCMenuItemImage *returnButton = [CCMenuItemImage itemFromNormalImage:@"pause-continue1.png" selectedImage:@"pause-continue2.png" target:self selector:@selector(pauseMenuItemClicked:)];
        
        CCMenuItemImage *menuButton = [CCMenuItemImage itemFromNormalImage:@"pause-mainmenu1.png" selectedImage:@"pause-mainmenu2.png" target:self selector:@selector(pauseMenuItemClicked:)];
        
        returnButton.position = ccp(0, 100);
        menuButton.position = ccp(0, 0);
        
        returnButton.tag = 1;
        menuButton.tag = 2;
        
        pauseMenu = [CCMenu menuWithItems:returnButton,menuButton, nil];
        
        menu.position = ccp(0, 0);
        
        [self addChild:pauseMenu];
        
    }
    
}

-(void)pauseMenuItemClicked:(id)sender{
    switch ([sender tag]) {
        case 1:
            [menu setOpacity:255];
            [[CCDirector sharedDirector] resume];
            [self removeChild:pauseMenu cleanup:YES];
            break;
        case 2:
            [[CCDirector sharedDirector] resume];
            [SceneManager goMenu];
            [[Game sharedGame]resetGame];
            break;            
        default:
            break;
    }
}

-(void)callEveryFrame:(ccTime)dt
{
    if (playing) {
        
        //BACKGROUND
        if (background.position.y <= 240-20) {
            background.position = ccp(160, background.position.y+repeatRate);
        }
        
        if (tunnel.position.y <= -400) {
            if(level >= 4)
                tunnel.position = ccp(-400, 100000);
            else
                tunnel.position = ccp(160, 2500);            

            textureChanged = NO;
        }
        
        if([hole collision:tunnel]){
            hole.position = ccp(-100, -100);
        }

        if([destroyedCar collision:tunnel]){
            destroyedCar.position = ccp(-100, -100);
        }
        
        if ([bottle collision:tunnel]) {
            bottle.position = ccp(-100, -100);
        }
        
        if ([invincible collision:tunnel]) {
            invincible.position = ccp(-100, -100);
        }

        if ([small collision:tunnel]) {
            small.position = ccp(-100, -100);
        }
        
        if ([gun collision:tunnel]) {
            gun.position = ccp(-100, -100);
        }
        
        if ([fast collision:tunnel]) {
            fast.position = ccp(-100, -100);
        }
        
        if ([slow collision:tunnel]) {
            slow.position = ccp(-100, -100);
        }
        
        if([tunnel collision:car]){
            if (textureChanged == NO  && tunnel.position.y < 240) {
                level += 1;
                [self setTexture];
            }
        }
        
        //MOVE
        [background     goX:0   goY:-gameSpeed];
        [tunnel         goX:0   goY:-gameSpeed];
        [hole           objectGoX:0 objectGoY:-gameSpeed];
        [bottle         objectGoX:0 objectGoY:-gameSpeed]; 
        [destroyedCar   objectGoX:0 objectGoY:-gameSpeed];
        [invincible     objectGoX:0 objectGoY:-gameSpeed];
        [small          objectGoX:0 objectGoY:-gameSpeed];
        [gun            objectGoX:0 objectGoY:-gameSpeed];
        [slow           objectGoX:0 objectGoY:-gameSpeed];    
        [fast           objectGoX:0 objectGoY:-gameSpeed];

    
        
        if(state == 4){
            [bullet objectGoX:0 objectGoY:gameSpeed + 1 car:car.position];
        }
    
        //CHECK IF BULLET HIT
        if (state == 4 && ([bullet collision:destroyedCar] || [bullet collision:hole])) {
            
            if([bullet collision:hole])
                hole.position = ccp(-100, 100);
            
            if ([bullet collision:destroyedCar])
                destroyedCar.position = ccp(-100, 100);
            
            bullet.position = ccp(1000, 1000);
        }    
    
        //Collision by car results in a game ending tragedy
        if(([destroyedCar collision:car] || [hole collision:car]) && state != 2){
            [self saveState];
            playing = NO;
            [SceneManager goGameOver];
        }    
        
        //CURRENTSCORE
        score += (1 * [car scoreMultiplier]);
        [scoreLabel setString:[NSString stringWithFormat:@"%i",score/10]];
    }
}

-(void)speedChange:(ccTime) dt
{
    gameSpeed += 1;
}

-(void) setTexture
{
    CCTexture2D *roadTexture;
    CCTexture2D *holeTexture;
    CCTexture2D *destroyedCarTexture;
    if (level == 2) {
        roadTexture = [[CCTexture2D alloc] initWithImage:[UIImage imageNamed:@"sandroad.png"]];
        holeTexture = [[CCTexture2D alloc] initWithImage:[UIImage imageNamed:@"snowman.png"]];
        destroyedCarTexture = [[CCTexture2D alloc] initWithImage:[UIImage imageNamed:@"snowhole.png"]];
        repeatRate = 79;
    }else if (level == 3){
        roadTexture = [[CCTexture2D alloc] initWithImage:[UIImage imageNamed:@"iceroad2.png"]];
        holeTexture = [[CCTexture2D alloc] initWithImage:[UIImage imageNamed:@"snowman.png"]];
        destroyedCarTexture = [[CCTexture2D alloc] initWithImage:[UIImage imageNamed:@"snowhole.png"]];
        repeatRate = 64;
    }else if(level >= 4){
        roadTexture = [[CCTexture2D alloc] initWithImage:[UIImage imageNamed:@"rainbow.png"]];
        holeTexture = [[CCTexture2D alloc] initWithImage:[UIImage imageNamed:@"star.png"]];
        destroyedCarTexture = [[CCTexture2D alloc] initWithImage:[UIImage imageNamed:@"unicorn.png"]];
        repeatRate = 41;
    }

    [background setTexture:roadTexture];
    [hole setTexture:holeTexture];
    [destroyedCar setTexture:destroyedCarTexture];
    
    [roadTexture release];
    [holeTexture release];
    [destroyedCarTexture release];
    
    textureChanged = YES;
}

- (void) saveState
{
    //STATE
    [Game sharedGame].gameSpeed = gameSpeed; 
    [Game sharedGame].state = state;
    [Game sharedGame].stateTimer = stateTimer;
    [Game sharedGame].currentScore = score/10;
    [Game sharedGame].repeatRate = repeatRate ;
    [Game sharedGame].level = level;
    
    //POSITIONS
    [Game sharedGame].backgroundPosition = background.position;
    [Game sharedGame].carPosition = car.position;
    [Game sharedGame].holePosition = hole.position;
    [Game sharedGame].bottlePosition = bottle.position;
    [Game sharedGame].destroyedCarPosition = destroyedCar.position;
    [Game sharedGame].inviciblePosition = invincible.position;
    [Game sharedGame].gunPosition = gun.position;
    [Game sharedGame].bulletPosition = bullet.position;
    [Game sharedGame].smallPosition = small.position;
    [Game sharedGame].fastPosition = fast.position;
    [Game sharedGame].slowPosition = slow.position;
    [Game sharedGame].tunnelPosition = tunnel.position;
}

- (void) dealloc
{
    NSLog(@"DELLOC GAMELAYER - %@",self);
    [car release];
    
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

    //RELEASE TEXTURE
    [CCSpriteFrameCache purgeSharedSpriteFrameCache];
    [CCTextureCache purgeSharedTextureCache];
    
	[super dealloc];

}

@end
