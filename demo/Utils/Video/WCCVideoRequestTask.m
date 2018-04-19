//
//  WCCVideoRequestTask.m
//  demo
//
//  Created by wcc on 2018/4/19.
//  Copyright © 2018年 wcc. All rights reserved.
//



#import "WCCVideoRequestTask.h"
#import "WCCFileManager.h"
#import "WCCFileHandle.h"

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

- (instancetype)initWithURL:(NSURL *)videoURL
{
    if (self = [super init]) {
        [WCCFileManager createTempFileWithVideoURL:videoURL];
    }
    return self;
}
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    if (self.isCanceled) return;
    NSLog(@"response: %@",response);
    completionHandler(NSURLSessionResponseAllow);
    NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *)response;
    NSString * contentRange = [[httpResponse allHeaderFields] objectForKey:@"Content-Range"];
    NSString * fileLength = [[contentRange componentsSeparatedByString:@"/"] lastObject];
    self.fileLength = fileLength.integerValue > 0 ? fileLength.integerValue : response.expectedContentLength;
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    NSString *tempFilePath = [WCCFileManager tempVideoFilePathWithURL:dataTask.originalRequest.URL];
    NSFileHandle *handle = [NSFileHandle fileHandleForWritingAtPath:tempFilePath];
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
            NSLog(@"下载过程出现错误，在此处理错误逻辑,localizedDescription:%@,reason:%@",[error localizedDescription],[error localizedFailureReason]);
        }else{
            NSLog(@"下载完成");
            [WCCFileHandle cacheVideoFile:task.originalRequest.URL];
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
//- (void)setUrlRequest:(NSURL *)urlRequest
//{
//    _urlRequest = urlRequest;
//    [WCCFileManager createTempFileWithVideoURL:self.urlRequest.absoluteURL];
//
//}
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

