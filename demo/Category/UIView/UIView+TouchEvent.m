//
//  UIView+TouchEvent.m
//  demo
//
//  Created by wcc on 2018/4/12.
//  Copyright © 2018年 wcc. All rights reserved.
//

#import "UIView+TouchEvent.h"


@interface UIView(_TouchEvent)
@property (readwrite,nonatomic,copy,setter=actionBlock:) gestureActionBlock actionBlock;
@end

@implementation UIView (_TouchEvent)

- (void)addBlock:(gestureActionBlock)block forUIControlEvent:(UIControlEvents)event
{
    if (event == UIControlEventTouchUpInside) {
        NSLog(@"UIControlEventTouchUpInside");
        self.actionBlock = block;
    }else if (event == UIControlEventTouchDownRepeat){
        NSLog(@"UIControlEventTouchDownRepeat");
    }
    @synchronized(self){
        
    }
}


- (void)actionBlock:(gestureActionBlock)actionBlock
{
    objc_setAssociatedObject(self, @selector(actionBlock), actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (gestureActionBlock)actionBlock
{
    return (gestureActionBlock)objc_getAssociatedObject(self, @selector(actionBlock));
}
@end
