//
//  GameLayer.m
//  ettjavlabilspel
//
//  Created by Andreas Areschoug.
//
//  The highscore scene. Currently the highscore only showes top five on your the handset.
//

#import "GameLayer.h"

@implementation GameLayer

CCSprite *paus;
int state;
int stateTimer;
int speedState;
int speedStateTimer;

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
        realGameSpeed = 1;
        self.isAccelerometerEnabled = YES;
        [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
        
        //MUSIC
        if([[NSUserDefaults standardUserDefaults] boolForKey:@"music"])
            [[SimpleAudioEngine sharedEngine]playBackgroundMusic:@"music.mp3"];
          
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
        scoreLabel.color = ccc3(17, 44, 0);
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
        carColor = [[NSString alloc] init];
        
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
        
        //init moving obstacle
        movingTexture1 = [[CCTexture2D alloc] initWithImage:[UIImage imageNamed:@"city-moving1.png"]];
        movingTexture2 = [[CCTexture2D alloc] initWithImage:[UIImage imageNamed:@"city-moving2.png"]];
        movingObstacle = [[MovingObstacle alloc] initWithTexture:movingTexture1];
        movingObstacle.rotation = 40;
        movingObstacle.position = ccp(1000, 1000);
        
        //POWERUPS
        
        //init bottle
        bottle = [[Alcohol alloc] initWithFile:@"alkohol.png"];
        bottle.position = [Game sharedGame].bottlePosition;
        [bottle runAction:[CCRepeatForever actionWithAction:[CCRotateBy actionWithDuration:3 angle:360]]];        

        //init invicible
        immortal = [[Immortal alloc] initWithFile:@"immortal.png"];
        immortal.position = [Game sharedGame].immortalPosition;
        [immortal runAction:[CCRepeatForever actionWithAction:[CCRotateBy actionWithDuration:3 angle:360]]];
        
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

        //init car gun
        carGun = [[CCSprite alloc] initWithFile:@"car-gun.png"];
        carGun.position = [Game sharedGame].carGunPosition;
        
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
        [self addChild:movingObstacle];
        [self addChild:bottle];
        [self addChild:immortal];
        [self addChild:small];
        [self addChild:gun];
        [self addChild:bullet];
        [self addChild:car];
        [self addChild:carGun];
        [self addChild:tunnel];
        [self addChild:menu];
        [self addChild:scoreBackground];
        [self addChild:scoreLabel];

        playing = YES;

        [[UIAccelerometer sharedAccelerometer]setUpdateInterval:1.0f/40.0f];
        [self schedule:@selector(callEveryFrame:)];
        [self schedule:@selector(speedChange:) interval:1];
        [self schedule:@selector(movingTexture:) interval:.3];

        
    }
    return self;
}


    /* accelerometer:(UIAccelerometer*)accelerometer didAccelerate: (UIAcceleration*)acceleration
     *
     * This method controles the steering of the car from the data that the accelerometer gets.
     */

- (void)accelerometer:(UIAccelerometer*)accelerometer didAccelerate: (UIAcceleration*)acceleration
{
    if(playing){
        accX = ceilf([acceleration x] * 100 + 0.5) / 100;
        accY = ceilf([acceleration y] * 100 + 0.5) / 100;    
    
        //If drunk revert the steering(right-left) by multiply with -1 
        if(state == 1)
            accX = accX *-1;
        
        [car moveX:accX moveY:accY drunk:drunk];
    }
}
    /* callEveryFrame:(ccTime)dt
     * 
     * This method is called every frame and containes most of the gamelogic
     */

