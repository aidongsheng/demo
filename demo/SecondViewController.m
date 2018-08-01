//
//  SecondViewController.m
//  demo
//
//  Created by wcc on 2018/4/11.
//  Copyright © 2018年 wcc. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

#define url_test_video   @"http://resbj.swochina.com/resource/ad/411521524218.mp4"

#define url_my_testVideo @"http://192.168.101.61:8000/download/womeiling.mp4"

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

@end
