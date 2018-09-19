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
- (NSString *)strAppName
{
    return [[self bundleInfoDictionary] objectForKey:@"CFBundleName"];
}
- (NSString *)strBundleIdentifier
{
    return [[self bundleInfoDictionary] objectForKey:@"CFBundleIdentifier"];
}

- (NSString *)strPlatformVersion
{
    return [[self bundleInfoDictionary] objectForKey:@"DTPlatformVersion"];
}
- (NSString *)strSDKName
{
    return [[self bundleInfoDictionary] objectForKey:@"DTSDKName"];
}
- (NSString *)strMinimumOSVersion
{
    return [[self bundleInfoDictionary] objectForKey:@"MinimumOSVersion"];
}
- (NSString *)strAllowATS
{
    NSDictionary *dicATS = [[self bundleInfoDictionary] objectForKey:@"NSAppTransportSecurity"];
    return [NSString stringWithFormat:@"%@",[dicATS objectForKey:@"NSAllowsArbitraryLoads"]];
}
- (NSDictionary *)dicStatusBarTint
{
    return [[self bundleInfoDictionary] objectForKey:@"UIStatusBarTintParameters"];
}

- (NSArray *)arrSupportedOrientations
{
    return [[self bundleInfoDictionary] objectForKey:@"UISupportedInterfaceOrientations"];
}
- (NSString *)strCompiler
{
    return [[self bundleInfoDictionary] objectForKey:@"DTCompiler"];
}
- (NSString *)strMachineOSBuild
{
    return [[self bundleInfoDictionary] objectForKey:@"BuildMachineOSBuild"];
}
- (NSString *)strDevelopmentRegion
{
    return [[self bundleInfoDictionary] objectForKey:@"CFBundleDevelopmentRegion"];
}
- (BOOL)isSimulator
{
#if TARGET_OS_SIMULATOR
    return YES;
#else
    return NO;
#endif
}

@end