-(void)callEveryFrame:(ccTime)dt
{
    if (playing) {
        
        //BACKGROUND
        if (background.position.y <= 240-repeatRate) {
            background.position = ccp(160, background.position.y+repeatRate);
        }
        
        //SMALL OBSTACLES NOT TO SPAWN NEAR EACHOTHER
        if (obstacleOne.position.y + 250 > obstacleTwo.position.y && obstacleOne.position.y - obstacleOne.contentSize.height/2 < obstacleTwo.position.y) {
            obstacleTwo.position = ccp(obstacleTwo.position.x,  obstacleTwo.position.y + 350);
        }
        
        if (obstacleTwo.position.y + 250 > obstacleOne.position.y && obstacleTwo.position.y - obstacleTwo.contentSize.height/2 < obstacleOne.position.y) {
            obstacleOne.position = ccp(obstacleOne.position.x,  obstacleOne.position.y + 350);
        }
        
        //OBSTACLES NOT TO SPAWN IN EACH OTHER
        if ([obstacleOne collision:obstacleTwo]) {
            obstacleOne.position = ccp(-100, -100);
        }
        
        if ([obstacleOne collision:bigObstacle]) {
            obstacleOne.position = ccp(-100, -100);
        }
        
        if ([obstacleTwo collision:bigObstacle]) {
            obstacleTwo.position = ccp(-100, -100);
        }
        
        //HIDE THE TUNNLE IF ITS OF SCREEN
        if (tunnel.position.y <= -400) {
            tunnel.position = ccp(-200, 100000);
            textureChanged = NO;
        }
        
        //IF ITS TIME TO CHANGE MAP THE TUNNLE PUTS IT ON THE MAP
        if (score/10 >= changeScore && level < 4 ) {
            tunnel.position = ccp(160, 1000);
            changeScore += [Game sharedGame].changeScore;
        }
        
        //IF THE TEXTURE ISN'T CHANGED CHANGE IT
        if (textureChanged == NO  && tunnel.position.y-50  < 240) {
            level += 1;
            gameSpeed -= gameSpeed/2;
            [self setTexture];
        }
        
        //NO ENTITYS TO SPAWN IN THE TUNNLE
        if([obstacleOne collision:tunnel]){
            obstacleOne.position = ccp(obstacleOne.position.x, obstacleOne.position.y + 500);
        }
        
        if([obstacleTwo collision:tunnel]){
            obstacleTwo.position = ccp(obstacleTwo.position.x, obstacleTwo.position.y + 500);
        }
        
        if([bigObstacle collision:tunnel]){
            bigObstacle.position = ccp(bigObstacle.position.x, bigObstacle.position.y + 500);
        }
        
        if([movingObstacle collision:tunnel]){
            bigObstacle.position = ccp(bigObstacle.position.x + 500, bigObstacle.position.y);
        }
        
        if ([bottle collision:tunnel]) {
            bottle.position = ccp(bottle.position.x + 500, bottle.position.y);
        }
        
        if ([immortal collision:tunnel]) {
            immortal.position = ccp(immortal.position.x + 500, immortal.position.y);
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
        
        //MOVE EVERYTHING BUT THE CAR ON THE SCREEN
        [background     goX:0   goY:-gameSpeed];
        [tunnel         goX:0   goY:-gameSpeed];
        [obstacleOne    objectGoX:0 objectGoY:-gameSpeed];
        [obstacleTwo    objectGoX:0 objectGoY:-gameSpeed];        
        [bigObstacle    objectGoX:0 objectGoY:-gameSpeed];
        [movingObstacle movingObjectGoX:gameSpeed/2 movingObjectGoY:gameSpeed/3];
        [bottle         objectGoX:0 objectGoY:-gameSpeed]; 
        [immortal       objectGoX:0 objectGoY:-gameSpeed];
        [small          objectGoX:0 objectGoY:-gameSpeed];
        [gun            objectGoX:0 objectGoY:-gameSpeed];
        [slow           objectGoX:0 objectGoY:-gameSpeed];    
        [fast           objectGoX:0 objectGoY:-gameSpeed];
        
        //DECREASES THE POWERUP TIMER
        if(state != 0)
            stateTimer --;
        
        //DECREASES THE SPEED TIMER
        if(speedState != 0)
            speedStateTimer --;
        
        //POWER UP RESETER
        if(state > 0 && stateTimer < 1){
            switch (state) {
                case 1:
                    //ALKOHOLE - SETS THE CAR STRAIGHT AGAIN
                    drunk = NO;
                    car.rotation = 0;
                    break;
                case 2:
                    //IMMORTAL - REMOVES THE OPACITY
                    car.opacity = 255;
                    break;
                case 3:
                    //SMALL - BECOMES BIG AGAIN
                    [car runAction:[CCScaleTo actionWithDuration:.3 scale:1]];
                    break;
                case 4:
                    //GUN - MOVES THE GUN AND THE BULLET OFF SCREEN
                    bullet.position = ccp(1000, 1000);
                    carGun.position = ccp(1000, 1000);
                    break;
                default:
                    break;
            }
            //SET TO NORMAL STATE
            state = 0;
        }
        
        //SPEED RESETER
        if (speedState > 0 && speedStateTimer < 1) {
            gameSpeed = realGameSpeed;
            speedState = 0;
        }
        
        //IF DRUNCK THE CAR ROTATES
        if(state == 1){
            car.rotation += 1.2;
        }        
        
        //If the player isn't affected by a powerup and collide with a bottle of alcohol the player
        //becomes drunk, and the bottle will be moved off screen
        if(state == 0  && [bottle collision:car]){
            state = 1;
            stateTimer = 300;
            bottle.position = ccp(-100, 100);
            drunk = YES;
        }
        
        //If the player isn't affected by a powerup and collide with an unit of immortility the player
        //becomes immortal, and the unit of imortility will be moved off screen
        if (state == 0 && [immortal collision:car]) {
            state = 2;
            stateTimer = 300;
            immortal.position = ccp(-100, 100);
            car.opacity = 160;
        }

        //If the player isn't affected by a powerup and collide with an unit of small the player
        //becomes smaller, and the unit of snall will be moved off screen
        if (state == 0 && [small collision:car]) {
            state = 3;
            stateTimer = 300;
            small.position = ccp(-100, 100);
            [car runAction:[CCScaleTo actionWithDuration:.3 scale:0.75]];
        }
        
        //If the player isn't affected by a powerup and collide with an unit of gun the player
        //gets a gun that fires bullets, and the unit of gun will be moved off screen
        if (state == 0 && [gun collision:car]) {
            state = 4;
            stateTimer = 300;
            gun.position = ccp(-100, 100);
            carGun.position = ccp(car.position.x, car.position.y +10);
            bullet.position = car.position;
        }
        
        //If the player isn't affected by a speedchange and collide with an unit of slow the player
        //gamespeed will decrease
        if (speedState == 0 && [slow collision:car]){
            speedState = 1;
            speedStateTimer = 300;
            realGameSpeed = gameSpeed;
            gameSpeed -= gameSpeed/4;
        }
        
        //If the player isn't affected by a speedchange and collide with an unit of fast the player
        //gamespeed will increase.
        if (speedState == 0 && [fast collision:car]){
            speedState = 2;
            speedStateTimer = 300;
            realGameSpeed = gameSpeed;
            gameSpeed += gameSpeed/4;
        }
        
        //THE GUN IS ON THE CAR
        if(state == 4){
            [bullet objectGoX:0 objectGoY:gameSpeed + 1 car:car.position];
            carGun.position = ccp(car.position.x, car.position.y +10);
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
        if(([bigObstacle collision:car] || [obstacleOne collision:car] || [obstacleTwo collision:car] || [movingObstacle collision:car]) && state != 2){
            playing = NO;
            [self saveState];
            [SceneManager goGameOver];
        }    
        
        //CURRENTSCORE
        score += (1 * [car scoreMultiplier]);
        [scoreLabel setString:[NSString stringWithFormat:@"%i",score/10]];
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
        playing = NO;
        
        [[SimpleAudioEngine sharedEngine] setEffectsVolume:0];
        [menu setOpacity:0];
        
        [[CCDirector sharedDirector] pause];
        
        CCMenuItemImage *returnButton = [CCMenuItemImage itemFromNormalImage:@"pause-continue1.png" selectedImage:@"pause-continue2.png" target:self selector:@selector(pauseMenuItemClicked:)];
        music = [CCMenuItemImage itemFromNormalImage:@"sound-music1.png" selectedImage:@"sound-music1.png" target:self selector:@selector(musicButtonClicked:)];
        sfx = [CCMenuItemImage itemFromNormalImage:@"sound-sfx1.png" selectedImage:@"sound-sfx1.png" target:self selector:@selector(sfxButtonClicked:)];
        
        CCMenuItemImage *menuButton = [CCMenuItemImage itemFromNormalImage:@"pause-mainmenu1.png" selectedImage:@"pause-mainmenu2.png" target:self selector:@selector(pauseMenuItemClicked:)];
        
        returnButton.position = ccp(0, 100);
        music.position = ccp(-65, 0);
        sfx.position = ccp(65, 0);
        menuButton.position = ccp(0, -100);
        
        returnButton.tag = 1;
        menuButton.tag = 2;
        
        [self checkMusic];
        [self checkSfx];
        
        pauseMenu = [CCMenu menuWithItems:returnButton, music, sfx, menuButton, nil];
        [self addChild:pauseMenu];
        
        
    }
    
}

-(void)pauseMenuItemClicked:(id)sender{
    switch ([sender tag]) {
        case 1:
            playing = YES;
            [menu setOpacity:255];
            [[CCDirector sharedDirector] resume];
            [self removeChild:pauseMenu cleanup:YES];
            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"muteSfx"])
                [[SimpleAudioEngine sharedEngine] setEffectsVolume:0];
            else
                [[SimpleAudioEngine sharedEngine] setEffectsVolume:1];
            break;
        case 2:
            [[CCDirector sharedDirector] resume];
            [Game sharedGame].musicPlaying = NO;
            [SceneManager goMenu];
            [[Game sharedGame]resetGame];
            break;            
        default:
            break;
    }
}

    /* musicButtonClicked:(id)sender
     *
     * turn on/off music
     *
     */
