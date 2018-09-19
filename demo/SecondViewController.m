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
    [_btn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [[HTTPHelper shareInstance] wccGET:@"http://ifconfig.me/ip" parameters:nil progress:^(NSProgress *downloadProgress) {
            NSLog(@"progress:%f",(double)downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        } success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
            NSLog(@"responseObject:%@",responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
            NSLog(@"error:%@",error.description);
        }];
    }];
    [_btn addTarget:self action:@selector(tapAction) forControlEvents:UIControlEventTouchUpInside];
    
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
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

- (void)tapAction
{
    
    [self getIPAddress];
}
//获取ip地址
- (void)getIPAddress
{
    InitAddresses();
    GetIPAddresses();
    GetHWAddresses();

    int i;
    //    NSString *deviceIP = nil;
    for (i=0; i<MAXADDRS; ++i)
    {
        static unsigned long localHost = 0x7F000001;            // 127.0.0.1
        unsigned long theAddr;

        theAddr = ip_addrs[i];

        if (theAddr == 0) break;
        if (theAddr == localHost) continue;

        NSLog(@"Name: %s MAC: %s IP: %s\n", if_names[i], hw_addrs[i], ip_names[i]);
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}


@end
