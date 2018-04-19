//
//  WCCResourceLoader.m
//  demo
//
//  Created by wcc on 2018/4/19.
//  Copyright © 2018年 wcc. All rights reserved.
//

#import "WCCResourceLoader.h"
#import "WCCVideoRequestTask.h"

@interface WCCResourceLoader()
@property (nonatomic,copy) NSMutableArray *arrRequest;
@property (nonatomic,strong) WCCVideoRequestTask *requestTask;
@end

@implementation WCCResourceLoader

+ (WCCResourceLoader *)shareInstance
{
    static WCCResourceLoader *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[WCCResourceLoader alloc]init];
    });
    return instance;
}
- (instancetype)init
{
    if (self = [super init]) {
        _arrRequest = [[NSMutableArray alloc]init];
    }
    return self;
}

/**
 当应用程序需要帮助加载资源时调用。
 
 @param resourceLoader 用于加载请求的AVAssetResourceLoader实例。
 @param loadingRequest AVAssetResourceLoadingRequest的实例，它提供关于所请求资源的信息。
 @return 如果委托可以加载AVAssetResourceLoadingRequest指定的资源，返回YES；否则，返回NO。
 
 @discussion    当应用程序需要帮助来加载资源时，委托会收到此消息。例如，该方法被调用来加载通过自定义URL方案指定的解密密钥。
 如果结果是肯定的，那么资源加载器就会期望调用，或者随后或立即的调用，或者-[avastresourceloadingrequest finishLoading]
 或-[AVAssetResourceLoadingRequest finishLoadingWithError:]。
 如果您打算在处理此消息返回后完成加载，那么您必须在加载完成后保留AVAssetResourceLoadingRequest的实例。
 如果结果是NO，则资源加载器将资源的加载视为失败。
 注意，如果委托的-resourceLoader: shouldwaitforloadingodresource:返回YES，而不立即完成加载请求，则在之前的请求完成之前，可能会再次调用另一个加载请求;
 因此，在这种情况下，委托应该准备好管理多个加载请求。
 
 如果一个AVURLAsset被添加到一个AVContentKeySession对象中，并且一个委托被设置在它的AVAssetResourceLoader上，
 那么该委托的resourceLoader: shouldwaitforloadingoentrdresource:方法必须指定哪些自定义URL请求应该作为内容
 键来处理。这是通过返回YES和通过AVStreamingKeyDeliveryPersistentContentKeyType或
 AVStreamingKeyDeliveryContentKeyType来完成的，然后调用-[AVAssetResourceLoadingRequest finishLoading]。
 
 */
- (BOOL)resourceLoader:(AVAssetResourceLoader *)resourceLoader shouldWaitForLoadingOfRequestedResource:(AVAssetResourceLoadingRequest *)loadingRequest
{
    [self addLoadingRequest:loadingRequest];
    return YES;
}

/**
 通知委托，先前的加载请求已被取消。
 
 @param resourceLoader 用于加载请求的AVAssetResourceLoader实例。
 @param loadingRequest 先前的加载请求
 @discussion
 当来自资源的数据不再需要，或者当加载请求被来自同一资源的新请求取代时，先前发布的加载请求可以被取消。
 例如，如果要完成一个查找（seek）操作，就需要加载不同于先前请求的范围的字节范围，在委托仍在处理之前请求可能会被取消。
 
 */
- (void)resourceLoader:(AVAssetResourceLoader *)resourceLoader didCancelLoadingRequest:(AVAssetResourceLoadingRequest *)loadingRequest
{
    [self.arrRequest removeObject:loadingRequest];
}

- (void)addLoadingRequest:(AVAssetResourceLoadingRequest *)loadingRequest
{
    [self.arrRequest addObject:loadingRequest];
    @synchronized(self){
        if (self.requestTask) {
            //  如果请求任务已存在，执行此处代码
        }else{
            //  否则，创建新的请求任务，开启请求
            
        }
    }
}

- (void)newRequestTaskWithLoadingRequest:(AVAssetResourceLoadingRequest *)loadingRequest cache:(BOOL)cache
{
    NSUInteger fileLength = 0;
    if (self.requestTask) {
        fileLength = self.requestTask.fileLength;
        [self.requestTask cancel];
    }
    self.requestTask = [[WCCVideoRequestTask alloc]init];
    self.requestTask.urlRequest = loadingRequest.request.URL;
    self.requestTask.requestOffset = loadingRequest.dataRequest.requestedOffset;
    self.requestTask.cache = cache;
    if (fileLength > 0) {
        self.requestTask.fileLength = fileLength;
    }
    [self.requestTask start];
}

@end
