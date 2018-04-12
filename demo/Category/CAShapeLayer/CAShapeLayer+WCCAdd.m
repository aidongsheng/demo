//
//  CALayer+WCCAdd.m
//  demo
//
//  Created by wcc on 2018/4/12.
//  Copyright © 2018年 wcc. All rights reserved.
//

#import "CAShapeLayer+WCCAdd.h"

@implementation CAShapeLayer (WCCAdd)

/**
 生成 CAShapeLayer 类方法

 @param shapeType 形状类型枚举
 @param strokeColor 
 @param fillColor <#fillColor description#>
 @param width <#width description#>
 @param strokeStart <#strokeStart description#>
 @param strokeEnd <#strokeEnd description#>
 @param animated <#animated description#>
 @return <#return value description#>
 */
+ (CAShapeLayer *)wcc_layerWithShapeType:(wccLayerShapeType)shapeType
                             strokeColor:(UIColor *)strokeColor
                               fillColor:(UIColor *)fillColor
                               lineWidth:(CGFloat)width
                             strokeStart:(CGFloat)strokeStart
                               strokeEnd:(CGFloat)strokeEnd
                                animated:(BOOL)animated
{
    CAShapeLayer * layer = [CAShapeLayer layer];
    switch (shapeType) {
        case wccLayerShapeTypeLine:
            return [layer generateLineLayerWithStrokeColor:strokeColor
                                                 fillColor:fillColor
                                                 lineWidth:width
                                               strokeStart:strokeStart
                                                 strokeEnd:strokeEnd
                                                  animated:animated];
            break;
        case wccLayerShapeTypePie:
            return [layer generatePieLayerWithStrokeColor:strokeColor fillColor:fillColor lineWidth:width strokeStart:strokeStart strokeEnd:strokeEnd animated:animated];
            break;
            //        case wccLayerShapeTypeCircle:
            //            return [layer generateLineLayerWithStrokeColor:strokeColor fillColor:fillColor lineWidth:width];
            //            break;
            //        case wccLayerShapeTypeRectangle:
            //            return [layer generateLineLayerWithStrokeColor:strokeColor fillColor:fillColor lineWidth:width];
            //            break;
            //        case wccLayerShapeTypeIsogon:
            //            return [layer generateLineLayerWithStrokeColor:strokeColor fillColor:fillColor lineWidth:width];
            //            break;
        default:
            break;
    }
    return nil;
}
- (CAShapeLayer *)baseShapeLayerGeneratorWithStrokeColor:(UIColor *)strokeColor fillColor:(UIColor *)fillColor strokeStart:(CGFloat)strokeStart strokeEnd:(CGFloat)strokeEnd lineWidth:(CGFloat)lineWidth path:(UIBezierPath *)path animated:(BOOL)animated
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.lineWidth = lineWidth;
    shapeLayer.fillColor = fillColor.CGColor;
    shapeLayer.strokeColor = strokeColor.CGColor;
    shapeLayer.strokeStart = strokeStart;
    shapeLayer.strokeEnd = strokeEnd;
    return shapeLayer;
}
- (CAShapeLayer *)generateLineLayerWithStrokeColor:(UIColor *)strokeColor fillColor:(UIColor *)fillColor lineWidth:(CGFloat)width strokeStart:(CGFloat)strokeStart strokeEnd:(CGFloat)strokeEnd animated:(BOOL)animated
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, NavigationBarHeight+StatusBarHeight)];
    [path addLineToPoint:CGPointMake(DEVICE_WIDTH, DEVICE_HEIGHT - TabBarHeight)];
    [path stroke];
    [path fill];
    [path closePath];
    
    CAShapeLayer *layer = [self baseShapeLayerGeneratorWithStrokeColor:strokeColor fillColor:fillColor strokeStart:strokeStart strokeEnd:strokeEnd lineWidth:width path:path animated:animated];
    
    return layer;
}

- (CAShapeLayer *)generatePieLayerWithStrokeColor:(UIColor *)strokeColor fillColor:(UIColor *)fillColor lineWidth:(CGFloat)width strokeStart:(CGFloat)strokeStart strokeEnd:(CGFloat)strokeEnd animated:(BOOL)animated
{
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:CGPointMake(DEVICE_WIDTH/2, DEVICE_HEIGHT/2) radius:100 startAngle:0 endAngle:M_PI clockwise:YES];
    
    CAShapeLayer *layer = [self baseShapeLayerGeneratorWithStrokeColor:strokeColor fillColor:fillColor strokeStart:strokeStart strokeEnd:strokeEnd lineWidth:width path:path animated:animated];
    layer.lineCap = kCALineCapRound;
    layer.lineJoin = kCALineJoinRound;
    
    return layer;
}

//- (CAShapeLayer *)generateLineLayerWithStrokeColor:(UIColor *)strokeColor fillColor:(UIColor *)fillColor lineWidth:(CGFloat)width
//{
//    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path moveToPoint:CGPointMake(0, NavigationBarHeight+StatusBarHeight)];
//    [path addLineToPoint:CGPointMake(DEVICE_WIDTH, DEVICE_HEIGHT - TabBarHeight)];
//    [path stroke];
//    [path fill];
//    [path closePath];
//    shapeLayer.path = path.CGPath;
//    shapeLayer.lineWidth = width;
//    shapeLayer.fillColor = fillColor.CGColor;
//    shapeLayer.strokeColor = strokeColor.CGColor;
//    shapeLayer.strokeStart = 0;
//    shapeLayer.strokeEnd = 1;
//    return shapeLayer;
//}
//
//- (CAShapeLayer *)generateLineLayerWithStrokeColor:(UIColor *)strokeColor fillColor:(UIColor *)fillColor lineWidth:(CGFloat)width
//{
//    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path moveToPoint:CGPointMake(0, NavigationBarHeight+StatusBarHeight)];
//    [path addLineToPoint:CGPointMake(DEVICE_WIDTH, DEVICE_HEIGHT - TabBarHeight)];
//    [path stroke];
//    [path fill];
//    [path closePath];
//    shapeLayer.path = path.CGPath;
//    shapeLayer.lineWidth = width;
//    shapeLayer.fillColor = fillColor.CGColor;
//    shapeLayer.strokeColor = strokeColor.CGColor;
//    shapeLayer.strokeStart = 0;
//    shapeLayer.strokeEnd = 1;
//    return shapeLayer;
//}
//
//- (CAShapeLayer *)generateLineLayerWithStrokeColor:(UIColor *)strokeColor fillColor:(UIColor *)fillColor lineWidth:(CGFloat)width
//{
//    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path moveToPoint:CGPointMake(0, NavigationBarHeight+StatusBarHeight)];
//    [path addLineToPoint:CGPointMake(DEVICE_WIDTH, DEVICE_HEIGHT - TabBarHeight)];
//    [path stroke];
//    [path fill];
//    [path closePath];
//    shapeLayer.path = path.CGPath;
//    shapeLayer.lineWidth = width;
//    shapeLayer.fillColor = fillColor.CGColor;
//    shapeLayer.strokeColor = strokeColor.CGColor;
//    shapeLayer.strokeStart = 0;
//    shapeLayer.strokeEnd = 1;
//    return shapeLayer;
//}


@end
