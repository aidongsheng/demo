//
//  WCCResourceLoader.h
//  demo
//
//  Created by wcc on 2018/4/19.
//  Copyright © 2018年 wcc. All rights reserved.
//

#import <Foundation/Foundation.h>
#define MimeType @"video/mp4"
@interface WCCResourceLoader : NSObject<AVAssetResourceLoaderDelegate>
@property (atomic, assign) BOOL seekRequired; //Seek标识
+ (WCCResourceLoader *)shareInstance;
@end
