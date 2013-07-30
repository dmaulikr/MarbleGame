//
//  AppDelegate.h
//  MarbleGame
//
//  Created by Carsten Müller on 7/30/13.
//  Copyright Carsten Müller 2013. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"

// Added only for iOS 6 support
@interface MyNavigationController : UINavigationController <CCDirectorDelegate>
@end

@interface MarbleGameAppDelegate : NSObject <UIApplicationDelegate>
{
	UIWindow *window_;
	MyNavigationController *navController_;
	
	CCDirectorIOS	*director_;							// weak ref
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (readonly) MyNavigationController *navController;
@property (readonly) CCDirectorIOS *director;

@end
