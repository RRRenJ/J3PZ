//
//  PZEnhanceDetailController.m
//  J3PZ
//
//  Created by 千锋 on 16/1/8.
//  Copyright © 2016年 1111111111. All rights reserved.
//

#import "PZEnhanceDetailController.h"
#import "PZEnhanceDetailModel.h"

@interface PZEnhanceDetailController ()

@property(nonatomic,strong)PZEnhanceDetailModel * model;
@property(nonatomic,strong)NSMutableArray * dataArray;


@end


@implementation PZEnhanceDetailController

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

-(void)createData{
    _dataArray = [[NSMutableArray alloc]init];   
}


@end
