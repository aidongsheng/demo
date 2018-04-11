//
//  UIViewController+DefaultView.m
//  demo
//
//  Created by wcc on 2018/4/11.
//  Copyright © 2018年 wcc. All rights reserved.
//

#import "UIViewController+DefaultView.h"
@interface UIViewController(_DefaultView)
@property (readwrite,nonatomic,strong,setter=labelShimmerView:) FBShimmeringView *labelShimmerView;
@end
@implementation UIViewController (_DefaultView)

- (void)showLoadingView
{
    [self.view wcc_addBackgroundColorAnimation:[UIColor colorWithHexString:@"f5f5f5"] duration:0 autoReverse:NO];
    UILabel * loadingLabel = [[UILabel alloc]init];
    
    loadingLabel.font = [UIFont fontWithName:@"Optima-BoldItalic" size:30];
    loadingLabel.numberOfLines = 0;
    loadingLabel.textAlignment = NSTextAlignmentCenter;
    loadingLabel.textColor = [UIColor colorWithHexString:@"dedfe0"];
    self.labelShimmerView = [[FBShimmeringView alloc]init];
    self.labelShimmerView.shimmeringDirection = FBShimmerDirectionRight;
    [self.labelShimmerView wcc_addRotationXYAnimation:-M_PI_4/8.0 duration:0 autoReverse:NO];
    self.labelShimmerView.contentView = loadingLabel;
    [self.view addSubview:self.labelShimmerView];
    [self.labelShimmerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.width.equalTo(@(self.view.width)).multipliedBy(0.5);
        make.height.equalTo(@(self.view.height)).multipliedBy(0.5);
    }];
    loadingLabel.text = [NSString stringWithFormat:@"what you focus on\n is the news"];
    self.labelShimmerView.shimmering = YES;
    self.labelShimmerView.shimmeringHighlightLength = 0.25;
    self.labelShimmerView.shimmeringSpeed = 280;
    self.labelShimmerView.shimmeringPauseDuration = 0;
}

- (void)hideLoadingView
{
    [self.labelShimmerView wcc_addAlphaAnimation:0 duration:0.3 autoReverse:NO];
}

- (void)showNetworkErrorView
{
    
}

- (void)hideNetworkErrorView
{
    
}

- (void)labelShimmerView:(FBShimmeringView *)labelShimmerView
{
    objc_setAssociatedObject(self, @selector(labelShimmerView),labelShimmerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (FBShimmeringView *)labelShimmerView
{
    return (FBShimmeringView *)objc_getAssociatedObject(self, @selector(labelShimmerView));
}
@end
