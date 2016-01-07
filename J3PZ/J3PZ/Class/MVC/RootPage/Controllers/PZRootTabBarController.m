//
//  PZRootTabBarController.m
//  J3PZ
//
//  Created by 千锋 on 16/1/4.
//  Copyright © 2016年 1111111111. All rights reserved.
//

#import "PZRootTabBarController.h"
#import "PZHomeViewController.h"
#import "PZInstectViewController.h"
#import "PZMyViewController.h"
#import "PZOccupationViewController.h"

@interface PZRootTabBarController ()

@end

@implementation PZRootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//给TabBar添加视图控制器
-(void)addViewController{
    NSArray * VCNameArray = @[@"PZOccupationViewController",@"PZInstectViewController",@"PZMyViewController"];
    NSArray * VCTitleArray = @[@"配装",@"预览",@"我"];
    for(NSString * VCName in VCNameArray){
        Class VCClass = NSClassFromString(VCName);
        NSInteger index = [VCNameArray indexOfObject:VCName];
        UIViewController * VC = [[VCClass alloc]init];
        //设置
        VC.title = VCTitleArray[index];
        UINavigationController * naviVC = [[UINavigationController alloc]initWithRootViewController:VC];
        [self addChildViewController:naviVC];
        
    }
}




















@end
