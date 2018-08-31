//
//  demoViewController.m
//  naviTransOcDemo
//
//  Created by best su on 2018/8/14.
//  Copyright © 2018年 best su. All rights reserved.
//

#import "demoViewController.h"
#import "naviTransAnimator.h"


@interface demoViewController () <UINavigationControllerDelegate>
@property (nonatomic, assign) CGFloat screenWidth;
@property (nonatomic, assign) CGFloat screenHeight;

@end

@implementation demoViewController

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.screenWidth = [UIScreen mainScreen].bounds.size.width;
    self.screenHeight = [UIScreen mainScreen].bounds.size.height;
    self.view.layer.contents = (id)[[UIImage imageNamed:@"222"] CGImage];
    [self setUI];
}

- (void)setUI{
    
    UIButton *demoBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(_screenWidth - 100, _screenHeight - 100, 80, 80)];
    demoBtn1.layer.cornerRadius = 40;
    demoBtn1.backgroundColor = [UIColor orangeColor];
    [demoBtn1 addTarget:self action:@selector(demoClick) forControlEvents:UIControlEventTouchUpInside];
    self.orangeBtn = demoBtn1;
    [self.view addSubview:demoBtn1];
}

-(void) demoClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPop){
        naviTransAnimator *ani = [naviTransAnimator new];
        return ani;
    }
    return nil;
}
    

@end
