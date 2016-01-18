//
//  PZEquipCell.m
//  J3PZ
//
//  Created by 千锋 on 16/1/4.
//  Copyright © 2016年 1111111111. All rights reserved.
//

#import "PZEquipCell.h"
#import "PZEquipDetailControl.h"
#import <UIImageView+WebCache.h>
#import "PZEquipListDropControl.h"
@interface PZEquipCell ()

@end


@implementation PZEquipCell

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
-(void)setEquipDetailModel:(PZEquipDetailModel *)equipDetailModel{
    _equipDetailModel = equipDetailModel;
    
    NSURL * iconURL = [NSURL URLWithString:[NSString stringWithFormat:PZEquipIconURL,self.equipDetailModel.iconID]];
    [self.equipIcon sd_setImageWithURL:iconURL];
    self.EquipName.text = self.equipDetailModel.name;

    self.cellImageView.backgroundColor = [UIColor clearColor];
    self.stone1.backgroundColor = [UIColor clearColor];
    self.stone2.backgroundColor = [UIColor clearColor];
    self.EquipName.backgroundColor = [UIColor clearColor];
    self.EnhanceName.backgroundColor = [UIColor clearColor];
    self.equipIcon.backgroundColor = [UIColor clearColor];
}

@end
