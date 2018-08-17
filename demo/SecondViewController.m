//
//  SecondViewController.m
//  demo
//
//  Created by wcc on 2018/4/11.
//  Copyright © 2018年 wcc. All rights reserved.
//

#import "SecondViewController.h"
#import "FirstViewController.h"

@interface SecondViewController ()
@property (nonatomic, strong) UIButton *btn;
@end

#define url_test_video   @"http://resbj.swochina.com/resource/ad/411521524218.mp4"

#define url_my_testVideo @"http://192.168.101.61:8000/download/womeiling.mp4"

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    
    _btn = [[UIButton alloc]init];
    [_btn setTitle:@"tap" forState:UIControlStateNormal];
    [_btn setFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
    [self.view addSubview:_btn];
    [_btn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        NSURL *wcc = [NSURL URLWithString:@"forfixcrash://"];
        if ([[UIApplication sharedApplication] canOpenURL:wcc]) {
            [[UIApplication sharedApplication] openURL:wcc];
        }
    }];
    [_btn addTarget:self action:@selector(tapAction) forControlEvents:UIControlEventTouchUpInside];
}
- (void)tapAction
{
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
}
@end
