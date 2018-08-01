//
//  MainModel.m
//  demo
//
//  Created by wcc on 2018/8/1.
//  Copyright © 2018年 wcc. All rights reserved.
//

#import "MainModel.h"

static MainModel * instance;
@implementation MainModel

+ (MainModel *)shareObject
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!instance) {
            instance = [[MainModel alloc]init];
        }
    });
    return instance;
}

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

- (NSDictionary *)bundleInfoDictionary
{
    return [[NSBundle mainBundle] infoDictionary];
}

- (NSString *)strAppVersion
{
    return [[self bundleInfoDictionary] objectForKey:@"CFBundleShortVersionString"];
}
- (NSString *)strBuild
{
    return [[self bundleInfoDictionary] objectForKey:@"CFBundleVersion"];
}
- (NSString *)strDeviceModel
{
    return [UIDevice currentDevice].model;
}
@end
