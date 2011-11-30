//
//  Alcohol.m
//  ettjavlabilspel
//
//  Created by Andreas Areschoug.
//

#import "Alcohol.h"

@implementation Alcohol

-(Alcohol *) init{
    self = [super init];
    if(self != nil){
        NSLog(@"init Alcohol - %p",self);
        [startingPoints addObject:@"64"];
        [startingPoints addObject:@"128"];
        [startingPoints addObject:@"192"];
        [startingPoints addObject:@"256"];
        startRate = 3000;
    }
    return self;
}

-(void)dealloc{
    NSLog(@"DEALLOC ALCOHOLE - %p",self);
    [super dealloc];
}

@end
