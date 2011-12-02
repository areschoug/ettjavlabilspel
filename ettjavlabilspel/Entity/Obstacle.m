//
//  Obstacle.m
//  ettjavlabilspel
//
//  Created by Andreas Areschoug.
//

#import "Obstacle.h"

@implementation Obstacle


-(Obstacle *) init{
    self = [super init];
    if(self != nil){
        NSLog(@"init Hole - %p",self);
        [startingPoints addObject:@"64"];
        [startingPoints addObject:@"128"];
        [startingPoints addObject:@"192"];
        [startingPoints addObject:@"256"];
        startRate = 1000;
    }
    return self;
}

-(void)dealloc{
    [super dealloc];
}

@end
