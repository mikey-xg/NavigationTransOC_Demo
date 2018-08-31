//
//  ViewController.m
//  naviTransOcDemo
//
//  Created by best su on 2018/8/14.
//  Copyright © 2018年 best su. All rights reserved.
//

#import "ViewController.h"
#import "demoViewController.h"
#import "naviTransAnimator.h"
//#define screenWidth = [UIScreen mainScreen].bounds.size.width;
//#define screenHeight = [UIScreen mainScreen].bounds.size.height;

@interface ViewController () <UINavigationControllerDelegate>
@property (nonatomic, assign) CGFloat screenWidth;
@property (nonatomic, assign) CGFloat screenHeight;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.screenWidth = [UIScreen mainScreen].bounds.size.width;
    self.screenHeight = [UIScreen mainScreen].bounds.size.height;
    self.view.layer.contents = (id)[[UIImage imageNamed:@"111"] CGImage];
    [self setUI];
        
}

- (void)setUI{
    
    UIButton *demoBtn = [[UIButton alloc] initWithFrame:CGRectMake(_screenWidth - 100, _screenHeight - 100, 80, 80)];
    demoBtn.backgroundColor = [UIColor blackColor];
    demoBtn.layer.cornerRadius = 40;
    [demoBtn addTarget:self action:@selector(demoClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:demoBtn];
    self.blackBtn = demoBtn;
}

-(void) demoClick{
    demoViewController *vc = [[demoViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPush){
        naviTransAnimator *trans = [naviTransAnimator new];
        return trans;
    }
    return nil;
}


@end





