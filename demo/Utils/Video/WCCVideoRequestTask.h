//
//  WCCVideoRequestTask.h
//  demo
//
//  Created by wcc on 2018/4/19.
//  Copyright © 2018年 wcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL(WCCAdd)
- (NSURL *)customSchemeURL;
- (NSURL *)originalSchemeURL;
@end



@protocol WCCVideoRequestTaskDelegate<NSObject>

@end

@interface WCCVideoRequestTask : NSObject
@property (nonatomic,weak)   id<WCCVideoRequestTaskDelegate>delegate;
@property (nonatomic,strong) NSURL *urlRequest;             //  请求的链接
@property (nonatomic,assign) BOOL cache;                    //  是否需要缓存
@property (nonatomic,assign) NSUInteger fileLength;         //  文件长度
@property (nonatomic,assign) NSUInteger cacheLength;        //  缓存长度
@property (nonatomic,assign) NSUInteger requestOffset;      //  请求起始位置

/**
 开始请求
 */
- (void)start;

/**
 取消请求
 */
- (void)cancel;
@end
