//
//  FirstViewController.m
//  demo
//
//  Created by wcc on 2018/4/11.
//  Copyright © 2018年 wcc. All rights reserved.
//

#import "FirstViewController.h"
#import "CAShapeLayer+WCCAdd.h"
#import "MainModel.h"

@interface FirstViewController ()<POPAnimationDelegate>
@property (nonatomic,strong) CAShapeLayer *pie;
@end
BOOL flag;



@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showLoadingView];
    DLog(@"app version %@ %@",[MainModel shareObject].strAppVersion,[MainModel shareObject].strDeviceModel);
}

- (void)pop_animationDidStop:(POPAnimation *)anim finished:(BOOL)finished
{
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
}
@end
