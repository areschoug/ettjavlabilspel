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
        responsData = [[NSMutableData data] retain];
        int highestScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"highestScore"];
        NSString *username = [[NSUserDefaults standardUserDefaults] stringForKey:@"savedUsername"];
        NSString *password = [[NSUserDefaults standardUserDefaults] stringForKey:@"savedPassword"];
        NSString *url = [NSString stringWithFormat:@"http://ettjavlabilspel.com/get_highscore.php?username=%@&password=%@&score=%i",username,password,highestScore];
        
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        [[NSURLConnection alloc] initWithRequest:request delegate:self];        
        
        CCSprite *background = [[CCSprite alloc] initWithFile:@"cityroad.png"];
        background.position = ccp(160, 240);
        [self addChild:background];
        [background release];

        CCSprite *textBackground = [[CCSprite alloc] initWithFile:@"highscore-text.png"];
        textBackground.position = ccp(160, 240);
        [self addChild:textBackground];
        [textBackground release];

        
        
        loading = [CCLabelTTF labelWithString:@"Loading..." fontName:@"helvetica" fontSize:22];
        loading.position = ccp(160, 370);
        loading.color = ccc3(17, 44, 0);
        [self addChild:loading];
        
        CCMenu *menu;
        CCMenuItemImage *backButton = [CCMenuItemImage itemFromNormalImage:@"back-button1.png" selectedImage:@"back-button2.png" target:self selector:@selector(backButtonClicked:)];
        backButton.position = ccp(250, 420);        
        
        menu = [CCMenu menuWithItems:backButton, nil];
        menu.position = ccp(0, 0);

        [self addChild:menu];
    }
    return self;
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
 
    NSMutableArray *responsArray = [responsString JSONValue];
    
    NSMutableDictionary *responseDictionary = [responsArray objectAtIndex:0];
    NSMutableArray *yourArray = [responseDictionary objectForKey:@"yourscore"];
    NSMutableDictionary *yourDictionary = [yourArray objectAtIndex:0];    
    NSString *positionString = [NSString stringWithFormat:@"You are ranked %@ in the world!",[yourDictionary objectForKey:@"position"]];
    
    CCLabelTTF *worldPositon = [CCLabelTTF labelWithString:positionString fontName:@"helvetica" fontSize:18];
    worldPositon.position = ccp(160, 115);
    worldPositon.color = ccc3(255, 0, 0);
    [self addChild:worldPositon];

    int position = 350;

    [self removeChild:loading cleanup:YES];
    CCLabelTTF *headLine = [CCLabelTTF labelWithString:@"Global Highscore" fontName:@"helvetica" fontSize:22];
    headLine.position = ccp(160, position);
    headLine.color = ccc3(17, 44, 0);
    [self addChild:headLine];
    
    
    NSMutableArray *topArray = [responseDictionary objectForKey:@"topten"];    
    for (int i = 0; [topArray count] > i ; i++) {
        NSMutableDictionary *topDictionary = [topArray objectAtIndex:i];
        NSString *username = [NSString stringWithFormat:[topDictionary objectForKey:@"username"] ];
        NSString *highscore = [NSString stringWithFormat:[topDictionary objectForKey:@"highscore"] ];
        NSString *printString = [NSString stringWithFormat:@"%@ - %@",username,highscore];
        
        position -= 20;
        
        CCLabelTTF *scoreLable = [CCLabelTTF labelWithString:printString fontName:@"helvetica" fontSize:18];
        scoreLable.position = ccp(160, position);
        scoreLable.color = ccc3(17, 44, 0);
        [self addChild:scoreLable];
        
    }
}


- (void)dealloc {
    [super dealloc];
}

@end
