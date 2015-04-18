//
//  LYDSplashViewController.m
//  BasicSplashView
//
//  Created by 224 on 15/4/18.
//  Copyright (c) 2015年 zoomlgd. All rights reserved.
//

#import "LYDSplashViewController.h"
#import <QuartzCore/QuartzCore.h>

#define DURATION 0.75

NSString *const PRPSplashScreenFadeAnimation = @"PRPSplashScreenFadeAnimation";

@interface LYDSplashViewController ()

- (void)animate;

@end

@implementation LYDSplashViewController


- (void)viewDidLoad {
    self.view.layer.contentsScale = [[UIScreen mainScreen] scale];
    self.view.layer.contents = (id)self.splashImage.CGImage;
    self.view.contentMode = UIViewContentModeBottom;
    if (self.transition == 0) {
        self.transition = ClearFromRight;
    }
}

- (UIImage *)splashImage {
    if (_splashImage == nil) {
        _splashImage = [UIImage imageNamed:@"Default-1"];
    }
    return _splashImage;
}

- (UIImage *)maskImage {
    if (_maskImage == nil) {
        NSString *defaultPath = [[NSBundle mainBundle] pathForResource:self.maskImageName
                                                                ofType:@"png"];
        _maskImage = [[UIImage alloc] initWithContentsOfFile:defaultPath];
    }
    return _maskImage;
}

//创建蒙版图层
- (void)setMaskLayerWithAnchor {
    CALayer *maskLayer = [CALayer layer];
    maskLayer.anchorPoint = self.anchor;
    maskLayer.frame = self.view.superview.frame;
    maskLayer.contents = (id)self.maskImage.CGImage;
    self.view.layer.mask = maskLayer;
}

- (void)viewDidAppear:(BOOL)animated {
    if ([self.delegate respondsToSelector:@selector(splashScreenDidAppear:)]) {
        [self.delegate splashScreenDidAppear:self];
    }
    switch (self.transition) {
        case CircleFromCenter:
            self.maskImageName = @"mask";
            self.anchor = CGPointMake(0.5, 0.5);
            break;
        case ClearFromCenter:
            self.maskImageName = @"wideMask";
            self.anchor = CGPointMake(0.5, 0.5);
            break;
        case ClearFromLeft:
            self.maskImageName = @"leftStripMask";
            self.anchor = CGPointMake(0.0, 0.5);
            break;
        case ClearFromRight:
            self.maskImageName = @"RightStripMask";
            self.anchor = CGPointMake(1.0, 0.5);
            break;
        case ClearFromTop:
            self.maskImageName = @"TopStripMask";
            self.anchor = CGPointMake(0.5, 0.0);
            break;
        case ClearFromBottom:
            self.maskImageName = @"BottomStripMask";
            self.anchor = CGPointMake(0.5, 1.0);
            break;
    
        default:
            break;
    }
    
    [self performSelector:@selector(animate) withObject:nil afterDelay:self.delay];
}

- (void)animate {
//    if ([self.delegate respondsToSelector:@selector(splashScreenDidDisappear:)]) {
//        [self.delegate splashScreenDidDisappear:self];
//    }
    
    [self setMaskLayerWithAnchor];
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anim.duration = DURATION;
    anim.toValue = [NSNumber numberWithInt:self.view.bounds.size.height/8];
    anim.fillMode = kCAFillModeBoth;
    anim.removedOnCompletion = NO;
    anim.delegate = self;
    [self.view.layer.mask addAnimation:anim forKey:@"scale"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    self.view.layer.mask = nil;
//    [self.view removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(splashScreenDidDisappear:)]) {
        [self.delegate splashScreenDidDisappear:self];
    }
}


@end
