//
//  WCCVideoRequestTask.m
//  demo
//
//  Created by wcc on 2018/4/19.
//  Copyright © 2018年 wcc. All rights reserved.
//



#import "WCCVideoRequestTask.h"
#import "WCCFileManager.h"

@implementation NSURL(WCCAdd)
- (NSURL *)customSchemeURL {
    NSURLComponents * components = [[NSURLComponents alloc] initWithURL:self resolvingAgainstBaseURL:YES];
    components.scheme = @"streaming";
    return [components URL];
}

- (NSURL *)originalSchemeURL {
    NSURLComponents * components = [[NSURLComponents alloc] initWithURL:self resolvingAgainstBaseURL:NO];
    components.scheme = @"http";
    return [components URL];
}

@end

@interface WCCVideoRequestTask()<NSURLSessionDataDelegate,NSURLConnectionDataDelegate>
@property (nonatomic, strong) NSURLSession * session;              //会话对象
@property (nonatomic, strong) NSURLSessionDataTask * task;         //任务
@property (nonatomic,assign) BOOL isCanceled;
@end

#define request_timetout 30

@implementation WCCVideoRequestTask

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    NSFileHandle *handle = [NSFileHandle fileHandleForWritingAtPath:[WCCFileManager cachedVideoFilePathWithURL:dataTask.originalRequest.URL]];
    [handle seekToEndOfFile];
    [handle writeData:data];
    self.cacheLength += data.length;
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (self.isCanceled) {
        NSLog(@"取消下载");
    }else{
        if (error) {
            NSLog(@"下载过程出现错误，在此处理错误逻辑");
        }else{
            
        }
    }
}

- (void)start
{
    NSMutableURLRequest *muRequest = [[NSMutableURLRequest alloc]initWithURL:[self.urlRequest originalSchemeURL]
                                                                 cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                             timeoutInterval:request_timetout];
    if (self.requestOffset > 0) {
        [muRequest addValue:[NSString stringWithFormat:@"bytes=%ld-%ld",self.requestOffset,self.fileLength-1] forHTTPHeaderField:@"Range"];
    }
    self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                                 delegate:self
                                            delegateQueue:[NSOperationQueue mainQueue]];
    self.task = [self.session dataTaskWithRequest:muRequest];
    [self.task resume];
}

/**
 取消请求
 */
- (void)cancel
{
    [self.task cancel];
    [self.session invalidateAndCancel];
    self.isCanceled = YES;
}
@end

