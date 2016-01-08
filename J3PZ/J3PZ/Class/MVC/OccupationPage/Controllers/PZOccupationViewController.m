//
//  PZOccupationViewController.m
//  J3PZ
//
//  Created by 千锋 on 16/1/4.
//  Copyright © 2016年 1111111111. All rights reserved.
//

#import "PZOccupationViewController.h"

@interface PZOccupationViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation PZOccupationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationItem.title = @"门派选择";
    CGSize size = [UIScreen mainScreen].bounds.size;
    self.collectionView.frame = CGRectMake(0, 64, size.width, size.height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfItemsInSlidingMenu{
    return 12;
}
-(void)customizeCell:(RPSlidingMenuCell *)slidingMenuCell forRow:(NSInteger)row{
    NSArray *dataArray = @[@"长歌",@"苍云",@"丐帮",@"明教",@"唐门",@"五毒",@"万花",@"七秀",@"天策",@"少林",@"纯阳",@"藏剑"];
    slidingMenuCell.textLabel.text = dataArray[row];
    slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:dataArray[row]];
}

@end
