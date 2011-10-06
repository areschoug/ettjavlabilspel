#import "Alcohol.h"

@implementation Alcohol

-(Alcohol *) init{
    self = [super init];
    if(self != nil){
        NSLog(@"init Alcohol - %p",self);
        [startingPoints addObject:@"40"];
        [startingPoints addObject:@"100"];
        [startingPoints addObject:@"160"];
        [startingPoints addObject:@"220"];
        [startingPoints addObject:@"280"];
    }
    return self;
}

-(void)dealloc{
    NSLog(@"DEALLOC HOLE - %p",self);
    [super dealloc];
}

@end
