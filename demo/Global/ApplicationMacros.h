//
//  ApplicationMacros.h
//  demo
//
//  Created by wcc on 2018/4/12.
//  Copyright © 2018年 wcc. All rights reserved.
//

#ifndef ApplicationMacros_h
#define ApplicationMacros_h

#ifdef DEBUG
#define DLog(...) NSLog(__VA_ARGS__)
#endif

#define keywindow   [UIApplication sharedApplication].keyWindow

#endif /* ApplicationMacros_h */
