#import "BigObstacle.h"

@implementation BigObstacle

- (id)init
{
    self = [super init];
    if(self != nil){
        NSLog(@"init Destroyed - %p",self);
        [startingPoints addObject:@"96"];
        [startingPoints addObject:@"160"];
        [startingPoints addObject:@"224"];
        startRate = 1500;
    }
    return self;

}

-(void)dealloc{
    NSLog(@"DEALLOC DESTROYED CAR - %p",self);
    [super dealloc];
}
@end
