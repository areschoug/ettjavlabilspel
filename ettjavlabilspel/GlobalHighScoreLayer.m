//
//  GlobalHighScoreLayer.m
//  ettjavlabilspel
//
//  Created by Andreas Areschoug on 2011-11-04.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GlobalHighScoreLayer.h"


@implementation GlobalHighScoreLayer

-(id)init
{
    if((self=[super init])){
        CCSprite *background = [[CCSprite alloc] initWithFile:@"mainscreen-background.png"];
        background.position = ccp(160, 240);
        [self addChild:background];
        [background release];
        
        CCMenu *menu;
        CCMenuItemImage *changeButton = [CCMenuItemImage itemFromNormalImage:@"local-button1.png" selectedImage:@"local-button2.png" target:self selector:@selector(changeHighscoreList:)];
        CCMenuItemImage *backButton = [CCMenuItemImage itemFromNormalImage:@"back-button1.png" selectedImage:@"back-button2.png" target:self selector:@selector(backButtonClicked:)];
        backButton.position = ccp(250, 420);        
        changeButton.position = ccp(100, 420);
        
        responsData = [[NSMutableData data] retain];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://animalweekend.com/Asger/Highscore/get_score.php?startlimit=0&endlimit=10"]];
        [[NSURLConnection alloc] initWithRequest:request delegate:self];        
        
        menu = [CCMenu menuWithItems:backButton,changeButton, nil];
        menu.position = ccp(0, 0);
        
        [self addChild:menu];
        
        
        
    }
    return self;
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
    
    int position = 350;
    
    CCLabelTTF *headLine = [CCLabelTTF labelWithString:@"Global Highscore" fontName:@"helvetica" fontSize:22];
    headLine.position = ccp(160, position);
    [self addChild:headLine];
    
    for (int i = 0; i < [responseArray count]; i++) {
        NSMutableDictionary *responseDictionary = [responseArray objectAtIndex:i];
        NSString *username = [NSString stringWithFormat:[responseDictionary objectForKey:@"username"] ];
        NSString *highscore = [NSString stringWithFormat:[responseDictionary objectForKey:@"highscore"] ];
        NSString *printString = [NSString stringWithFormat:@"%@ - %@",username,highscore];
        
        position -= 30;
        
        CCLabelTTF *scoreLable = [CCLabelTTF labelWithString:printString fontName:@"helvetica" fontSize:22];
        scoreLable.position = ccp(160, position);
        [self addChild:scoreLable];
    }
}

-(void) printArrayItems:(id)obj{
    NSLog(@"%@",obj);
}

-(void) changeHighscoreList:(id)sender
{
    [SceneManager goHighScore];
}

-(void) backButtonClicked:(id) sender
{
    [SceneManager goMenu];
}

- (void)dealloc
{
    [super dealloc];
}

@end
