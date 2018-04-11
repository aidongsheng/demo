//
//  AppDelegate.m
//  demo
//
//  Created by wcc on 2018/4/11.
//  Copyright © 2018年 wcc. All rights reserved.
//

#import "AppDelegate.h"
#import "TabbarViewController.h"
#import "BaseNavigationController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    TabbarViewController *tabbarVC = [[TabbarViewController alloc]init];
    FirstViewController *firstVC = [[FirstViewController alloc]init];
    BaseNavigationController * firstNavi = [[BaseNavigationController alloc]initWithRootViewController:firstVC];
    SecondViewController *secondVC = [[SecondViewController alloc]init];
    BaseNavigationController * secondNavi = [[BaseNavigationController alloc]initWithRootViewController:secondVC];
    [tabbarVC setViewControllers:@[firstNavi,secondNavi]];
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _window.rootViewController = tabbarVC;
    [_window makeKeyAndVisible];
    
    
    UIImage *orignalImage = [[UIImage imageNamed:@"item"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *item1 = [[UITabBarItem alloc]initWithTitle:@"title1"
                                                       image:orignalImage
                                               selectedImage:orignalImage];
    UITabBarItem *item2 = [[UITabBarItem alloc]initWithTitle:@"title2"
                                                       image:orignalImage
                                               selectedImage:orignalImage];
    
    firstNavi.tabBarItem = item1;
    secondNavi.tabBarItem = item2;
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
