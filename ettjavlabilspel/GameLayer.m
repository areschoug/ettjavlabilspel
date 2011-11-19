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
        changeScore = [Game sharedGame].changeScore;
        
        self.isAccelerometerEnabled = YES;
        [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
        
        playing = YES;

        //MUSIC
        if(![Game sharedGame].music)
        {
            if ([[MPMusicPlayerController iPodMusicPlayer] playbackState] != MPMusicPlaybackStatePlaying) {
                [[SimpleAudioEngine sharedEngine]playBackgroundMusic:@"music.mp3"];
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
                carColor = @"green-car.png";
                break;
            case 1:
                carColor = @"sport-car.png";
                break;
            case 2:
                carColor = @"jeep.png";
                break;
            case 3:
                carColor = @"bat-car.png";
                break;
            case 4:
                carColor = @"army.png";
                break;
            case 5:
                carColor = @"dream-car.png";
                break;
            default:
                break;
        }
        
        car = [[Car alloc] initWithFile:carColor];
        car.position = [Game sharedGame].carPosition;

        //OBSTACLES
        
        //init obstacle one
        obstacleOne = [[Obstacle alloc] initWithFile:@"city-obstacleOne.png"];
        obstacleOne.position = [Game sharedGame].obstacleOnePosition;

        //init obstacle two
        obstacleTwo = [[Obstacle alloc] initWithFile:@"city-obstacleTwo.png"];
        obstacleTwo.position = [Game sharedGame].obstacleTwoPosition;
        
        //init big obstacle
        bigObstacle = [[BigObstacle alloc] initWithFile:@"city-bigObstacle.png"];
        bigObstacle.position = [Game sharedGame].bigObstaclePosition;
        
        //POWERUPS
        
        //init bottle
        bottle = [[Alcohol alloc] initWithFile:@"alkohol.png"];
        bottle.position = [Game sharedGame].bottlePosition;
        [bottle runAction:[CCRepeatForever actionWithAction:[CCRotateBy actionWithDuration:3 angle:360]]];        

        //init invicible
        invincible = [[Immortal alloc] initWithFile:@"immortal.png"];
        invincible.position = [Game sharedGame].inviciblePosition;
        [invincible runAction:[CCRepeatForever actionWithAction:[CCRotateBy actionWithDuration:3 angle:360]]];
        
        //init small
        small = [[Small alloc] initWithFile:@"smaller.png"];
        small.position = [Game sharedGame].smallPosition;
        [small runAction:[CCRepeatForever actionWithAction:[CCRotateBy actionWithDuration:3 angle:360]]];
        
        //init gun
        gun = [[Gun alloc] initWithFile:@"gun.png"];
        gun.position = [Game sharedGame].gunPosition;
        [gun runAction:[CCRepeatForever actionWithAction:[CCRotateBy actionWithDuration:3 angle:360]]];
        
        //init bullet
        bullet = [[Bullet alloc] initWithFile:@"bullet.png"];
        bullet.position = [Game sharedGame].gunPosition;

        //init slow
        slow = [[Slow alloc] initWithFile:@"slow.png"];
        slow.position = [Game sharedGame].slowPosition;
        
        //init fast
        fast = [[Fast alloc] initWithFile:@"fast.png"];
        fast.position = [Game sharedGame].fastPosition;

        if (level != 1) {
            [self setTexture];
        }
        
        //lowest is ontop
        [self addChild:background];
        [self addChild:slow];
        [self addChild:fast];
        [self addChild:obstacleOne];
        [self addChild:obstacleTwo];
        [self addChild:bigObstacle];
        [self addChild:bottle];
        [self addChild:invincible];
        [self addChild:small];
        [self addChild:gun];
        [self addChild:bullet];
        [self addChild:car];
        [self addChild:tunnel];
        [self addChild:menu];
        [self addChild:scoreBackground];
        [self addChild:scoreLabel];
        
        [[UIAccelerometer sharedAccelerometer]setUpdateInterval:1/60];
        [self schedule:@selector(callEveryFrame:)];
        [self schedule:@selector(speedChange:) interval:15];
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
        
        if ([obstacleOne collision:obstacleTwo]) {
            obstacleOne.position = ccp(-100, -100);
        }

        if ([obstacleOne collision:bigObstacle]) {
            obstacleOne.position = ccp(-100, -100);
        }
        
        if ([obstacleTwo collision:bigObstacle]) {
            obstacleTwo.position = ccp(-100, -100);
        }
        
        if (tunnel.position.y <= -400) {
            tunnel.position = ccp(-200, 100000);
            textureChanged = NO;
        }
        
        if([obstacleOne collision:tunnel]){
            obstacleOne.position = ccp(obstacleOne.position.x + 500, obstacleOne.position.y);
        }

        if([obstacleTwo collision:tunnel]){
            obstacleTwo.position = ccp(obstacleTwo.position.x + 500, obstacleTwo.position.y);
        }
        
        if([bigObstacle collision:tunnel]){
            bigObstacle.position = ccp(bigObstacle.position.x + 500, bigObstacle.position.y);
        }
        
        if ([bottle collision:tunnel]) {
            bottle.position = ccp(bottle.position.x + 500, bottle.position.y);
        }
        
        if ([invincible collision:tunnel]) {
            invincible.position = ccp(invincible.position.x + 500, invincible.position.y);
        }

        if ([small collision:tunnel]) {
            small.position = ccp(small.position.x + 500, small.position.y);
        }
        
        if ([gun collision:tunnel]) {
            gun.position = ccp(gun.position.x + 500, gun.position.y);
        }
        
        if ([fast collision:tunnel]) {
            fast.position = ccp(fast.position.x + 500, fast.position.y);
        }
        
        if ([slow collision:tunnel]) {
            slow.position = ccp(slow.position.x + 500, slow.position.y );
        }
        
        if (score/10 >= changeScore) {
            tunnel.position = ccp(160, 1000);
            changeScore += [Game sharedGame].changeScore;
        }
        
        if (textureChanged == NO  && tunnel.position.y-50  < 240) {
            level += 1;
            [self setTexture];
        }
        
        //MOVE
        [background     goX:0   goY:-gameSpeed];
        [tunnel         goX:0   goY:-gameSpeed];
        [obstacleOne    objectGoX:0 objectGoY:-gameSpeed];
        [obstacleTwo    objectGoX:0 objectGoY:-gameSpeed];        
        [bottle         objectGoX:0 objectGoY:-gameSpeed]; 
        [bigObstacle    objectGoX:0 objectGoY:-gameSpeed];
        [invincible     objectGoX:0 objectGoY:-gameSpeed];
        [small          objectGoX:0 objectGoY:-gameSpeed];
        [gun            objectGoX:0 objectGoY:-gameSpeed];
        [slow           objectGoX:0 objectGoY:-gameSpeed];    
        [fast           objectGoX:0 objectGoY:-gameSpeed];

    
        
        if(state == 4){
            [bullet objectGoX:0 objectGoY:gameSpeed + 1 car:car.position];
        }
    
        //CHECK IF BULLET HIT
        if (state == 4 && ([bullet collision:bigObstacle] || [bullet collision:obstacleOne] || [bullet collision:obstacleTwo])) {
            
            if([bullet collision:obstacleOne])
                obstacleOne.position = ccp(-100, 100);
            
            if ([bullet collision:obstacleTwo])
                obstacleTwo.position = ccp(-100, 100);
            
            if ([bullet collision:bigObstacle])
                bigObstacle.position = ccp(-100, 100);
            
            bullet.position = ccp(1000, 1000);
        }    
    
        //Collision by car results in a game ending tragedy
        if(([bigObstacle collision:car] || [obstacleOne collision:car] || [obstacleTwo collision:car]) && state != 2){
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
    CCTexture2D *obstacleOneTexture;
    CCTexture2D *obstacleTwoTexture;    
    CCTexture2D *bigObstacleTexture;
    
    if (level == 2) {
        roadTexture = [[CCTexture2D alloc] initWithImage:[UIImage imageNamed:@"sandroad.png"]];
        obstacleOneTexture = [[CCTexture2D alloc] initWithImage:[UIImage imageNamed:@"sand-obstacleOne.png"]];
        obstacleTwoTexture = [[CCTexture2D alloc] initWithImage:[UIImage imageNamed:@"sand-obstacleTwo.png"]];
        bigObstacleTexture = [[CCTexture2D alloc] initWithImage:[UIImage imageNamed:@"sand-bigObstacle.png"]];
        
        obstacleTwo.rotation = 320;
        
        repeatRate = 79;
    }else if (level == 3){
        roadTexture = [[CCTexture2D alloc] initWithImage:[UIImage imageNamed:@"iceroad2.png"]];
        obstacleOneTexture = [[CCTexture2D alloc] initWithImage:[UIImage imageNamed:@"ice-obstacleOne.png"]];
        obstacleTwoTexture = [[CCTexture2D alloc] initWithImage:[UIImage imageNamed:@"ice-obstacleTwo.png"]];
        bigObstacleTexture = [[CCTexture2D alloc] initWithImage:[UIImage imageNamed:@"ice-bigObstacle.png"]];

        obstacleTwo.rotation = 0;
        
        repeatRate = 64;
    }else if(level >= 4){
        obstacleOneTexture = [[CCTexture2D alloc] initWithImage:[UIImage imageNamed:@"sand-obstacleOne.png"]];
        obstacleTwoTexture = [[CCTexture2D alloc] initWithImage:[UIImage imageNamed:@"sand-obstacleTwo.png"]];
        bigObstacleTexture = [[CCTexture2D alloc] initWithImage:[UIImage imageNamed:@"sand-bigObstacle.png"]];
        repeatRate = 41;
    }

    [background setTexture:roadTexture];
    [obstacleOne setTexture:obstacleOneTexture];
    [obstacleOne setTextureRect:CGRectMake(0, 0, obstacleOneTexture.contentSize.width, obstacleOneTexture.contentSize.height)];
    [obstacleTwo setTexture:obstacleTwoTexture];    
    [obstacleTwo setTextureRect:CGRectMake(0, 0, obstacleTwoTexture.contentSize.width, obstacleTwoTexture.contentSize.height)];
    [bigObstacle setTexture:bigObstacleTexture];
    [bigObstacle setTextureRect:CGRectMake(0, 0, bigObstacleTexture.contentSize.width, bigObstacleTexture.contentSize.height)];
    
    [roadTexture release];
    [obstacleOneTexture release];
    [obstacleTwoTexture release];
    [bigObstacleTexture release];
    

    
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
    
    [Game sharedGame].obstacleOnePosition = obstacleOne.position;
    [Game sharedGame].obstacleTwoPosition = obstacleTwo.position;
    [Game sharedGame].bigObstaclePosition = bigObstacle.position;

    [Game sharedGame].bottlePosition = bottle.position;
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
    [obstacleOne release];
    [obstacleTwo release];
    [bigObstacle release];    
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
