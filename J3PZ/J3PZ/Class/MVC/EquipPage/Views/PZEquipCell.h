//
//  PZEquipCell.h
//  J3PZ
//
//  Created by 千锋 on 16/1/4.
//  Copyright © 2016年 1111111111. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PZEquipCell : UITableViewCell
//装备部位
@property (weak, nonatomic) IBOutlet UILabel *posName;
//装备名字
@property (weak, nonatomic) IBOutlet UILabel *EquipName;
//附魔名字
@property (weak, nonatomic) IBOutlet UILabel *EnhanceName;
//五彩石
@property (weak, nonatomic) IBOutlet UIImageView *stone1;
@property (weak, nonatomic) IBOutlet UIImageView *stone2;



@end
