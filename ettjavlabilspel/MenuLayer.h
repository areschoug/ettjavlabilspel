//
// MenuLayer.h
// ettjavlabilspel
//
// Created by Andreas Areschoug.
//
// The starting menu of the game where you can choose between new game, setting, highscore, instructions
// If the player hasn't logged in earlier then they will be able to if they click the highscore option.

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SceneManager.h"

#import "SimpleAudioEngine.h"
#import "CDAudioManager.h"
#import "CocosDenshion.h"
#import "SBJson.h"
#import <MediaPlayer/MediaPlayer.h>

@interface MenuLayer : CCLayer
{
    CCSprite *background;
    CCSprite *backgroundCar;
    CCTexture2D *burningCarTexture1;
    CCTexture2D *burningCarTexture2;
    int texture;
    
    UITextField *nameField;
    UITextField *passwordField;
    int loginError;
    NSMutableData *responsData;
    
    NSString *username;
    NSString *password;
}

@property(nonatomic,retain) NSString *username; 
@property(nonatomic,retain) NSString *password;

-(void)promptLogin;
-(void)onMenuItemClicked:(id)sender;
-(void)burningCar:(ccTime)dt;
@end
