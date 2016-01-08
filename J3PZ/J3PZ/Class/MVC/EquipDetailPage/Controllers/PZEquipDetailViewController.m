//
//  PZEquipDetailViewController.m
//  J3PZ
//
//  Created by 千锋 on 16/1/6.
//  Copyright © 2016年 1111111111. All rights reserved.
//

#import "PZEquipDetailViewController.h"
#import "PZEquipDetailControl.h"
#import "PZEquipListDropControl.h"
#import "PZEquipViewController.h"
#import "PZNetworkingManager.h"

@interface PZEquipDetailViewController ()<sendDataArray>

@property(nonatomic,strong)PZEquipDetailControl * equipDetailDropControl;
@property(nonatomic,strong)PZEquipListDropControl * equipListDropControl;
@property(nonatomic,strong)PZEquipListDropControl * enhanceListDropControl;
@property(nonatomic,strong)PZNetworkingManager * manager;
@property(nonatomic,strong)NSArray * enhanceListArray;
@property(nonatomic,strong)NSArray * equipListArray;

@end

@implementation PZEquipDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)createUI{
    PZEquipViewController * equipVC = [[PZEquipViewController alloc]init];
    equipVC.delegate = self;
    
    //装备属性弹窗
    self.equipDetailDropControl = [[PZEquipDetailControl alloc]initWithFrame:CGRectMake(50, 300, 150, 0) andEquipDetailModel:nil];
    //选择装备弹窗
    self.equipListDropControl = [[PZEquipListDropControl alloc]initWithInsideFrame:CGRectMake(20, 200, 100, 100) inView:nil dataSource:_equipListArray];
    //选择附魔弹窗
    self.enhanceListDropControl = [[PZEquipListDropControl alloc]initWithInsideFrame:CGRectMake(20, 250, 100, 100) inView:nil dataSource:_enhanceListArray];
}
-(void)sendEquipListArray:(NSArray *)equipListArray{
    _equipListArray = equipListArray;
}
-(void)sendEnhanceListArray:(NSArray *)enhanceListArray{
    _enhanceListArray = enhanceListArray;
}

#pragma mark - data
//数据请求
-(void)requestData{
    
    
    
    
    
    
    
}
@end
