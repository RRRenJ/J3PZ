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

@interface PZEquipViewController ()<UITableViewDataSource,UITableViewDelegate>

    
@property(nonatomic,copy)NSString * equipIndex;;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * equipListArray;
@property(nonatomic,strong)NSMutableArray * enhanceListArray;
@property(nonatomic,strong)PZNetworkingManager * manager;
@property(nonatomic,copy)NSString * xinfa;

@end

@implementation PZEquipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark - createUI
-(void)createTableView{

    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64,SCREEN_WIDTH ,SCREEN_HEIGHT - 64)];
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
    _equipIndex = [NSString stringWithFormat:@"%@",indexPath];
    [self requestData];
    if ([self.delegate respondsToSelector:@selector(sendEquipListArray:)]) {
        [self.delegate sendEquipListArray:[_equipListArray copy]];
    }
    if ([self.delegate respondsToSelector:@selector(sendEnhanceListArray:)]) {
        [self.delegate sendEnhanceListArray:[_enhanceListArray copy]];
    }
    
    [self presentRightMenuViewController:self.sideMenuViewController.rightMenuViewController];
}


#pragma mark - requestData
-(void)requestData{
    NSString * equipListPath = [[NSString alloc]initWithFormat:PZEquipURL,_equipIndex ,_xinfa];
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
    } failure:^(NSURLRequest *response, NSError *error) {
        
    }];
    NSString * enhanceListPath = [[NSString alloc]initWithFormat:PZEnhanceURL,_equipIndex,_xinfa];
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
    } failure:^(NSURLRequest *response, NSError *error) {
        
    }];
    
}


@end
