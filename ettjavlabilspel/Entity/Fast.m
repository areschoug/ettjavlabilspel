//
//  Fast.m
//  ettjavlabilspel
//
//  Created by Andreas Areschoug on 2011-10-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Fast.h"


@implementation Fast

-(Fast *)init{
    self = [super init];
    if (self != nil) {
        NSLog(@"init Fast - %p",self);
        [startingPoints addObject:@"40"];
        [startingPoints addObject:@"100"];
        [startingPoints addObject:@"160"];
        [startingPoints addObject:@"220"];
        [startingPoints addObject:@"280"]; 
        startRate = 1000;
    }
    return self;
}

- (void)dealloc {
    NSLog(@"DEALLOC FAST - %p",self);
    [super dealloc];
}

@end
