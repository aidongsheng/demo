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
@property (nonatomic,assign) BOOL isPlaying;                    //  是否正在播放的标志
@property (nonatomic,strong) UISlider *sliderPlay;              //  播放器进度条
@property (nonatomic,strong) UIButton *buttonPlayControl;       //  播放、暂停控制按钮
@property (nonatomic,assign) WCCPlayerPlayStatus playStatus;    //  播放器当前的播放状态
@property (nonatomic,assign) float videoDuration;               //  视频时长
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
        [self addSubview:self.buttonPlayControl];
        [self addSubview:self.sliderPlay];
        [self addObservers];
    }
    return self;
}

- (void)addObservers {
    AVPlayerItem *playItem = self.player.currentItem;
    __weak __block UISlider *slider = _sliderPlay;
    [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 30.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        float current = CMTimeGetSeconds(time);
        float total = CMTimeGetSeconds([playItem duration]);
        float progress = current/total;
        NSLog(@"当前进度:%.1f",progress);
        [slider setValue:progress animated:YES];
    }];
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial context:nil];
    [self.playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial context:nil];
    [self.player addObserver:self forKeyPath:@"rate" options:NSKeyValueObservingOptionNew context:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playDidFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}
- (void)removeObservers {
    [self.player removeTimeObserver:self];
    [self.playerItem removeObserver:self forKeyPath:@"status"];
    [self.playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [self.player removeObserver:self forKeyPath:@"rate"];
}
- (UISlider *)sliderPlay
{
    if (_sliderPlay == nil) {
        _sliderPlay = [[UISlider alloc]init];
        _sliderPlay.continuous = NO;
        [_sliderPlay setThumbImage:[UIImage imageNamed:@"slider_thumb_icon"] forState:UIControlStateNormal];
        _sliderPlay.minimumValue = 0.f;
        _sliderPlay.maximumValue = 1.0f;
        [_sliderPlay setMinimumTrackTintColor:[UIColor redColor]];
        [_sliderPlay setMaximumTrackTintColor:[UIColor lightGrayColor]];
        [_sliderPlay addTarget:self action:@selector(seekControl:) forControlEvents:UIControlEventValueChanged];
    }
    return _sliderPlay;
}
- (UIButton *)buttonPlayControl
{
    if (_buttonPlayControl == nil) {
        _buttonPlayControl = [[UIButton alloc]init];
        [_buttonPlayControl addTarget:self action:@selector(playControl) forControlEvents:UIControlEventTouchUpInside];
        [_buttonPlayControl setImage:[UIImage imageNamed:@"play_icon"] forState:UIControlStateNormal];
    }
    return _buttonPlayControl;
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
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    [self performSelector:@selector(setupWithURL:) withObject:_urlVideoURL afterDelay:0.1];
}

- (void)playDidFinished:(NSNotification *)note
{
    NSLog(@"%@",note.userInfo);
    [self.player seekToTime:CMTimeMake(0, 1)];
    _isPlaying = NO;
    _playStatus = WCCPlayerPlayStatusStoped;
}
- (void)play
{
    _playStatus = WCCPlayerPlayStatusPlaying;
    [self.player play];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didStartPlayVideo)]) {
        [self.delegate didStartPlayVideo];
    }
}
- (void)pause{
    _playStatus = WCCPlayerPlayStatusPaused;
    [self.player setRate:0];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didPausePlayVideo)]) {
        [self.delegate didPausePlayVideo];
    }
}
- (void)stop
{
    _playStatus = WCCPlayerPlayStatusStoped;
    [self.player seekToTime:CMTimeMakeWithSeconds(0, self.playerItem.currentTime.timescale) completionHandler:^(BOOL finished) {
        NSLog(@"已停止播放");
        [self.player pause];
        if (self.delegate && [self.delegate respondsToSelector:@selector(didStopPlayVideo)]) {
            [self.delegate didStopPlayVideo];
        }
    }];
}
- (void)seekControl:(UISlider *)slider
{
    NSLog(@"%.1f",slider.value);
    [self.player seekToTime:CMTimeMakeWithSeconds(10, 1)];
}
- (void)playControl
{
    _isPlaying = !_isPlaying;
    if (_isPlaying == YES) {
        [self pause];
        _playStatus = WCCPlayerPlayStatusPaused;
    }else{
        [self play];
        _playStatus = WCCPlayerPlayStatusPlaying;
    }
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([object isEqual:self.playerItem] && [keyPath isEqualToString:@"loadedTimeRanges"]) {
        NSTimeInterval timeInterval = [self availableDuration];// 计算缓冲进度
        CGFloat totalDuration = CMTimeGetSeconds([self.playerItem duration]);
        NSLog(@"Time Interval:%f,duration:%.1f",timeInterval,totalDuration);
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
                [self.player play];
                break;
            case AVPlayerItemStatusUnknown:
                NSLog(@"视频资源出现未知错误");
                break;
            default:
                break;
        }
    }
    
    if ([object isEqual:self.player] && [keyPath isEqualToString:@"rate"]) {
        if (self.player.rate == 0) {
            [_buttonPlayControl setImage:[UIImage imageNamed:@"play_icon"] forState:UIControlStateNormal];
        }else{
            [_buttonPlayControl setImage:[UIImage imageNamed:@"pause_icon"] forState:UIControlStateNormal];
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
    if (self.delegate && [self.delegate respondsToSelector:@selector(didTapedVideoViewWithWCCPlayerPlayStatus:)]) {
        [self.delegate didTapedVideoViewWithWCCPlayerPlayStatus:_playStatus];
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


- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.buttonPlayControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(0);
        make.width.height.equalTo(@40);
    }];
    [self.sliderPlay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.equalTo(self.buttonPlayControl.mas_top).offset(-10);
        make.height.equalTo(@10);
    }];
}
- (void)dealloc
{
    [self removeObservers];
}
@end

