//
//  PZOccupationViewController.m
//  J3PZ
//
//  Created by 千锋 on 16/1/4.
//  Copyright © 2016年 1111111111. All rights reserved.
//

#import "PZOccupationViewController.h"
#import "PZOccupationCell.h"

@interface PZOccupationViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) NSArray *XFArray;

@end

@implementation PZOccupationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"门派选择";
    [self createTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;

    
    [_tableView registerNib:[UINib nibWithNibName:@"PZOccupationCell" bundle:nil] forCellReuseIdentifier:@"PZOcell"];
    
   
    _dataArray = @[@{@"力道":@[@"天策",@"唐门",@"丐帮"]},@{@"元气":@[@"唐门",@"少林",@"万花",@"明教"]},@{@"根骨":@[@"纯阳",@"七秀",@"五毒",@"长歌"]},@{@"身法":@[@"藏剑",@"纯阳",@"苍云",]},@{@"防御":@[@"天策",@"少林",@"苍云",@"明教"]},@{@"治疗":@[@"七秀",@"长歌",@"万花",@"五毒"]}];
    _XFArray = @[@[@"傲血战意",@"惊羽诀",@"笑尘决"],@[@"天罗诡道",@"易筋经",@"花间游",@"焚影圣决"],@[@"紫霞功",@"冰心诀",@"毒经",@"莫问"],@[@"问水决/山居剑意",@"太虚剑意",@"分山劲"],@[@"铁牢律",@"洗髓经",@"铁骨衣",@"明尊琉璃体"],@[@"云裳心经",@"相知",@"离经易道",@"补天诀"]];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = [self.dataArray[section] allValues];
    NSArray *arr1 = arr[0];
    return arr1.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PZOccupationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PZOcell" forIndexPath:indexPath];
    NSArray *arr = [self.dataArray[indexPath.section] allValues];
    NSArray *arr1 = arr[0];
    cell.MartialImage.image = [UIImage imageNamed:arr1[indexPath.row]];
    NSArray *xf = self.XFArray[indexPath.section];
    cell.XFLabel.text = xf[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSArray *arr = [self.dataArray[section] allKeys];
    NSString *str = arr[0];
    return str;
}
@end
