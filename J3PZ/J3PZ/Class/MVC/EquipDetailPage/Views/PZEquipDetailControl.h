//
//  PZEquipDetailControl.h
//  J3PZ
//
//  Created by 千锋 on 16/1/6.
//  Copyright © 2016年 1111111111. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PZEquipDetailModel.h"

@interface PZEquipDetailControl : UIControl

-(void)show;
-(void)reload;

-(instancetype)initWithFrame:(CGRect)frame andView:(UIView *)view;

@property(nonatomic,copy) NSString *equipListID;

@end
