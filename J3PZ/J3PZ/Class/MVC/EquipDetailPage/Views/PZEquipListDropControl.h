//
//  PZEquipListDropControl.h
//  J3PZ
//
//  Created by 千锋 on 16/1/5.
//  Copyright © 2016年 1111111111. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol sendEquipListID <NSObject>

-(void)sendEquipListID:(NSString *)equipListID;

@end




@interface PZEquipListDropControl : UIControl

@property(nonatomic,strong)id<sendEquipListID>delegate;

-(void)show;
-(void)hide;

-(instancetype)initWithInsideFrame:(CGRect)frame inView:(UIView *)view dataSource:(NSArray *)dataArray;

@end
