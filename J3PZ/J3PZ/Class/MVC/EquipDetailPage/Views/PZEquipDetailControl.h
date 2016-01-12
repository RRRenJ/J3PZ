//
//  PZEquipDetailControl.h
//  J3PZ
//
//  Created by 千锋 on 16/1/6.
//  Copyright © 2016年 1111111111. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol sendModelIconID <NSObject>

-(void)sendModelIconID:(NSString *)iconID;

@end


@interface PZEquipDetailControl : UIControl

-(void)show;

-(instancetype)initWithFrame:(CGRect)frame andView:(UIView *)view;;

@property(nonatomic,weak)id<sendModelIconID>delegate;

@end
