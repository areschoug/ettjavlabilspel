//
//  Slow.m
//  ettjavlabilspel
//
//  Created by Andreas Areschoug.
//

#import "Slow.h"

@implementation Slow

-(Slow *)init{
    self = [super init];
    if (self != nil) {
        NSLog(@"init Slow - %p",self);
        [startingPoints addObject:@"64"];
        [startingPoints addObject:@"128"];
        [startingPoints addObject:@"192"];
        [startingPoints addObject:@"256"];
        startRate = 3000;
    }
    return self;
}

- (void)dealloc {
    NSLog(@"DEALLOC SLOW - %p",self);
    [super dealloc];
}
@end
