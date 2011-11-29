//
//  MenuLayer.m
//  ettjavlabilspel
//
//  Created by Andreas Areschoug.
//

#import "MenuLayer.h"

@implementation MenuLayer

@synthesize username,password;

- (id)init
{
    NSLog(@"MenuLayer init");
    self = [super init];

    background = [[CCSprite alloc] initWithFile:@"cityroad.png"];
    background.position = ccp(160, 240);
    [self addChild:background];

    burningCarTexture1 = [[CCTexture2D alloc] initWithImage:[UIImage imageNamed:@"mainscreen-car1.png"]];
    burningCarTexture2 = [[CCTexture2D alloc] initWithImage:[UIImage imageNamed:@"mainscreen-car2.png"]];

    texture = 1;
    
    backgroundCar = [[CCSprite alloc] initWithFile:@"mainscreen-car1.png"];
    [backgroundCar setTexture:burningCarTexture1];
    backgroundCar.position = ccp(160, 150);
    [self addChild:backgroundCar];
    
    CCMenu *menu;
    
    CCMenuItemImage *logo = [CCMenuItemImage itemFromNormalImage:@"mainscreen-logo.png" selectedImage:@"mainscreen-logo.png"];
    CCMenuItemImage *newGameButton = [CCMenuItemImage itemFromNormalImage:@"mainscreen-newgame1.png" selectedImage:@"mainscreen-newgame2.png" target:self selector:@selector(onMenuItemClicked:)];
    CCMenuItemImage *highScoreButton = [CCMenuItemImage itemFromNormalImage:@"mainscreen-highscore1.png" selectedImage:@"mainscreen-highscore2.png" target:self selector:@selector(onMenuItemClicked:)];
    CCMenuItemImage *settingsButton = [CCMenuItemImage itemFromNormalImage:@"mainscreen-settings1.png" selectedImage:@"mainscreen-settings2.png" target:self selector:@selector(onMenuItemClicked:)];
    CCMenuItemImage *instructionsButton = [CCMenuItemImage itemFromNormalImage:@"mainscreen-instructions1.png" selectedImage:@"mainscreen-instructions2.png" target:self selector:@selector(onMenuItemClicked:)];
    [newGameButton setTag:1];
    [highScoreButton setTag:2];
    [settingsButton setTag:3];
    [instructionsButton setTag:4];
    
    logo.position = ccp(160, 400);
    newGameButton.position = ccp(135, 300);
    highScoreButton.position = ccp(220, 235);
    settingsButton.position = ccp(235, 170);
    instructionsButton.position = ccp(90, 200);

    menu = [CCMenu menuWithItems:logo,highScoreButton,newGameButton,settingsButton,instructionsButton, nil];
    menu.position = ccp(0, 0);
    
    //TÖM HIGHSCORE ARRAYEN
    /*
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:100];
    [[NSUserDefaults standardUserDefaults]setObject:array forKey:@"highScoreArray"];
     */    
    [self addChild:menu];
    
    

    if ([[MPMusicPlayerController iPodMusicPlayer] playbackState] != MPMusicPlaybackStatePlaying && [[NSUserDefaults standardUserDefaults] boolForKey:@"music"] && ![Game sharedGame].musicPlaying) {
        [[SimpleAudioEngine sharedEngine]playBackgroundMusic:@"menu_music.mp3"];
        [Game sharedGame].musicPlaying = YES;
    }

    [self schedule:@selector(burningCar:) interval:.3];
    
    return self;
}

-(void)burningCar:(ccTime)dt
{
    if(texture == 1){
        texture = 2;
        [backgroundCar setTexture:burningCarTexture1];
    }else{
        texture = 1;
        [backgroundCar setTexture:burningCarTexture2];
    }
    
}

-(void)onMenuItemClicked:(id)sender
{
    switch ([sender tag]) {
        case 1:
            [SceneManager goCarSelect];
            break;
        case 2:
            if ([[NSUserDefaults standardUserDefaults] stringForKey:@"savedUsername"] == nil  && [[NSUserDefaults standardUserDefaults] stringForKey:@"savedPassword"] == nil) {
                [self promptLogin];
            }else{
                [SceneManager goHighScore];
            }
            break;
        case 3:
            [SceneManager goSettings];
            break;
        case 4:
            [SceneManager goInstructions];
            break;
        default:
            break;
    }
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != [alertView cancelButtonIndex]){

        responsData = [[NSMutableData data] retain];
        
        self.username = nameField.text;
        self.password = passwordField.text;
        
        if (username.length > 4 && password.length > 4) {
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://ettjavlabilspel.com/set_user_score.php?username=%@&password=%@&score=0",self.username,self.password]]];
            [[NSURLConnection alloc] initWithRequest:request delegate:self]; 
        }else{
            loginError = 2;
            [self promptLogin];
        }
        
    }
}                

-(void)promptLogin
{

    UIAlertView *dialog;
    
    if (loginError == 0) {
        dialog = [[UIAlertView alloc] initWithTitle:@"Create or Login" message:@"\n\n\n" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Submit", nil];
        nameField = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 50.0, 260.0, 25.0)];
        passwordField = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 85.0, 260.0, 25.0)];
    }else if(loginError == 1){
        dialog = [[UIAlertView alloc] initWithTitle:@"Create or Login" message:@"Username taken or password wrong \n\n\n\n" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Submit", nil];
        nameField = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 70.0, 260.0, 25.0)];   
        passwordField = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 105.0, 260.0, 25.0)];
    }else{
        dialog = [[UIAlertView alloc] initWithTitle:@"Create or Login" message:@"*1 Username taken or password wrong \n\n\n\n" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Submit", nil];
        nameField = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 70.0, 260.0, 25.0)];   
        passwordField = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 105.0, 260.0, 25.0)];    
    }
    
    

    [nameField setBackgroundColor:[UIColor whiteColor]];
    [nameField setPlaceholder:@"username"];
    [dialog addSubview:nameField];
    [passwordField setBackgroundColor:[UIColor whiteColor]];
    [passwordField setPlaceholder:@"password"];
    [dialog addSubview:passwordField];
    
    
    [dialog setTransform: CGAffineTransformMakeTranslation(0.0, 20.0)];
    [dialog show];
    [nameField becomeFirstResponder];
    [dialog release];
    [nameField release];
    [passwordField release];

}

-(void)backButtonClicked:(id) sender
{  
    [SceneManager goMenu];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [responsData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [responsData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"ERROR: %@",[error description]);
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [connection release];
    
    NSString *responsString = [[NSString alloc] initWithData:responsData encoding:NSUTF8StringEncoding];
    [responsData release];
    
    NSMutableArray *responseArray = [responsString JSONValue];
    
    NSLog(@"->%@<- %i",responseArray,[responseArray count]);
    
    for (int i = 0; i < [responseArray count]; i++) {
        NSMutableDictionary *responseDic = [responseArray objectAtIndex:i];
        NSLog(@" -> %@",[responseDic objectForKey:@"success"]);
        int success = [[responseDic objectForKey:@"success"] intValue];
        NSLog(@"success - %i",success);
        if ( success == 1) {
            NSLog(@"USERNAME - %@",self.username);
            NSLog(@"USERNAME - %@",self.password);
            [[NSUserDefaults standardUserDefaults] setObject:username forKey:@"savedUsername"];
            [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"savedPassword"];            
            [SceneManager goHighScore
];
            return;
        }
    }
    loginError = 1;
    [self promptLogin];        
}

- (void)dealloc {
    [background release];
    [backgroundCar release];
    [self.username release];
    [self.password release];
    [super dealloc];
}

@end
