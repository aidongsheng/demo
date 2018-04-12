//
//  UIView+TouchEvent.h
//  demo
//
//  Created by wcc on 2018/4/12.
//  Copyright © 2018年 wcc. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^gestureActionBlock)(UIView *view);

@interface UIView (TouchEvent)

- (void)addBlock:(gestureActionBlock)block forUIControlEvent:(UIControlEvents)event;

@end
