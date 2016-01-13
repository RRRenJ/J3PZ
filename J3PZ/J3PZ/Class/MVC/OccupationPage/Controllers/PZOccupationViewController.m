//
//  PZOccupationViewController.m
//  J3PZ
//
//  Created by 千锋 on 16/1/4.
//  Copyright © 2016年 1111111111. All rights reserved.
//

#import "PZOccupationViewController.h"
#import "CDSideBarController.h"
#import "PZEquipViewController.h"


@interface PZOccupationViewController ()<CDSideBarControllerDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong) CDSideBarController *sideBar;
@property (nonatomic,strong) UIView *vieww;
@property (nonatomic,assign) NSInteger index;

@end

@implementation PZOccupationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"门派选择";
    self.collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"JX3 + Rectangle 1"]];
    CGSize size = [UIScreen mainScreen].bounds.size;
    self.collectionView.frame = CGRectMake(0, 64, size.width, size.height);
    
    NSArray *imageList = @[[UIImage imageNamed:@"长歌1"], [UIImage imageNamed:@"苍云1"], [UIImage imageNamed:@"丐帮1"], [UIImage imageNamed:@"明教1"],[UIImage imageNamed:@"唐门1"], [UIImage imageNamed:@"五毒1"], [UIImage imageNamed:@"万花1"], [UIImage imageNamed:@"七秀1"],[UIImage imageNamed:@"天策1"], [UIImage imageNamed:@"少林1"], [UIImage imageNamed:@"纯阳1"], [UIImage imageNamed:@"藏剑1"]];
    _sideBar = [[CDSideBarController alloc] initWithImages:imageList];
    _sideBar.delegate = self;
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [_sideBar insertMenuButtonOnView:self.view atPosition:CGPointMake(self.view.frame.size.width - 70, self.view.frame.size.height-100)];
}
-(NSInteger)numberOfItemsInSlidingMenu{
    return 12;
}
-(void)customizeCell:(RPSlidingMenuCell *)slidingMenuCell forRow:(NSInteger)row{
    NSArray *dataArray = @[@"长歌",@"苍云",@"丐帮",@"明教",@"唐门",@"五毒",@"万花",@"七秀",@"天策",@"少林",@"纯阳",@"藏剑"];
    NSArray *xfArray = @[@[@"相知",@"莫问"],@[@"分山劲",@"铁骨衣"],@[@"笑尘诀",@""],@[@"焚影圣诀",@"明尊琉璃体"],@[@"惊羽诀",@"天罗诡道"],@[@"毒经",@"补天诀"],@[@"花间游",@"离经易道"],@[@"冰心诀",@"云裳心经"],@[@"傲血战意",@"铁牢律"],@[@"易筋经",@"洗髓经"],@[@"紫霞功",@"太虚剑意"],@[@"问水诀",@"山居剑意"]];
    slidingMenuCell.textLabel.text = dataArray[row];
    slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:dataArray[row]];
    NSArray *xfDetail = xfArray[row];
    [slidingMenuCell.XFdetail_one setTitle:xfDetail[0] forState:UIControlStateNormal];
    [slidingMenuCell.XFdetail_two setTitle:xfDetail[1] forState:UIControlStateNormal];
    
    [slidingMenuCell.XFdetail_one addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    [slidingMenuCell.XFdetail_two addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)clicked:(UIButton *)sender{
    NSDictionary *XFdic = @{@"相知":@"xiangzhi",@"莫问":@"mowen",@"分山劲":@"fenshan",@"铁骨衣":@"tiegu",@"笑尘诀":@"xiaochen",@"焚影圣诀":@"fenying",@"明尊琉璃体":@"mingzun",@"惊羽诀":@"jingyu",@"天罗诡道":@"tianluo",@"毒经":@"dujing",@"补天诀":@"butian",@"花间游":@"huajian",@"离经易道":@"lijing",@"冰心诀":@"bingxin",@"云裳心经":@"yunshang",@"傲血战意":@"aoxue",@"铁牢律":@"tielao",@"易筋经":@"yijin",@"洗髓经":@"xisui",@"紫霞功":@"zixia",@"太虚剑意":@"taixu",@"问水诀":@"wenshui",@"山居剑意":@"shanju"};
    NSString *str = [XFdic objectForKey:sender.titleLabel.text];
    PZEquipViewController *PZEquipVC = [[PZEquipViewController alloc]init];
    PZEquipVC.xfDetail = str;
    [self.navigationController pushViewController:PZEquipVC animated:YES];
}


#pragma mark - CDSideBarController delegate

- (void)menuButtonClicked:(int)index
{
    _index = index;
    [self slidingMenu:self didSelectItemAtRow:_index];
}
@end
