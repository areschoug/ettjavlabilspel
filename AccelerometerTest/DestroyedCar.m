#import "DestroyedCar.h"

@implementation DestroyedCar

- (id)init
{
    self = [super init];
    if(self != nil){
        NSLog(@"init Destroyed - %p",self);
        [startingPoints addObject:@"70"];
        [startingPoints addObject:@"130"];
        [startingPoints addObject:@"190"];
        [startingPoints addObject:@"220"];
        [startingPoints addObject:@"250"];
        
    }
    return self;

}

-(void)dealloc{
    NSLog(@"DEALLOC DESTROYED CAR - %p",self);
    [super dealloc];
}
@end
