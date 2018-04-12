//
//  FirstViewController.m
//  demo
//
//  Created by wcc on 2018/4/11.
//  Copyright © 2018年 wcc. All rights reserved.
//

#import "FirstViewController.h"
#import "CAShapeLayer+WCCAdd.h"

@interface FirstViewController ()<POPAnimationDelegate>
@property (nonatomic,strong) CAShapeLayer *pie;
@end
BOOL flag;



@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showLoadingView];
    
    UIColor *strokeColor = [UIColor qmui_randomColor];
    UIColor *fillColor = [UIColor qmui_randomColor];
    CAShapeLayer *line = [CAShapeLayer wcc_layerWithShapeType:wccLayerShapeTypeLine strokeColor:[UIColor yellowColor] fillColor:fillColor lineWidth:20 strokeStart:0 strokeEnd:0.7 animated:YES];
    _pie = [CAShapeLayer wcc_layerWithShapeType:wccLayerShapeTypePie strokeColor:[UIColor redColor] fillColor:nil lineWidth:50 strokeStart:0 strokeEnd:0 animated:YES];
    [self.view.layer addSublayer:line];
    [self.view.layer addSublayer:_pie];
    
    POPBasicAnimation * anim = [POPBasicAnimation animation];
    
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    anim.toValue = @(arc4random()%100/100.0);
    anim.duration = 0.5;
    
    POPAnimatableProperty *prop = [POPAnimatableProperty propertyWithName:kPOPShapeLayerStrokeEnd initializer:^(POPMutableAnimatableProperty *prop) {
        prop.writeBlock = ^(id obj, const CGFloat *values) {
            CAShapeLayer *layer = obj;
            CGFloat strokeEnd = values[0];
            layer.strokeEnd = strokeEnd;
        };
    }];
    anim.property = prop;
    anim.removedOnCompletion = YES;
    anim.delegate = self;
    [_pie pop_addAnimation:anim forKey:@"pieAnimationKey"];
    
    
}

- (void)pop_animationDidStop:(POPAnimation *)anim finished:(BOOL)finished
{
    if (finished) {
        POPBasicAnimation * anim = [POPBasicAnimation animation];
        
        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        anim.toValue = @(arc4random()%100/100.0);
        anim.duration = 0.5;
        
        POPAnimatableProperty *prop = [POPAnimatableProperty propertyWithName:kPOPShapeLayerStrokeEnd initializer:^(POPMutableAnimatableProperty *prop) {
            prop.writeBlock = ^(id obj, const CGFloat *values) {
                CAShapeLayer *layer = obj;
                CGFloat strokeEnd = values[0];
                layer.strokeEnd = strokeEnd;
            };
        }];
        anim.property = prop;
        anim.removedOnCompletion = YES;
        anim.delegate = self;
        [_pie pop_addAnimation:anim forKey:@"pieAnimationKey"];
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];

    flag = !flag;
    if (flag) {
//        [self hideLoadingView];
        [self showNetworkErrorView];
    }else{
//        [self showLoadingView];
        [self hideNetworkErrorView];
    }
}
@end
