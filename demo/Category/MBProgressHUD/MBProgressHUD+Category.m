//
//  MBProgressHUD+Category.m
//  demo
//
//  Created by wcc on 2018/4/12.
//  Copyright © 2018年 wcc. All rights reserved.
//

#import "MBProgressHUD+Category.h"

#define HUD_HIDE_DURATION  1


@implementation MBProgressHUD (Category)

+ (void)showText:(NSString *)hudString
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:keywindow.rootViewController.view animated:YES];
    hud.userInteractionEnabled = YES;
    hud.mode = MBProgressHUDModeText;
    hud.label.text = hudString;
    hud.animationType = MBProgressHUDAnimationZoom;
    [hud hideAnimated:YES afterDelay:HUD_HIDE_DURATION];
}
@end
