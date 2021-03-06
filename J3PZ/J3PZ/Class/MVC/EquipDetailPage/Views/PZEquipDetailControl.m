//
//  PZEquipDetailControl.m
//  J3PZ
//
//  Created by 千锋 on 16/1/6.
//  Copyright © 2016年 1111111111. All rights reserved.
//

#import "PZEquipDetailControl.h"
#import "PZNetworkingManager.h"
#import "PZEquipListDropControl.h"
#import "PZEquipDetailModel.h"
#import "UIColor+Her.h"
#import "PZEnhanceDetailController.h"
#import "PZEnhanceDetailModel.h"

#define CELL_HIGHT 20

@interface PZEquipDetailControl ()<UITableViewDataSource,UITableViewDelegate,sendModelValue>
{
    float proportion;
}


@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)PZEquipDetailModel * model;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,assign)CGRect tableViewFrame;
@property(nonatomic,strong)PZNetworkingManager * manager;
@property(nonatomic,strong)UIView * sView;
@property(nonatomic,strong)PZEnhanceDetailModel *detailModel;

@end


@implementation PZEquipDetailControl

-(PZNetworkingManager *)manager{
    if (!_manager) {
        _manager = [PZNetworkingManager manager];
    }
    return _manager;
}

-(instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}


-(instancetype)initWithFrame:(CGRect)frame andView:(UIView *)view{
    if (self = [super initWithFrame:frame]) {
        self.sView = view;
        self.tableViewFrame = frame;
    }
    return self;
}

-(void)show{
    [self requestData];
}
-(void)reload{
    [self createDataArray];
    [self.tableView reloadData];
}
#pragma mark - 添加数据源
-(void)createDataArray{
    if ([self.model.strengthen isEqualToString:@"8"]) {
        proportion = 0.124;
    }else if ([self.model.strengthen isEqualToString:@"6"]){
        proportion = 0.075;
    }else if([self.model.strengthen isEqualToString:@"4"]){
        proportion = 0.039;
    }else if([self.model.strengthen isEqualToString:@"3"]){
        proportion = 0.022;
    }
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    //装备名字
    [_dataArray addObject:self.model.name];
    //防御等级
    if (![self.model.basicPhysicsShield isEqualToString:@"0"]) {
        [_dataArray addObject:[NSString stringWithFormat:@"外功防御等级提高%@",self.model.basicPhysicsShield]];
    }
    if(![self.model.basicMagicShield isEqualToString:@"0"]){
        [_dataArray addObject:[NSString stringWithFormat:@"内功防御等级提高%@",self.model.basicMagicShield]];
    }
    //体质
    if (![self.model.body isEqualToString:@"0"] ) {
        [_dataArray addObject:[NSString stringWithFormat:@"体质+%@ (+%d)",self.model.body,(int)([self.model.body intValue] * proportion)]];
    }
    //门派属性
    if (![self.model.spirit isEqualToString:@"0"]) {
        [_dataArray addObject:[NSString stringWithFormat:@"根骨+%@ (+%d)",self.model.spirit,(int)([self.model.spirit intValue] * proportion)]];
    }else if (![self.model.spunk isEqualToString:@"0"]){
        [_dataArray addObject:[NSString stringWithFormat:@"元气+%@ (+%d)",self.model.spunk,(int)([self.model.spunk intValue] * proportion)]];
    }else if (![self.model.agility isEqualToString:@"0"]){
        [_dataArray addObject:[NSString stringWithFormat:@"身法+%@ (+%d)",self.model.agility,(int)([self.model.agility intValue] * proportion)]];
    }else if (![self.model.strength isEqualToString:@"0"]){
        [_dataArray addObject:[NSString stringWithFormat:@"力道+%@ (+%d)",self.model.strength,(int)([self.model.strength intValue] * proportion)]];
    }
    //攻击力
    if (![self.model.attack isEqualToString:@"0"]) {
        [_dataArray addObject:[NSString stringWithFormat:@"攻击力提高%@ (+%d)",self.model.attack,(int)([self.model.attack intValue] * proportion)]];
    }
    //治疗量
    if(![self.model.heal isEqualToString:@"0"]){
        [_dataArray addObject:[NSString stringWithFormat:@"治疗量提高%@ (+%d)",self.model.heal,(int)([self.model.heal intValue] * proportion)]];
    }
    //双会
    if(![self.model.crit isEqualToString:@"0"]){
        [_dataArray addObject:[NSString stringWithFormat:@"会心等级提高%@ (+%d)",self.model.crit,(int)([self.model.crit intValue] * proportion)]];
    }
    if (![self.model.critEffect isEqualToString:@"0"]) {
        [_dataArray addObject:[NSString stringWithFormat:@"会心效果等级提高%@ (+%d)",self.model.critEffect,(int)([self.model.critEffect intValue] * proportion)]];
    }
    //外防
    if (![self.model.physicsShield isEqualToString:@"0"]) {
        [_dataArray addObject:[NSString stringWithFormat:@"外功防御等级提高%@ (+%d)",self.model.physicsShield,(int)([self.model.physicsShield intValue] * proportion)]];
    }
    //内防
    if(![self.model.magicShield isEqualToString:@"0"]){
        [_dataArray addObject:[NSString stringWithFormat:@"内功防御等级提高%@ (+%d)",self.model.magicShield,(int)([self.model.magicShield intValue] * proportion)]];
    }
    //御劲
    if(![self.model.toughness isEqualToString:@"0"]){
        [_dataArray addObject:[NSString stringWithFormat:@"御劲等级提高%@ (+%d)",self.model.toughness,(int)([self.model.toughness intValue] * proportion)]];
    }
    //闪避
    if(![self.model.dodge isEqualToString:@"0"]){
        [_dataArray addObject:[NSString stringWithFormat:@"闪避等级提高%@ (+%d)",self.model.dodge,(int)([self.model.dodge intValue] * proportion)]];
    }
    //招架
    if (![self.model.parryBase isEqualToString:@"0"]) {
        [_dataArray addObject:[NSString stringWithFormat:@"招架等级提高%@ (+%d)",self.model.parryBase,(int)([self.model.parryBase intValue] * proportion)]];
    }
    //拆招
    if (![self.model.parryValue isEqualToString:@"0"]) {
        [_dataArray addObject:[NSString stringWithFormat:@"拆招等级提高%@ (+%d)",self.model.parryValue,(int)([self.model.parryValue intValue] * proportion)]];
    }
    //破防
    if(![self.model.overcome isEqualToString:@"0"]){
        [_dataArray addObject:[NSString stringWithFormat:@"破防等级提高%@ (+%d)",self.model.overcome,(int)([self.model.overcome intValue] * proportion)]];
    }
    //加速
    if(![self.model.acce isEqualToString:@"0"]){
        [_dataArray addObject:[NSString stringWithFormat:@"加速等级提高%@ (+%d)",self.model.acce,(int)([self.model.acce intValue] * proportion)]];
    }
    //命中
    if(![self.model.hit isEqualToString:@"0"]){
        [_dataArray addObject:[NSString stringWithFormat:@"命中等级提高%@ (+%d)",self.model.hit,(int)([self.model.hit intValue] * proportion)]];
    }
    //无双
    if(![self.model.strain isEqualToString:@"0"]){
        [_dataArray addObject:[NSString stringWithFormat:@"无双等级提高%@ (+%d)",self.model.strain,(int)([self.model.strain intValue] * proportion)]];
    }
    //化劲
    if(![self.model.huajing isEqualToString:@"0"]){
        [_dataArray addObject:[NSString stringWithFormat:@"化劲等级提高%@ (+%d)",self.model.huajing,(int)([self.model.huajing intValue] * proportion)]];
    }
    //附魔
    if (self.detailModel.desc != nil) {
        [_dataArray insertObject:self.detailModel.desc atIndex:_dataArray.count -2];
    }
    [_dataArray addObject:[NSString stringWithFormat:@"品质等级 %@",self.model.quality]];
    [_dataArray addObject:[NSString stringWithFormat:@"装备分数 %@",self.model.score]];
    [self createTableView];
}

