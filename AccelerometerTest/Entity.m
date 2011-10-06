#import "Entity.h"


@implementation Entity

@synthesize startingPoints;

-(Entity *) init{
    self = [super init];
    if(self != nil){
        NSLog(@"init - %p",self);
        startingPoints = [[NSMutableArray alloc] initWithCapacity:10];
    }
    return self;
}



-(BOOL)collision:(CCSprite *)obj{
    CGRect selfSprite = CGRectMake((self.position.x-(self.contentSize.width/2)), (self.position.y-(self.contentSize.height/2)), self.contentSize.width, self.contentSize.height);
    
    CGRect objSprite = CGRectMake((obj.position.x-(obj.contentSize.width/2)), (obj.position.y-(obj.contentSize.height/2)), obj.contentSize.width, obj.contentSize.height);
    return (CGRectIntersectsRect(selfSprite, objSprite));
}

-(int)getRandomNumber:(int)from to:(int)to {
    return (int)from + arc4random() % (to-from+1);
}

-(CGPoint)getStartPositions:(int)range
{
    int y = [self getRandomNumber:480 to:(480+range)];
    int x = [[startingPoints objectAtIndex:[self getRandomNumber:0 to:([startingPoints count]-1)]]intValue];  
    return ccp(x,y);
}

-(void)goX:(int)distanceX goY:(int)distanceY{
    self.position = ccp(self.position.x+distanceX, self.position.y+distanceY);
}

-(void)dealloc{
    NSLog(@"DEALLOC ENTITY - %p",self);
    [startingPoints release];
    [super dealloc];
}

@end
