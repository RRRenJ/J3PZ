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

@interface PZEquipViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UIWindow * window;
@property(nonatomic,strong)UIView * upView;
@property(nonatomic,copy)NSString * equipIndex;;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSString * equipIconID;
@property(nonatomic,strong)PZNetworkingManager * manager;
//@property(nonatomic,strong)PZEquipDetailModel * equipDetailModel;
@property(nonatomic,strong)NSMutableArray * modelArray;
@property(nonatomic,strong)NSMutableArray * imageArray;
@property(nonatomic,strong)NSMutableArray * indexArray;

@end

@implementation PZEquipViewController
-(PZNetworkingManager *)manager{
    if (!_manager) {
        _manager = [PZNetworkingManager manager];
    }
    return _manager;
}

-(NSMutableArray *)modelArray{
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
        for (int index = 0; index< 12; index++) {
            [_modelArray addObject:@"rrr"];
        }
    }
    return _modelArray;
}

-(NSMutableArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
        NSArray * nameArray = @[@"头部",@"上衣",@"腰部",@"护腕",@"下装",@"鞋子",@"项链",@"腰坠",@"戒指",@"戒指",@"暗器",@"武器"];
        for (int index = 0; index <nameArray.count; index ++) {
            UIImage * image = [UIImage imageNamed:nameArray[index]];
            [_imageArray addObject:image];
        }
        
    }
    return _imageArray;
}
-(NSMutableArray *)indexArray{
    if (!_indexArray) {
        _indexArray=[NSMutableArray array];
    }
    return _indexArray;
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
    self.equipIndex = @"88";
    //注册CELL
    [self.tableView registerNib:[UINib nibWithNibName:@"PZEquipCell" bundle:nil] forCellReuseIdentifier:@"PZEquipCell"];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 12;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PZEquipCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PZEquipCell" forIndexPath:indexPath];
    NSString * indexString = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    if ([self.indexArray indexOfObject:indexString] != NSNotFound) {
        PZEquipDetailModel * equipDetailModel = self.modelArray[indexPath.row];
        cell.equipDetailModel = equipDetailModel;
    }else{
        cell.equipIcon.image = self.imageArray[indexPath.row];
    }
    
    
    cell.EquipName.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"label_bk"]] ;
    cell.EnhanceName.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"label_bk"]];
    cell.stone1.image = [UIImage imageNamed:@"stone_bk"];
    cell.stone2.image = [UIImage imageNamed:@"stone_bk"];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _equipIndex = [NSString stringWithFormat:@"%ld",indexPath.row];
    [self.indexArray addObject:_equipIndex];
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendDetailModel:) name:@"sendDetailModel" object:nil];
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

-(void)sendDetailModel:(NSNotification *)notif{
    NSDictionary * dict = notif.userInfo;
//    self.equipDetailModel = dict[@"model"];
    [self.modelArray removeObjectAtIndex:[self.equipIndex integerValue]];
    [self.modelArray insertObject:dict[@"model"] atIndex:[self.equipIndex integerValue]];
    NSLog(@"!!!!!!!!!!!!!!!!");
    dispatch_async(dispatch_get_main_queue(), ^{
        [_tableView reloadData];
    });
}


@end
