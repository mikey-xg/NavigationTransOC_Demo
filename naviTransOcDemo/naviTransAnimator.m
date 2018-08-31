//
//  naviTransAnimator.m
//  naviTransOcDemo
//
//  Created by best su on 2018/8/14.
//  Copyright © 2018年 best su. All rights reserved.
//

#import "naviTransAnimator.h"
#import "ViewController.h"

@interface naviTransAnimator() <CAAnimationDelegate>

@property (nonatomic, strong) id<UIViewControllerContextTransitioning> context;

@end
@implementation naviTransAnimator 

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.8;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    _context = transitionContext;
    
    UIView *conterView = [transitionContext containerView];
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    [conterView addSubview:toVC.view];
    
    ViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIButton *btn = fromVc.blackBtn;
    
    UIBezierPath *smallPath = [UIBezierPath bezierPathWithOvalInRect:btn.frame];
    CGPoint centerP;
    centerP = btn.center;
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    CGFloat radius;
    if (btn.frame.origin.x > CGRectGetWidth(toVC.view.bounds)/2) {
        if (CGRectGetMaxY(btn.frame) < CGRectGetHeight(toVC.view.bounds)/2) {
            //第一象限(求平方根)
            radius = sqrtf(btn.center.x * btn.center.x + (screenHeight - btn.center.y) * (screenHeight - btn.center.y));
        }else{
            //第四象限
            radius = sqrtf(btn.center.x*btn.center.x + btn.center.y*btn.center.y);
        }
    }else{
        if (CGRectGetMidY(btn.frame) < CGRectGetHeight(toVC.view.frame)) {
            //第二象限
            radius = sqrtf((screenWidth - btn.center.x) * (screenWidth - btn.center.x) + (screenHeight - btn.center.y) * (screenHeight - btn.center.y));
        }else{
            //第三象限
            radius = sqrtf((screenWidth - btn.center.x) * (screenWidth - btn.center.x) + btn.center.y * btn.center.y);
        }
    }
    
    UIBezierPath *bigPath = [UIBezierPath bezierPathWithArcCenter:centerP radius:radius startAngle:0 endAngle:M_PI*2 clockwise:YES];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = bigPath.CGPath;
    
    toVC.view.layer.mask = shapeLayer;
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"path"];
    anim.fromValue = (id)smallPath.CGPath;
    anim.duration = [self transitionDuration:transitionContext];
    anim.delegate = self;
    [shapeLayer addAnimation:anim forKey:nil];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [_context completeTransition:YES];
    UIViewController *tovc = [_context viewControllerForKey:UITransitionContextToViewControllerKey];
    tovc.view.layer.mask = nil;
}


@end
