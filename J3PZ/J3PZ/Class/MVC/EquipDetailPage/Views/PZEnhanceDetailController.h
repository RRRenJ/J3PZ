//
//  PZEnhanceDetailController.h
//  J3PZ
//
//  Created by 千锋 on 16/1/8.
//  Copyright © 2016年 1111111111. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol sendEnhanceValue <NSObject>
-(void)sendEnhanceName:(NSString *)enhanceName;
-(void)sendEnhanceDetail:(NSString *)enhanceDetail;
@end

@interface PZEnhanceDetailController : UIControl

@property (nonatomic,weak) id<sendEnhanceValue>delegate;
@property (nonatomic,weak) id<sendEnhanceValue>Detaildelegate;


-(void)show;

-(instancetype)initWithInsideFrame:(CGRect)frame inView:(UIView *)view andDataSource:(NSArray *)dataArray;
@end
