//
//  WCCResourceLoader.h
//  demo
//
//  Created by wcc on 2018/4/19.
//  Copyright © 2018年 wcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCCResourceLoader : NSObject<AVAssetResourceLoaderDelegate>
+ (WCCResourceLoader *)shareInstance;
@end