-(void)musicButtonClicked:(id)sender
{
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"music"]){
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"music.mp3"];
        [Game sharedGame].musicPlaying = YES;
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"music"];        
    }else{
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        [Game sharedGame].musicPlaying = NO;
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"music"];        
    }
    
    [self checkMusic];
}

    /* sfxButtonClicked:(id)sender
     *
     * turn on/off sfx
     *
     */
-(void)sfxButtonClicked:(id)sender
{
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"muteSfx"])
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"muteSfx"];
    else     
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"muteSfx"];
    
    [self checkSfx];
}

    /* speedChange:(ccTime) dt
     * 
     * increase the speed
     */

-(void)speedChange:(ccTime) dt
{
    gameSpeed += .1;
    realGameSpeed += .1;
}

    /* setTexture
     *
     * changes texture if it is a level change
     */

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
        obstacleTwo.rotation = 320;
        bigObstacleTexture = [[CCTexture2D alloc] initWithImage:[UIImage imageNamed:@"sand-bigObstacle.png"]];
        movingTexture1 = [[CCTexture2D alloc] initWithImage:[UIImage imageNamed:@"sand-moving1.png"]];
        movingTexture2 = [[CCTexture2D alloc] initWithImage:[UIImage imageNamed:@"sand-moving2.png"]];
        repeatRate = 79;
    }else if (level == 3){
        roadTexture = [[CCTexture2D alloc] initWithImage:[UIImage imageNamed:@"iceroad.png"]];
        obstacleOneTexture = [[CCTexture2D alloc] initWithImage:[UIImage imageNamed:@"ice-obstacleOne.png"]];
        obstacleTwoTexture = [[CCTexture2D alloc] initWithImage:[UIImage imageNamed:@"ice-obstacleTwo.png"]];
        obstacleTwo.rotation = 0;
        bigObstacleTexture = [[CCTexture2D alloc] initWithImage:[UIImage imageNamed:@"ice-bigObstacle.png"]];
        movingTexture1 = [[CCTexture2D alloc] initWithImage:[UIImage imageNamed:@"ice-moving1.png"]];
        movingTexture2 = [[CCTexture2D alloc] initWithImage:[UIImage imageNamed:@"ice-moving2.png"]];
        repeatRate = 64;
    }else if(level >= 4){
        roadTexture = [[CCTexture2D alloc] initWithImage:[UIImage imageNamed:@"rainbow.png"]];
        obstacleOneTexture = [[CCTexture2D alloc] initWithImage:[UIImage imageNamed:@"rainbow-obstacleOne.png"]];
        obstacleTwoTexture = [[CCTexture2D alloc] initWithImage:[UIImage imageNamed:@"rainbow-obstacleTwo.png"]];
        bigObstacleTexture = [[CCTexture2D alloc] initWithImage:[UIImage imageNamed:@"rainbow-bigObstacle.png"]];
        movingTexture1 = [[CCTexture2D alloc] initWithImage:[UIImage imageNamed:@"rainbow-moving1.png"]];
        movingTexture2 = [[CCTexture2D alloc] initWithImage:[UIImage imageNamed:@"rainbow-moving2.png"]];
        movingObstacle.rotation = 0;
        repeatRate = 41;
    }
    
    [background setTexture:roadTexture];
    [obstacleOne setTexture:obstacleOneTexture];
    [obstacleOne setTextureRect:CGRectMake(0, 0, obstacleOneTexture.contentSize.width, obstacleOneTexture.contentSize.height)];
    [obstacleTwo setTexture:obstacleTwoTexture];    
    [obstacleTwo setTextureRect:CGRectMake(0, 0, obstacleTwoTexture.contentSize.width, obstacleTwoTexture.contentSize.height)];
    [bigObstacle setTexture:bigObstacleTexture];
    [bigObstacle setTextureRect:CGRectMake(0, 0, bigObstacleTexture.contentSize.width, bigObstacleTexture.contentSize.height)];
    [movingObstacle setTexture:movingTexture1];
    [movingObstacle setTextureRect:CGRectMake(0, 0, movingTexture1.contentSize.width, movingTexture1.contentSize.height)];
    
    
    [roadTexture release];
    [obstacleOneTexture release];
    [obstacleTwoTexture release];
    [bigObstacleTexture release];
    
    textureChanged = YES;
}

    /* saveState
     *
     * saves the current state of the game
     *
     */

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
    [Game sharedGame].movingObstaclePosition = movingObstacle.position;
    
    [Game sharedGame].bottlePosition = bottle.position;
    [Game sharedGame].immortalPosition = immortal.position;
    [Game sharedGame].gunPosition = gun.position;
    [Game sharedGame].bulletPosition = bullet.position;
    [Game sharedGame].carGunPosition = carGun.position;
    [Game sharedGame].smallPosition = small.position;
    [Game sharedGame].fastPosition = fast.position;
    [Game sharedGame].slowPosition = slow.position;
    [Game sharedGame].tunnelPosition = tunnel.position;
}

