//
//  AppDelegate+InitViewController.m
//  demo
//
//  Created by wcc on 2018/4/12.
//  Copyright © 2018年 wcc. All rights reserved.
//

#import "AppDelegate+InitViewController.h"
#import "TabbarViewController.h"
#import "BaseNavigationController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

@implementation AppDelegate (InitViewController)

- (void)initViewControllers
{
    TabbarViewController *tabbarVC = [[TabbarViewController alloc]init];
    FirstViewController *firstVC = [[FirstViewController alloc]init];
    BaseNavigationController * firstNavi = [[BaseNavigationController alloc]initWithRootViewController:firstVC];
    SecondViewController *secondVC = [[SecondViewController alloc]init];
    BaseNavigationController * secondNavi = [[BaseNavigationController alloc]initWithRootViewController:secondVC];
    [tabbarVC setViewControllers:@[firstNavi,secondNavi]];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = tabbarVC;
    [self.window makeKeyAndVisible];
    
    
    UIImage *orignalImage = [[UIImage imageNamed:@"item"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *item1 = [[UITabBarItem alloc]initWithTitle:@"title1"
                                                       image:orignalImage
                                               selectedImage:orignalImage];
    UITabBarItem *item2 = [[UITabBarItem alloc]initWithTitle:@"title2"
                                                       image:orignalImage
                                               selectedImage:orignalImage];
    
    firstNavi.tabBarItem = item1;
    secondNavi.tabBarItem = item2;
}

@end
