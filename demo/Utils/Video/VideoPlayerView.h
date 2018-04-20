//
//  VideoPlayerView.h
//  wochacha
//
//  Created by wcc on 2018/4/16.
//  Copyright © 2018年 wochacha. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, WCCPlayerPlayStatus) {
    WCCPlayerPlayStatusPlaying,
    WCCPlayerPlayStatusPaused,
    WCCPlayerPlayStatusStoped,
};

@protocol VideoPlayerViewDelegate <NSObject>
@optional
/**
 结束播放代理方法
 */
- (void)didStopPlayVideo;

/**
 开始播放代理方法
 */
- (void)didStartPlayVideo;

/**
 暂停播放代理方法
 */
- (void)didPausePlayVideo;

/**
 视频画面被点击代理方法
 */
- (void)didTapedVideoViewWithWCCPlayerPlayStatus:(WCCPlayerPlayStatus)status;

- (void)playVideoErrorWithInfomation:(NSString *)errorInfo;
@end

@interface VideoPlayerView : UIView
@property (nonatomic,weak) id<VideoPlayerViewDelegate>delegate;
/**
 播放器
 */
@property (nonatomic ,strong) AVPlayer *player;

/**
 视频链接
 */
@property (nonatomic,copy) NSURL *urlVideoURL;

- (instancetype)initWithVideoURL:(NSURL *)videoURL title:(NSString *)videoTitle;

/**
 播放
 */
- (void)play;

/**
 暂停
 */
- (void)pause;

/**
 结束播放
 */
- (void)stop;

/**
 跳转至某一时间点

 @param time 时间点
 @param completionBlock 跳转完成后续动作
 */
- (void)jumpToTime:(NSTimeInterval)time withCompletionBlock:(void(^)(BOOL finished))completionBlock;
@end


