//
//  PZEquipDetailControl.h
//  J3PZ
//
//  Created by 千锋 on 16/1/6.
//  Copyright © 2016年 1111111111. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PZEquipDetailModel.h"

@protocol sendEquipDetilModel <NSObject>

-(void)sendEquipDetilModel:(PZEquipDetailModel *)model;

@end


@interface PZEquipDetailControl : UIControl

-(void)show;

-(instancetype)initWithFrame:(CGRect)frame andView:(UIView *)view;;

@property(nonatomic,weak)id<sendEquipDetilModel>delegate;

@end
