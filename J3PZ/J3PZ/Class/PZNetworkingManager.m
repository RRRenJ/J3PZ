//
//  PZNetworkingManager.m
//  J3PZ
//
//  Created by 千锋 on 16/1/5.
//  Copyright © 2016年 1111111111. All rights reserved.
//

#import "PZNetworkingManager.h"

@implementation PZNetworkingManager
{
    NSURLSession * _urlSession;
}
+(instancetype)manager{
    PZNetworkingManager * manager = [[PZNetworkingManager alloc]init];
    return manager;
}

-(instancetype)init{
    
    if (self = [super init]) {
        _urlSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    return self;
    
}

//请求数据
-(void)GET:(NSString *)url success:(RequestSuccess)success failure:(RequestFailure)failure{
    
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLSessionDataTask * task = [_urlSession dataTaskWithRequest:request completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
        if (!error) {
            if (success) {
                success(response, data);
            }else{
                if (failure) {
                    failure(response, error);
                }
            }
        }
    }];
    [task resume];
 
}
@end
