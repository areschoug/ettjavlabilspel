//
//  HighScoreScene.m
//  AccelerometerTest
//
//  Created by Andreas Areschoug on 2011-09-27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HighScoreScene.h"


@implementation HighScoreScene


+(CCScene *) scene
{
    CCScene *scene = [CCScene node];
    
    HighScoreScene *layer = [HighScoreScene node];
    
    [scene addChild:layer];
    
    return scene;
}

-(id)init
{
    if((self=[super init])){
        // NSUserDefaults -> få ut arrayen -> sorted-arrayen
        // Här borde den läsa in den så kallade NSUserDefaults med en array i sig som sorteras och
        // eventuellt behöver man inte kapa av den om jag kommer på ett bra sätt att får ner listan till
        // max 5(,10 eller något som passar)
        //
        // NSUserDefaults -> få ut string -> sätts ut på skärmen
        // Kolla igenom alla och placera där den ska vara. På highscore sidan så repiterar man en massa CCLableAtlas
        // (Kanske inte så kul att ha samma kod över allt)
        //
        // .plist något 
        // (ANTAGLIGEN INTE SÅ BRA)
        
        
        NSArray *highScores,*sorted;
        highScores = [[NSUserDefaults standardUserDefaults]arrayForKey:@"highScoreArray"];
        sorted = [highScores sortedArrayUsingSelector:@selector(compare:)];
        int distance = 400;
        
        for (int i = ([sorted count] - 1); ([sorted count]-6) < i; i--) {
            distance -= 50;
            
            CCLabelAtlas *scoreLabel = [CCLabelAtlas labelWithString:[NSString stringWithFormat:@"%@", [sorted objectAtIndex:i]] charMapFile:@"fps_images.png" itemWidth:16 itemHeight:48 startCharMap:'.'];
            scoreLabel.position = ccp(15, (distance));
            [self addChild:scoreLabel];
        }
        
        
        CCMenu *menu;
        
        CCMenuItemImage *backButton = [CCMenuItemImage itemFromNormalImage:@"pause.png" selectedImage:@"pause.png" target:self selector:@selector(backButtonClicked:)];
                
        menu = [CCMenu menuWithItems:backButton, nil];
        menu.position = ccp(270, 455);
        /*
        CCLabelAtlas *scoreLabel2 = [CCLabelAtlas labelWithString:[NSString stringWithFormat:@"%i",[[NSUserDefaults standardUserDefaults]integerForKey:@"highScore"]] charMapFile:@"fps_images.png" itemWidth:16 itemHeight:48 startCharMap:'.'];
        scoreLabel2.position = ccp(160, 200);
        [self addChild:scoreLabel2];        
        */
        [self addChild:menu];
    }
    return self;
}

-(void)backButtonClicked:(id) sender{  
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[HelloWorldLayer node]]];
}

-(void)dealloc{
    NSLog(@"DEALLOC - HIGH SCORE SCENE ENDED %@",self);
    [super dealloc];
}

@end
