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
@interface PZEquipCell ()<sendModelIconID,sendModelValue>

@property(nonatomic,strong)NSString * equipIconID;
@property(nonatomic,strong)NSString * equipName;
@end


@implementation PZEquipCell

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
-(void)setModel:(PZEquipModel *)model{
    _model = model;
    PZEquipDetailControl * equipDC = [[PZEquipDetailControl alloc]init];
    equipDC.delegate = self;
    PZEquipListDropControl * equipListDC = [[PZEquipListDropControl alloc]init];
    equipListDC.delegate = self;
    
    NSURL * iconURL = [NSURL URLWithString:[NSString stringWithFormat:PZEquipIconURL,_equipIconID]];
    [self.equipIcon sd_setImageWithURL:iconURL placeholderImage:[UIImage imageNamed:@"1600"]];
    self.EquipName.text = _equipName;
}



-(void)sendModelIconID:(NSString *)iconID{
    _equipIconID = iconID;
}
-(void)sendEquipListName:(NSString *)equipListName{
    _equipName = equipListName;
}



@end
