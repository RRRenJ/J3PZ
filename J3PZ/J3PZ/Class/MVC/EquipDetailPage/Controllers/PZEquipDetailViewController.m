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

@interface PZEquipDetailViewController ()<sendDataArray,sendModelValue>

@property(nonatomic,strong)PZEquipDetailControl * equipDetailDropControl;
@property(nonatomic,strong)PZEquipListDropControl * equipListDropControl;
@property(nonatomic,strong)PZEquipListDropControl * enhanceListDropControl;
@property(nonatomic,strong)PZNetworkingManager * manager;
@property(nonatomic,strong)NSArray * enhanceListArray;
@property(nonatomic,strong)NSArray * equipListArray;
@property (weak, nonatomic) IBOutlet UIButton *equipListButton;
- (IBAction)equipListButtonClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *enhanceListButton;
- (IBAction)enhanceListButtonClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *stone1;
- (IBAction)stone1Clicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *stone2;
- (IBAction)stone2Clicked:(UIButton *)sender;

@end

@implementation PZEquipDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
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
    PZEquipListDropControl * equipListDropControl = [[PZEquipListDropControl alloc]init];
    equipListDropControl.delegate =self;
    //设置按键文字
    [_equipListButton setTitle:@"请选择装备" forState:UIControlStateNormal];
    [_enhanceListButton setTitle:@"请选择附魔" forState:UIControlStateNormal];
    [_stone1 setTitle:@"镶嵌" forState:UIControlStateNormal];
    [_stone2 setTitle:@"镶嵌" forState:UIControlStateNormal];
}
#pragma mark - delegate传值
-(void)sendEquipListArray:(NSArray *)equipListArray{
    _equipListArray = equipListArray;
}
-(void)sendEnhanceListArray:(NSArray *)enhanceListArray{
    _enhanceListArray = enhanceListArray;
}

-(void)sendEquipListName:(NSString *)equipListName{
    [_equipListButton setTitle:equipListName forState:UIControlStateNormal];
}



#pragma mark - 按键点击事件
- (IBAction)equipListButtonClicked:(UIButton *)sender {
    [_equipListDropControl show];
}
- (IBAction)enhanceListButtonClicked:(UIButton *)sender {
    [_enhanceListDropControl show];
}
- (IBAction)stone1Clicked:(UIButton *)sender {
}
- (IBAction)stone2Clicked:(UIButton *)sender {
}
@end
