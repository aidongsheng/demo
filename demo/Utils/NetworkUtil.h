//
//  NetworkUtil.h
//  demo
//
//  Created by wcc on 2018/8/22.
//  Copyright © 2018年 wcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkUtil : NSObject
@property (nonatomic, strong, readonly) NSString * ipAddressWIFI;   //  WiFi网络下的设备 IP 地址
@property (nonatomic, strong, readonly) NSString * ipAddressCell;   //  WiFi网络下的设备 IP 地址
+ (NetworkUtil *)shareUtil;
@end
