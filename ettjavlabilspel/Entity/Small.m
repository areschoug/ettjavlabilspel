//
//  Small.m
//  ettjavlabilspel
//
//  Created by Andreas Areschoug.
//

#import "Small.h"

@implementation Small

-(Small *)init{
    self = [super init];
    if (self != nil) {
        NSLog(@"init Invincible - %p",self);
        [startingPoints addObject:@"64"];
        [startingPoints addObject:@"128"];
        [startingPoints addObject:@"192"];
        [startingPoints addObject:@"256"];
        startRate = 3000;
    }
    return self;
}

-(void)dealloc{
    NSLog(@"DEALLOC SMALL - %p",self);
    [super dealloc];
}

@end
