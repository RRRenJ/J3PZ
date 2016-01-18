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
#import "PZEquipDetailControl.h"
#import "PZEquipDetailModel.h"

@interface PZEquipViewController ()<UITableViewDataSource,UITableViewDelegate,sendEquipDetilModel>

@property(nonatomic,strong)UIWindow * window;
@property(nonatomic,strong)UIView * upView;
@property(nonatomic,copy)NSString * equipIndex;;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSString * equipIconID;
@property(nonatomic,strong)PZNetworkingManager * manager;
@property(nonatomic,strong)PZEquipDetailModel * equipDetailModel;

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
    self.backImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"backImage_%d",arc4random()%3]];
    self.backImageView.userInteractionEnabled = YES;
    [self createTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark - createUI
-(void)createTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -20,SCREEN_WIDTH ,SCREEN_HEIGHT)];
    [self.backImageView addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    //注册CELL
    [self.tableView registerNib:[UINib nibWithNibName:@"PZEquipCell" bundle:nil] forCellReuseIdentifier:@"PZEquipCell"];
    
    PZEquipDetailControl * equipDC = [[PZEquipDetailControl alloc]init];
    equipDC.delegate = self;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 12;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PZEquipCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PZEquipCell" forIndexPath:indexPath];
    switch (indexPath.row) {
        case 0:
            cell.equipIcon.image = [UIImage imageNamed:@"头部"];
            break;
        case 1:
            cell.equipIcon.image = [UIImage imageNamed:@"上衣"];
            break;
        case 2:
            cell.equipIcon.image = [UIImage imageNamed:@"腰部"];
            break;
        case 3:
            cell.equipIcon.image = [UIImage imageNamed:@"护腕"];
            break;
        case 4:
            cell.equipIcon.image = [UIImage imageNamed:@"武器"];
            break;
        case 5:
            cell.equipIcon.image = [UIImage imageNamed:@"暗器"];
            break;
        case 6:
            cell.equipIcon.image = [UIImage imageNamed:@"下装"];
            break;
        case 7:
            cell.equipIcon.image = [UIImage imageNamed:@"鞋子"];
            break;
        case 8:
            cell.equipIcon.image = [UIImage imageNamed:@"项链"];
            break;
        case 9:
            cell.equipIcon.image = [UIImage imageNamed:@"腰坠"];
            break;
        case 10:
            cell.equipIcon.image = [UIImage imageNamed:@"戒指"];
            break;
        case 11:
            cell.equipIcon.image = [UIImage imageNamed:@"戒指"];
            break;
//        case 12:
//            cell.equipIcon.image = [UIImage imageNamed:@"头部"];
//            break;
//            
        default:
            break;
    }
    cell.EquipName.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"label_bk"]] ;
    cell.EnhanceName.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"label_bk"]];
    cell.stone1.image = [UIImage imageNamed:@"stone_bk"];
    cell.stone2.image = [UIImage imageNamed:@"stone_bk"];
    if (self.equipDetailModel.iconID != nil) {
        cell.equipDetailModel = self.equipDetailModel;
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _equipIndex = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    PZEquipDetailViewController * equipDetailVC = [[PZEquipDetailViewController alloc]init];
    equipDetailVC.xinfa = _xfDetail;
    equipDetailVC.pos = _equipIndex;
    //弹窗实现
    UIWindow * window = [[UIWindow alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, 0, SCREEN_HEIGHT)];
    window.windowLevel = UIWindowLevelNormal;
    window.hidden = NO;
    [window makeKeyAndVisible];
    UINavigationController * navi = [[UINavigationController alloc]initWithRootViewController:equipDetailVC];
    equipDetailVC.view.frame = window.bounds;
    window.rootViewController = navi;
    self.window = window;
    
    UIView * view = [[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:view];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [view addGestureRecognizer:tap];
    self.upView = view;
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:6 options:UIViewAnimationOptionCurveEaseIn animations:^{
        window.frame = CGRectMake(100, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    } completion:^(BOOL finished) {
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
    
}

-(void)tapAction{
    [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:6 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.window.frame = CGRectMake(SCREEN_WIDTH, 0, 0, SCREEN_HEIGHT);
        self.upView.backgroundColor = [[UIColor clearColor] colorWithAlphaComponent:0.5];
    } completion:^(BOOL finished) {
        [self.upView removeFromSuperview];
        [self.window resignKeyWindow];
        self.upView = nil;
        self.window = nil;
        self.navigationController.navigationBarHidden = NO;
        self.tabBarController.tabBar.hidden = NO;
    }];
    
}
-(void)sendEquipDetilModel:(PZEquipDetailModel *)model{
    self.equipDetailModel = model;
    dispatch_async(dispatch_get_main_queue(), ^{
        [_tableView reloadData];
    });
}



@end
