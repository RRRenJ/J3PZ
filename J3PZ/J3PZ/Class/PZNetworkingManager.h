//
//  PZNetworkingManager.h
//  J3PZ
//
//  Created by 千锋 on 16/1/5.
//  Copyright © 2016年 1111111111. All rights reserved.
//

#import <Foundation/Foundation.h>
//请求成功的Block
typedef void(^RequestSuccess)(NSURLResponse * response,NSData * data);
//请求失败的Block
typedef void(^RequestFailure)(NSURLRequest * response, NSError * error);

@interface PZNetworkingManager : NSObject

+(instancetype)manager;

-(void)GET:(NSString *)url success:(RequestSuccess)success failure:(RequestFailure)failure;


@end
