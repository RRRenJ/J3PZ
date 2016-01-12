//
//  PZEquipViewController.m
//  J3PZ
//
//  Created by 千锋 on 16/1/4.
//  Copyright © 2016年 1111111111. All rights reserved.
//

#import "PZEquipViewController.h"
#import "PZEquipCell.h"
#import "PZNetworkingManager.h"
#import "PZEquipDetailViewController.h"
#import "PZEquipModel.h"
#import "PZEnhanceModel.h"
#import "PZEquipListDropControl.h"

@interface PZEquipViewController ()<UITableViewDataSource,UITableViewDelegate,sendModelValue>

    
@property(nonatomic,copy)NSString * equipIndex;;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSString * equipIconID;
@property(nonatomic,strong)PZNetworkingManager * manager;


@end

@implementation PZEquipViewController
-(PZNetworkingManager *)manager{
    if (!_manager) {
        _manager = [PZNetworkingManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark - createUI
-(void)createTableView{

    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH ,SCREEN_HEIGHT)];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    //注册CELL
    [self.tableView registerNib:[UINib nibWithNibName:@"PZEquipCell" bundle:nil] forCellReuseIdentifier:@"PZEquipCell"];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 12;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PZEquipCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PZEquipCell" forIndexPath:indexPath];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _equipIndex = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    PZEquipDetailViewController * equipDetailVC = [[PZEquipDetailViewController alloc]init];
    equipDetailVC.xinfa = @"yijin";
    equipDetailVC.pos = _equipIndex;
    
    [self.navigationController pushViewController:equipDetailVC animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
    
}

#pragma mark - requestData
-(void)requestData{
    
    
   
  
}
-(void)sendEquipListID:(NSString *)equipListID{
    self.equipIconID = equipListID;
}

@end
