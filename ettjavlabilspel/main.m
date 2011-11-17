//
//  main.m
//  AccelerometerTest
//
//  Created by Andreas Areschoug on 2011-09-12.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

int main(int argc, char *argv[]) {
    NSLog(@"-- -- MAIN KÖRS -- --");
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, @"AppDelegate");
    [pool release];
    return retVal;
}
