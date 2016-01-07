//
//  PZEquipViewController.h
//  J3PZ
//
//  Created by 千锋 on 16/1/4.
//  Copyright © 2016年 1111111111. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol sendDataArray <NSObject>

-(void)sendEquipListArray:(NSArray *)equipListArray;
-(void)sendEnhanceListArray:(NSArray *)enhanceListArray;

@end

@interface PZEquipViewController : UIViewController

@property(nonatomic,weak)id<sendDataArray>delegate;


@end
