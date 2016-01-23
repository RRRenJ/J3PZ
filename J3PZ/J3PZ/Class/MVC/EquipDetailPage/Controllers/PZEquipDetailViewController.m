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
#import "PZEquipModel.h"
#import "PZEnhanceModel.h"
#import "PZEnhanceDetailController.h"

@interface PZEquipDetailViewController ()<sendModelValue,sendEnhanceValue>

@property(nonatomic,strong)PZEquipDetailControl * equipDetailDropControl;
@property(nonatomic,strong)PZEquipListDropControl * equipListDropControl;
@property(nonatomic,strong)PZEnhanceDetailController * enhanceListDropControl;
@property(nonatomic,strong)PZNetworkingManager * manager;
@property(nonatomic,strong)NSMutableArray * enhanceListArray;
@property(nonatomic,strong)NSMutableArray * equipListArray;

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

-(PZNetworkingManager *)manager{
    if (!_manager) {
        _manager = [PZNetworkingManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)createUI{
    //设置按键文字
    [_equipListButton setTitle:@"请选择装备" forState:UIControlStateNormal];
    [_enhanceListButton setTitle:@"请选择附魔" forState:UIControlStateNormal];
    [_stone1 setTitle:@"镶嵌" forState:UIControlStateNormal];
    [_stone2 setTitle:@"镶嵌" forState:UIControlStateNormal];
}


#pragma mark - delegate传值

//修改选择装备按键文字
-(void)sendEquipListName:(NSString *)equipListName{
    [_equipListButton setTitle:equipListName forState:UIControlStateNormal];
}
// 修改选择附魔按钮文字
-(void)sendEnhanceName:(NSString *)enhanceName{
    [_enhanceListButton setTitle:enhanceName forState:UIControlStateNormal];
}
#pragma mark - requestData
-(void)requestData{
    NSString * equipListPath = [[NSString alloc]initWithFormat:PZEquipURL,self.pos ,self.xinfa];

    // 装备数据请求
    [self.manager GET:equipListPath success:^(NSURLResponse *response, NSData *data) {
        NSArray * responseArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        if (!_equipListArray) {
            _equipListArray = [NSMutableArray array];
        }
        for (NSDictionary * equip in responseArray) {
            PZEquipModel * model = [[PZEquipModel alloc]init];
            [model setValuesForKeysWithDictionary:equip];
            [_equipListArray addObject:model];
        }
    } failure:^(NSURLResponse *response, NSError *error) {
        
    }];
    
    // 附魔数据请求
    NSString * enhanceListPath = [[NSString alloc]initWithFormat:PZEnhanceURL,self.pos,self.xinfa];
    [self.manager GET:enhanceListPath success:^(NSURLResponse *response, NSData *data) {
        NSArray * responseArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (!_enhanceListArray) {
            _enhanceListArray = [NSMutableArray array];
        }
        for (NSDictionary * equip in responseArray) {
            PZEnhanceModel * model = [[PZEnhanceModel alloc]init];
            [model setValuesForKeysWithDictionary:equip];
            [_enhanceListArray addObject:model];
        }
    } failure:^(NSURLResponse *response, NSError *error) {  
    }];
}




#pragma mark - 按键点击事件
- (IBAction)equipListButtonClicked:(UIButton *)sender {
    //选择装备弹窗
    self.equipListDropControl = [[PZEquipListDropControl alloc]initWithInsideFrame:CGRectMake(20, 330, 180, 300) inView:self.view andDataSource:[_equipListArray copy]];
    self.equipListDropControl.delegate = self;
    [_equipListDropControl show];
    
}
- (IBAction)enhanceListButtonClicked:(UIButton *)sender {
    // 选择附魔弹窗
    self.enhanceListDropControl = [[PZEnhanceDetailController alloc]initWithInsideFrame:CGRectMake(20, 350, 200, 300) inView:self.view andDataSource:[_enhanceListArray copy]];
    self.enhanceListDropControl.delegate = self;
    [_enhanceListDropControl show];
}
- (IBAction)stone1Clicked:(UIButton *)sender {
    
}
- (IBAction)stone2Clicked:(UIButton *)sender {
    
}
@end
