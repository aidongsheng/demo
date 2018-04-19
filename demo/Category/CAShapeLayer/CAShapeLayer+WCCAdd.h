//
//  CALayer+WCCAdd.h
//  demo
//
//  Created by wcc on 2018/4/12.
//  Copyright © 2018年 wcc. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
typedef NS_ENUM(NSUInteger, wccLayerShapeType) {
    wccLayerShapeTypeLine,
    wccLayerShapeTypePie,
    wccLayerShapeTypeCircle,
    wccLayerShapeTypeRectangle,
    wccLayerShapeTypeIsogon,
};
@interface CAShapeLayer (WCCAdd)
/**
 生成 CAShapeLayer 实例对象的类方法
 饼状图需要设置半径和 center
 
 @param shapeType 形状类型枚举
 @param strokeColor 线颜色
 @param fillColor 填充颜色
 @param width 线宽
 @param strokeStart 开始位置
 @param strokeEnd 结束位置
 @param animated 是否动画显示
 @return CAShapeLayer 实例对象
 */
+ (CAShapeLayer *)wcc_layerWithShapeType:(wccLayerShapeType)shapeType
                             strokeColor:(UIColor *)strokeColor
                               fillColor:(UIColor *)fillColor
                               lineWidth:(CGFloat)width
                             strokeStart:(CGFloat)strokeStart
                               strokeEnd:(CGFloat)strokeEnd
                                animated:(BOOL)animated;
@end
