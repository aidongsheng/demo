//
//  MainModel.h
//  demo
//
//  Created by wcc on 2018/8/1.
//  Copyright © 2018年 wcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainModel : NSObject
@property (nonatomic, strong) NSString * strAppVersion;
@property (nonatomic, strong) NSString * strBuild;
@property (nonatomic, strong) NSString * strDeviceModel;
@property (nonatomic, strong) NSString * strAppName;
@property (nonatomic, strong) NSString * strBundleIdentifier;
@property (nonatomic ,strong) NSString * strPlatformVersion;
@property (nonatomic ,strong) NSString * strSDKName;
@property (nonatomic ,strong) NSString * strMinimumOSVersion;
@property (nonatomic ,strong) NSString * strAllowATS;
@property (nonatomic ,strong) NSDictionary * dicStatusBarTint;
@property (nonatomic, strong) NSArray *arrSupportedOrientations;
@property (nonatomic, strong) NSString * strCompiler;
@property (nonatomic, strong) NSString * strMachineOSBuild;
@property (nonatomic, strong) NSString * strDevelopmentRegion;
@property (nonatomic, assign) BOOL isSimulator;                 //  判断当前设备是不是模拟器

+ (MainModel *)shareObject;
@end
