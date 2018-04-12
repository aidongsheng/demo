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
+ (CAShapeLayer *)wcc_layerWithShapeType:(wccLayerShapeType)shapeType
                             strokeColor:(UIColor *)strokeColor
                               fillColor:(UIColor *)fillColor
                               lineWidth:(CGFloat)width
                             strokeStart:(CGFloat)strokeStart
                               strokeEnd:(CGFloat)strokeEnd animated:(BOOL)animated;
@end
