//
//  SecondViewController.m
//  demo
//
//  Created by wcc on 2018/4/11.
//  Copyright © 2018年 wcc. All rights reserved.
//

#import "SecondViewController.h"
#import "VideoPlayerView.h"

@interface SecondViewController ()<VideoPlayerViewDelegate>
@property (nonatomic,strong) AVPlayerItem *playerItem;
@property (nonatomic,strong) AVPlayer *player;
@property (nonatomic,strong) VideoPlayerView *videoView;
@property (nonatomic,assign) BOOL isTaped;
@end

#define url_test_video   @"http://resbj.swochina.com/resource/ad/411521524218.mp4"
#define url_my_testVideo @"http://192.168.101.94:8000/download/zhejiang.mp4"

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    
    _videoView = [[VideoPlayerView alloc]initWithVideoURL:[NSURL URLWithString:url_test_video] title:nil];
    _videoView.delegate = self;
    _videoView.frame = self.view.bounds;
    [self.view addSubview:_videoView];
    [_videoView play];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)didStartPlayVideo
{
    NSLog(@"开始播放");
    
}
- (void)didPausePlayVideo
{
    NSLog(@"暂停播放");
}
- (void)didStopPlayVideo
{
    NSLog(@"停止播放");
}
- (void)didTapedVideoViewWithWCCPlayerPlayStatus:(WCCPlayerPlayStatus)status
{
    if (status == WCCPlayerPlayStatusStoped) {
        [_videoView play];
    }else if (status == WCCPlayerPlayStatusPaused) {
        [_videoView play];
    }else if (status == WCCPlayerPlayStatusPlaying) {
        [_videoView pause];
    }
}
@end
