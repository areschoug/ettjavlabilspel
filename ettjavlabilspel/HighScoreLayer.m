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
        
        CCSprite *background = [[CCSprite alloc] initWithFile:@"mainscreen-background.png"];
        background.position = ccp(160, 240);
        [self addChild:background];
        [background release];
        
        loading = [CCLabelTTF labelWithString:@"Loading..." fontName:@"helvetica" fontSize:22];
        loading.position = ccp(160, 370);
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

-(void)changeHighscoreList:(id) sender
{   
    [SceneManager goGlobalHighScore];
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
    NSLog(@"dic - %i - %@ - dic",[responseDictionary count],responseDictionary);

    NSMutableArray *yourArray = [responseDictionary objectForKey:@"yourscore"];
    NSMutableDictionary *yourDictionary = [yourArray objectAtIndex:0];    
    NSString *positionString = [NSString stringWithFormat:@"You are ranked %@ in the world!",[yourDictionary objectForKey:@"position"]];
    
    CCLabelTTF *scoreLable = [CCLabelTTF labelWithString:positionString fontName:@"helvetica" fontSize:22];
    [scoreLable setColor:ccc3(255, 0, 0)];
    scoreLable.position = ccp(160, 40);
    
    NSMutableArray *topArray = [responseDictionary objectForKey:@"topten"];
    
    NSLog(@"top array%@",topArray);
    
    int position = 370;
    
    CCLabelTTF *headLine = [CCLabelTTF labelWithString:@"Global Highscore" fontName:@"helvetica" fontSize:22];
    headLine.position = ccp(160, position);
    [self removeChild:loading cleanup:YES];
    [self addChild:headLine];

    
    for (int i = 0; [topArray count] > i ; i++) {
        NSMutableDictionary *topDictionary = [topArray objectAtIndex:i];
        
        NSLog(@" %@ - %i",topDictionary,[topDictionary count]);
        
        NSString *username = [NSString stringWithFormat:[topDictionary objectForKey:@"username"] ];
        NSString *highscore = [NSString stringWithFormat:[topDictionary objectForKey:@"highscore"] ];
        NSString *printString = [NSString stringWithFormat:@"%@ - %@",username,highscore];
        
        position -= 30;
        
        CCLabelTTF *scoreLable = [CCLabelTTF labelWithString:printString fontName:@"helvetica" fontSize:22];
        scoreLable.position = ccp(160, position);
        [self addChild:scoreLable];
        
    }
    

    
    [self addChild:scoreLable];
}


- (void)dealloc {
    [super dealloc];
}

@end
