//
//  Invincible.m
//  ettjavlabilspel
//
//  Created by Andreas Areschoug.
//

#import "Immortal.h"

@implementation Immortal

-(Immortal *)init{
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
    NSLog(@"DEALLOC INVINCIBLE - %p",self);
    [super dealloc];
}

@end
