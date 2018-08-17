//
//  BaseViewController.m
//  demo
//
//  Created by wcc on 2018/8/6.
//  Copyright © 2018年 wcc. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AFSecurityPolicy * policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    [[YTKNetworkConfig sharedConfig] setSecurityPolicy:policy];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}


@end
