//
//  PZHomeViewController.m
//  J3PZ
//
//  Created by 千锋 on 16/1/4.
//  Copyright © 2016年 1111111111. All rights reserved.
//

#import "PZHomeViewController.h"
#import "PZEquipViewController.h"
#import "PZEquipDetailViewController.h"

@interface PZHomeViewController ()

@property(nonatomic,strong)PZEquipViewController * equipVC;
@property(nonatomic,strong)PZEquipDetailViewController * equipDetailVC;


@end

@implementation PZHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)addLeftAndRightViewControllers{
    
    _equipVC = [[PZEquipViewController alloc]init];
    _equipDetailVC = [[PZEquipDetailViewController alloc]init];
    
    self.rightMenuViewController = _equipDetailVC;
    self.contentViewController = _equipVC;
}


@end