/* checkMusic
* 
* sets the texture for the music on/off switch
*
*/

-(void)checkMusic
{
    NSString *musicImage;
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"music"])
        musicImage = @"sound-music2.png";
    else
        musicImage = @"sound-music1.png";
    
    
    CCMenuItemImage *musicButton = [CCMenuItemImage itemFromNormalImage:musicImage selectedImage:musicImage];
    [music setNormalImage:musicButton];
}

/* checkSfx
 * 
 * sets the texture for the sfx on/off switch
 *
 */
-(void) checkSfx
{
    NSString *sfxImage;
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"muteSfx"])
        sfxImage = @"sound-sfx2.png";
    else
        sfxImage = @"sound-sfx1.png";
   
    CCMenuItemImage *sfxButton = [CCMenuItemImage itemFromNormalImage:sfxImage selectedImage:sfxImage];
    [sfx setNormalImage:sfxButton];
}

/* movingTexture
 * 
 * switches images for the animated movingobstacle and that creates a moving feel off the object 
 *
 */

-(void) movingTexture:(ccTime) dt
{
    if(movingTexture == 1){
        movingTexture = 2;
        [movingObstacle setTexture:movingTexture1];
    }else{
        movingTexture = 1;
        [movingObstacle setTexture:movingTexture2];
    }
    
}

- (void) dealloc
{
    [car release];
    [background release];
    [tunnel release];
    [obstacleOne release];
    [obstacleTwo release];
    [bigObstacle release];    
    [movingObstacle release];
    [movingTexture1 release];
    [movingTexture2 release];
    [bottle release];
    [immortal release];
    [small release];
    [fast release];
    [slow release];
    [gun release];
    [bullet release];
    [carColor release];
    
    //RELEASE TEXTURE
    [CCSpriteFrameCache purgeSharedSpriteFrameCache];
    [CCTextureCache purgeSharedTextureCache];
    
	[super dealloc];

}

@end
