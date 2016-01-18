//
//  PZEquipListDropControl.m
//  J3PZ
//
//  Created by 千锋 on 16/1/5.
//  Copyright © 2016年 1111111111. All rights reserved.
//

#import "PZEquipListDropControl.h"
#import "PZEquipModel.h"
#import "PZEquipViewController.h"
#import "PZNetworkingManager.h"
#import "PZEquipDetailViewController.h"
#import "PZEquipDetailControl.h"
#define CELL_HEIGHT 25

@interface PZEquipListDropControl ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak)UIView * sView;
@property(nonatomic,strong)UIImageView * dropImageView;
@property(nonatomic,assign)CGRect imageFrame;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)PZNetworkingManager * manager;
@property(nonatomic,strong)NSArray * equipListArray;
@property (nonatomic,strong)PZEquipDetailControl *pzEquipDetailControl;
@end


@implementation PZEquipListDropControl

-(PZNetworkingManager *)manager{
    if (!_manager) {
        _manager = [PZNetworkingManager manager];
    }
    return _manager;
}



-(instancetype)initWithInsideFrame:(CGRect)frame inView:(UIView *)view andDataSource:(NSArray *)dataArray{
    
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        self.sView = view;
        self.imageFrame = frame;
        _equipListArray = [dataArray copy];
        self.dropImageView = [[UIImageView alloc]init];
        self.dropImageView.frame = frame;
        self.dropImageView.image = [[UIImage imageNamed:@"popover_background"] stretchableImageWithLeftCapWidth:3 topCapHeight:10];
        [self addSubview:self.dropImageView];
        self.dropImageView.userInteractionEnabled = YES;
        [self createTableView];
    }
    
    return self;
}
#pragma mark -设置下拉框的弹出以及收回
-(void)show{
    [self.sView addSubview:self];
    //获取尺寸
    CGRect rect = self.imageFrame;
    //高度置为0
   
    rect.size.height = 0;
    self.dropImageView.frame = rect;
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:6 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.dropImageView.frame =self.imageFrame;
    } completion:^(BOOL finished) {
        self.userInteractionEnabled =YES;
    }];
}
-(void)hide{
    CGRect rect = self.imageFrame;
    rect.size.height = 0;
    self.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.5 animations:^{
        self.dropImageView.frame = rect;
    }completion:^(BOOL finished) {
        [self dismiss];
        self.userInteractionEnabled = YES;
    }];
}
-(void)dismiss{
    [self removeFromSuperview];
}

#pragma mark - createTableView

-(void)createTableView{

    CGRect rect = CGRectMake(CGRectGetMinX(self.imageFrame), CGRectGetMinY(self.imageFrame), CGRectGetWidth(self.imageFrame), CGRectGetHeight(self.imageFrame));
    self.imageFrame = rect;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(5, 15, self.imageFrame.size.width - 10, self.imageFrame.size.height-20)];
    [self.dropImageView addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor  clearColor];
    self.tableView.clipsToBounds = YES;
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%lu",self.equipListArray.count);
    return self.equipListArray.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CELL_HEIGHT;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    }
    cell.backgroundColor = [UIColor clearColor];
    PZEquipModel * model = _equipListArray[indexPath.row];
    cell.textLabel.text = model.name;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PZEquipModel * model = _equipListArray[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(sendEquipListID:)]) {
        [self.delegate sendEquipListID:model.Id];
    }
    if ([self.delegate respondsToSelector:@selector(sendEquipListName:)]) {
        [self.delegate sendEquipListName:model.name];
    }
    
    _pzEquipDetailControl = [[PZEquipDetailControl alloc]initWithFrame:CGRectMake(0, 100, 180, 300) andView:self.sView];
    
    _pzEquipDetailControl.equipListID = model.Id;
    [_pzEquipDetailControl show];
    [self hide];
}

@end
