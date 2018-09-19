//
//  UIViewController+DefaultView.h
//  demo
//
//  Created by wcc on 2018/4/11.
//  Copyright © 2018年 wcc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (DefaultView)

- (void)showText:(NSString *)text;
- (void)showTitle:(NSString *)title detailText:(NSString *)detailText;
- (void)showSuccess:(NSString *)title imageURL:(NSString *)imgURL;
- (void)showFailure:(NSString *)title imageURL:(NSString *)imgURL;

- (void)showLoadingView;
- (void)hideLoadingView;
- (void)showNetworkErrorView;
- (void)hideNetworkErrorView;

@end
