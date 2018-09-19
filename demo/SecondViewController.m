//
//  SecondViewController.m
//  demo
//
//  Created by wcc on 2018/4/11.
//  Copyright © 2018年 wcc. All rights reserved.
//

#import "SecondViewController.h"
#import "FirstViewController.h"
#import "NetworkUtil.h"
#import <WebKit/WebKit.h>
#import <UIDevice+YYAdd.h>
#import "IPAddress.h"
#import <SystemConfiguration/CaptiveNetwork.h>


@interface SecondViewController ()<UIWebViewDelegate,WKUIDelegate>
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) WKWebView *webView;

@end

#define url_test_video   @"http://resbj.swochina.com/resource/ad/411521524218.mp4"

#define url_my_testVideo @"http://192.168.101.61:8000/download/womeiling.mp4"

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _btn = [[UIButton alloc]init];
    [_btn setTitle:@"tap" forState:UIControlStateNormal];
    [_btn setFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
    [self.view addSubview:_btn];
    [_btn addTarget:self action:@selector(tapAction) forControlEvents:UIControlEventTouchUpInside];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络状态");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"正常网络状态");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi 网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"无线广域网");
                break;
                
            default:
                break;
        }
    }];
    
}

- (id)tapAction
{
    NSDictionary *currentWifiInfo = nil;
    // 获取当前的interface 数组
    CFArrayRef currentInterfaces = CNCopySupportedInterfaces();
    
    if (!currentInterfaces) {
        return nil;
    }
    
    // 类型转换，将CF对象，转为NS对象，同时将该对象的引用计数交给 ARC 管理
    NSArray *interfaces = (__bridge NSArray *)(currentInterfaces);
    
    if (interfaces.count >0) {
        for (NSString *interfaceName in interfaces) {
            // 转换类型，不改变引用计数
            CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
            if (dictRef) {
                NSDictionary *networkInfo = (__bridge_transfer NSDictionary *) dictRef;
                NSString *SSID = [networkInfo objectForKey:(__bridge_transfer NSString *)kCNNetworkInfoKeySSID];
                NSString *BSSID = [networkInfo objectForKey:(__bridge_transfer NSString *)kCNNetworkInfoKeyBSSID];
                NSData *SSIDDATA = [networkInfo objectForKey:(__bridge_transfer NSData *)kCNNetworkInfoKeySSIDData];
                
                currentWifiInfo = @{@"SSID":SSID,
                                    @"BSSID":BSSID,
                                    @"SSIDDATA":SSIDDATA};
                
            }
        }
    }
    
    NSLog(@"currentWifiInfo = %@",currentWifiInfo);
    return  currentWifiInfo;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}


@end
