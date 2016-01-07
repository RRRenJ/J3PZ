//
//  PZEnhanceModel.m
//  J3PZ
//
//  Created by 千锋 on 16/1/7.
//  Copyright © 2016年 1111111111. All rights reserved.
//

#import "PZEnhanceModel.h"

@implementation PZEnhanceModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.Id = value;
    }
}


@end
