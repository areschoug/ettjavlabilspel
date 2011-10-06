#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Entity : CCSprite {
    NSMutableArray *startingPoints;
    
}

@property(nonatomic,retain) NSMutableArray *startingPoints;

-(BOOL)collision:(CCSprite *)obj;
-(CGPoint)getStartPositions:(int)range;
-(int)getRandomNumber:(int)from to:(int)to;
-(void)goX:(int)distanceX goY:(int)distanceY;
@end
