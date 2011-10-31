//
//  Small.m
//  ettjavlabilspel
//
//  Created by Andreas Areschoug on 2011-10-28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Small.h"


@implementation Small

-(Small *)init{
    self = [super init];
    if (self != nil) {
        NSLog(@"init Invincible - %p",self);
        [startingPoints addObject:@"40"];
        [startingPoints addObject:@"100"];
        [startingPoints addObject:@"160"];
        [startingPoints addObject:@"220"];
        [startingPoints addObject:@"280"]; 
        startRate = 1000;
    }
    return self;
}

-(void)dealloc{
    NSLog(@"DEALLOC SMALL - %p",self);
    [super dealloc];
}

@end
