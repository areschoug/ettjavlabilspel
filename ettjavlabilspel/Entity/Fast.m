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
        [startingPoints addObject:@"64"];
        [startingPoints addObject:@"128"];
        [startingPoints addObject:@"192"];
        [startingPoints addObject:@"256"]; 
        startRate = 3000;
    }
    return self;
}

- (void)dealloc {
    NSLog(@"DEALLOC FAST - %p",self);
    [super dealloc];
}

@end
