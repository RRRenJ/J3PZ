//
//  PZEnhanceDetailController.m
//  J3PZ
//
//  Created by 千锋 on 16/1/8.
//  Copyright © 2016年 1111111111. All rights reserved.
//

#import "PZEnhanceDetailController.h"
#import "PZEnhanceDetailModel.h"
#import "PZEnhanceModel.h"
#import "PZNetworkingManager.h"
#import "PZEquipDetailControl.h"
@interface PZEnhanceDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)PZEnhanceModel * model;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *sView;
@property(nonatomic,strong)UIImageView * dropImageView;
@property(nonatomic,assign)CGRect imageFrame;
@property(nonatomic,strong)PZNetworkingManager * manager;
@property(nonatomic,copy)NSString *enHanceID;
@property(nonatomic,strong)NSMutableArray *enhanceDetailArray;

@end


@implementation PZEnhanceDetailController

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
        _dataArray = [dataArray copy];
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
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    }
        PZEnhanceModel *model = _dataArray[indexPath.row];
        cell.textLabel.text = model.name;
        cell.backgroundColor = [UIColor clearColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PZEnhanceModel *model = _dataArray[indexPath.row];
    self.enHanceID = model.Id;
    [self requestData];
    if ([self.delegate respondsToSelector:@selector(sendEnhanceName:)]) {
        [self.delegate sendEnhanceName:model.name];
    }
    [self hide];
}

-(void)requestData{
    NSString *enhanceDetailPath = [NSString stringWithFormat:PZEnhanceDetailURL,_enHanceID];
    [self.manager GET:enhanceDetailPath success:^(NSURLResponse *response, NSData *data) {
        NSDictionary * responseArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (!_enhanceDetailArray) {
            _enhanceDetailArray = [NSMutableArray array];
        }
        PZEnhanceDetailModel * model = [[PZEnhanceDetailModel alloc]init];
        [model setValuesForKeysWithDictionary:responseArray];
        if ([self.Detaildelegate respondsToSelector:@selector(sendEnhanceDetail:)]) {
            [self.Detaildelegate sendEnhanceDetail:model.desc];
        }
    } failure:^(NSURLResponse *response, NSError *error) {
    }];

}
@end
