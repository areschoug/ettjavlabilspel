//
// Entity.h
// ettjavlabilspel
//
// Created by Andreas Areschoug.
//
// 

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Entity : CCSprite {
    NSMutableArray *startingPoints;
    int startRate;
}

@property(nonatomic,retain) NSMutableArray *startingPoints;
@property (readwrite,assign) int startRate;

-(BOOL)collision:(CCSprite *)obj;
-(CGPoint)getStartPositions:(int)range;
-(int)getRandomNumber:(int)from to:(int)to;
-(void)goX:(int)distanceX goY:(int)distanceY;
-(void)objectGoX:(int)distanceX objectGoY:(int)distanceY;
@end
