//
//  LYDSplashViewController.h
//  BasicSplashView
//
//  Created by 224 on 15/4/18.
//  Copyright (c) 2015年 zoomlgd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    CircleFromCenter,
	ClearFromCenter,
	ClearFromLeft,
	ClearFromRight,
	ClearFromTop,
	ClearFromBottom,
} TransitionDirection;

@protocol LYDSplashViewViewControllerDelegate;

@interface LYDSplashViewController : UIViewController

@property (nonatomic, strong) UIImage *splashImage;
@property (nonatomic, strong) UIImage *maskImage;
@property (nonatomic, weak) id<LYDSplashViewViewControllerDelegate> delegate;
@property (nonatomic, strong) NSString *maskImageName;
@property (nonatomic) TransitionDirection transition;
@property (nonatomic) CGFloat delay;
@property (nonatomic) CGPoint anchor;

@end

@protocol LYDSplashViewViewControllerDelegate <NSObject>

@optional
- (void)splashScreenDidAppear:(LYDSplashViewController *)splashScreen;
- (void)splashScreenWillDisappear:(LYDSplashViewController *)splashScreen;
- (void)splashScreenDidDisappear:(LYDSplashViewController *)splashScreen;

@end
