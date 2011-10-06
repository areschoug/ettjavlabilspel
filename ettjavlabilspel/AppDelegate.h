//
//  AppDelegate.h
//  ettjavlabilspel
//
//  Created by Andreas Areschoug.
//


#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
