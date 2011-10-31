#import "Hole.h"


@implementation Hole


-(Hole *) init{
    self = [super init];
    if(self != nil){
        NSLog(@"init Hole - %p",self);
        [startingPoints addObject:@"40"];
        [startingPoints addObject:@"100"];
        [startingPoints addObject:@"160"];
        [startingPoints addObject:@"220"];
        [startingPoints addObject:@"280"];
        startRate = 300;
    }
    return self;
}
-(void)dealloc{
    NSLog(@"DEALLOC HOLE - %p",self);
    [super dealloc];
}

@end