#pragma mark - createTableView

-(void)createTableView{
    CGFloat NowHeight = self.dataArray.count * CELL_HIGHT;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.tableViewFrame), CGRectGetMinY(self.tableViewFrame), CGRectGetWidth(self.tableViewFrame), NowHeight)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = NO;
    [self.sView addSubview:_tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    }
    cell.backgroundColor = [UIColor colorWithHexString:@"#004d40" alpha:1];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text = _dataArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    if (indexPath.row == _dataArray.count -2) {
        cell.textLabel.textColor = [UIColor yellowColor];
    }
    if (indexPath.row == _dataArray.count -1) {
        cell.textLabel.textColor = [UIColor orangeColor];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CELL_HIGHT;
}

#pragma mark - requestData
-(void)requestData{
    PZEquipListDropControl * equipListControl = [[PZEquipListDropControl alloc]init];
    equipListControl.delegate = self;
    NSString * enquipDetailPath = [NSString stringWithFormat:PZEquipDetailURL,_equipListID];
    [self.manager GET:enquipDetailPath success:^(NSURLResponse *response, NSData *data) {
        NSDictionary * responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.model = [[PZEquipDetailModel alloc]init];
        [self.model setValuesForKeysWithDictionary:responseDict];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"sendDetailModel" object:nil userInfo:@{@"model":self.model}];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
            [self createDataArray];
        });
        
    } failure:^(NSURLResponse *response, NSError *error) {
        
    }];
    
}

-(void)sendEquipListID:(NSString *)equipListID{
    self.equipListID = equipListID;
}

@end
