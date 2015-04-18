//
//  AppDelegate.m
//  BasicSplashView
//
//  Created by 224 on 15/4/18.
//  Copyright (c) 2015年 zoomlgd. All rights reserved.
//

#import "AppDelegate.h"
#import "LYDSplashViewController.h"

@interface AppDelegate ()<LYDSplashViewViewControllerDelegate>

@property (nonatomic, strong) LYDSplashViewController *splashScreen;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self addSplashScreen];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)addSplashScreen {
    self.splashScreen = [[LYDSplashViewController alloc] init];
    self.splashScreen.delegate = self;
    self.splashScreen.transition = ClearFromLeft;
    self.splashScreen.delay = 1.0;
    self.window.rootViewController = self.splashScreen;
}

- (void)splashScreenDidDisappear:(LYDSplashViewController *)splashScreen {
    
	// looping through the transitions for demostration
	// this should be a release of the splashscreenviewcontroller
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    CATransition *animation = [CATransition animation];
    [animation setDuration:1.0];
    [animation setType:kCATransitionFade]; //淡入淡出
    [animation setSubtype:kCATransitionFromLeft];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    self.window.rootViewController = [storyBoard instantiateViewControllerWithIdentifier:@"xx"];
    [self.window.layer addAnimation:animation forKey:nil];

    self.splashScreen = nil;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
	[self addSplashScreen];
    
}

							
@end
