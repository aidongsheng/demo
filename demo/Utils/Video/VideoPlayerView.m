//
//  VideoPlayerView.m
//  wochacha
//
//  Created by wcc on 2018/4/16.
//  Copyright © 2018年 wochacha. All rights reserved.
//

#import "VideoPlayerView.h"
#import "WCCResourceLoader.h"
#import "WCCFileManager.h"
#import "WCCVideoRequestTask.h"

@interface VideoPlayerView()
@property (nonatomic,strong) AVPlayerItem *playerItem;
@property (nonatomic,copy)   NSString *videoTitle;
@property (nonatomic,assign) BOOL isNeedToPlay;
@end

@implementation VideoPlayerView

+ (Class)layerClass {
    return [AVPlayerLayer class];
}

- (AVPlayer *)player {
    return [(AVPlayerLayer *)[self layer] player];
}

- (void)setPlayer:(AVPlayer *)player {
    [(AVPlayerLayer *)[self layer] setPlayer:player];
}


- (instancetype)initWithVideoURL:(NSURL *)videoURL title:(NSString *)videoTitle
{
    if (self = [super init]) {
        [self setupWithURL:videoURL];
    }
    return self;
}

- (void)setupWithURL:(NSURL *)videoURL
{
    [WCCFileManager clearTempFolderFiles];
    _urlVideoURL = videoURL;
    if ([WCCFileManager checkCachedVideoFileExsitsWithURL:videoURL]) {
        NSURL *fileURL = [NSURL fileURLWithPath:[WCCFileManager cachedVideoFilePathWithURL:videoURL]];
        NSString *fileString = [NSString stringWithFormat:@"%@",fileURL];
        fileURL = [NSURL URLWithString:fileString];
        self.playerItem = [AVPlayerItem playerItemWithURL:fileURL];
        NSLog(@"%@",fileString);
    }else{
        AVURLAsset *urlAsset = [AVURLAsset assetWithURL:[videoURL customSchemeURL]];
        [urlAsset.resourceLoader setDelegate:[WCCResourceLoader shareInstance] queue:dispatch_queue_create("com.wochacha.resourceLoader", NULL)];
        self.playerItem = [AVPlayerItem playerItemWithAsset:urlAsset];
    }
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial context:nil];
    [self.playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial context:nil];
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    [self performSelector:@selector(setupWithURL:) withObject:_urlVideoURL afterDelay:1];
}
- (void)play
{
    [self.player play];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didStartPlayVideo)]) {
        [self.delegate didStartPlayVideo];
    }
}
- (void)pause{
    [self.player setRate:0];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didPausePlayVideo)]) {
        [self.delegate didPausePlayVideo];
    }
}
- (void)stop
{
    [self.player seekToTime:CMTimeMakeWithSeconds(0, self.playerItem.currentTime.timescale) completionHandler:^(BOOL finished) {
        NSLog(@"已停止播放");
        [self.player pause];
        if (self.delegate && [self.delegate respondsToSelector:@selector(didStopPlayVideo)]) {
            [self.delegate didStopPlayVideo];
        }
    }];
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([object isEqual:self.playerItem] && [keyPath isEqualToString:@"loadedTimeRanges"]) {
        NSTimeInterval timeInterval = [self availableDuration];// 计算缓冲进度
        NSLog(@"Time Interval:%f",timeInterval);
        CMTime duration = self.playerItem.duration;
        CGFloat totalDuration = CMTimeGetSeconds(duration);
        
    }
    if ([object isEqual:self.playerItem] && [keyPath isEqualToString:@"status"]) {
        NSLog(@"status:%li",self.playerItem.status);
        AVPlayerItemStatus status = [change[NSKeyValueChangeNewKey]intValue];
        switch (status) {
            case AVPlayerItemStatusFailed:
                NSLog(@"AVPlayItem 对象有误,请检查 AVPlayItem 配置是否有误");
                if (self.delegate && [self.delegate respondsToSelector:@selector(playVideoErrorWithInfomation:)]) {
                    [self.delegate playVideoErrorWithInfomation:@"AVPlayItem 对象有误,请检查 AVPlayItem 配置是否有误"];
                }
                break;
            case AVPlayerItemStatusReadyToPlay:
                NSLog(@"已经准备好播放");
                [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(setupWithURL:) object:_urlVideoURL];
                if (@available(iOS 10.0, *)) {
                    [self.player playImmediatelyAtRate:1];
                } else {
                    [self play];
                }
                break;
            case AVPlayerItemStatusUnknown:
                NSLog(@"视频资源出现未知错误");
                break;
            default:
                break;
        }
    }
}

- (NSTimeInterval)availableDuration {
    NSArray *loadedTimeRanges = [[self.player currentItem] loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds;// 计算缓冲总进度
    
    return result;
}

- (void)jumpToTime:(NSTimeInterval)time withCompletionBlock:(void (^)(BOOL))completionBlock
{
    CMTime destTime = CMTimeMakeWithSeconds(time, self.playerItem.currentTime.timescale);
    [self.player seekToTime:destTime completionHandler:completionBlock];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didTapedVideoView)]) {
        [self.delegate didTapedVideoView];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    UITouch *touch = [touches allObjects].firstObject;
    CGPoint curPoint = [touch locationInView:self.superview];
    CGPoint prePoint = [touch previousLocationInView:self.superview];
    CGFloat offsetX = curPoint.x - prePoint.x;
    CGFloat offsetY = curPoint.y - prePoint.y;
    self.transform = CGAffineTransformTranslate(self.transform, offsetX, offsetY);
}

@end

