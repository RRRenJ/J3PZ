//
//  PZEquipListDropControl.m
//  J3PZ
//
//  Created by 千锋 on 16/1/5.
//  Copyright © 2016年 1111111111. All rights reserved.
//

#import "PZEquipListDropControl.h"
#import "PZEquipModel.h"
#define CELL_HEIGHT 25

@interface PZEquipListDropControl ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak)UIView * sView;
@property(nonatomic,strong)UIImageView * dropImageView;
@property(nonatomic,assign)CGRect imageFrame;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * dataArray;

@end


@implementation PZEquipListDropControl

-(instancetype)initWithInsideFrame:(CGRect)frame inView:(UIView *)view dataSource:(NSArray *)dataArray{
    if (self = [super init]) {
        self.sView = view;
        self.imageFrame = frame;
        self.dataArray = [dataArray copy];
        self.dropImageView = [[UIImageView alloc]init];
        self.dropImageView.frame = frame;
        [self addSubview:self.dropImageView];
    }
    
    return self;
}
#pragma mark -设置下拉框的弹出以及收回
-(void)show{
    [self.sView addSubview:self];
    self.userInteractionEnabled = NO;
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
    CGFloat NowHeight= self.dataArray.count * CELL_HEIGHT + 20;
    if (NowHeight > self.imageFrame.size.height) {
        NowHeight = self.imageFrame.size.height;
    }
    CGRect rect = CGRectMake(CGRectGetMinX(self.imageFrame), CGRectGetMinY(self.imageFrame), CGRectGetWidth(self.imageFrame), NowHeight);
    self.imageFrame = rect;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(5, 15, self.imageFrame.size.width - 10, self.imageFrame.size.height-20)];
    [self.dropImageView addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
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
    PZEquipModel * model = _dataArray[indexPath.row];
    cell.textLabel.text = model.name;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PZEquipModel * model = _dataArray[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(sendEquipListID:)]) {
        [self.delegate sendEquipListID:model.Id];
    }
    [self hide];
}



@end
