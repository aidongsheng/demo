//
//  WCCFileHandle.m
//  demo
//
//  Created by wcc on 2018/4/19.
//  Copyright © 2018年 wcc. All rights reserved.
//

#import "WCCFileHandle.h"
#import "WCCFileManager.h"

@implementation WCCFileHandle
+ (WCCFileHandle *)shareInstance
{
    static WCCFileHandle *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[WCCFileHandle alloc]init];
    });
    return instance;
}
+ (BOOL)createTempFileWithVideoURL:(NSURL *)videoURL {
    NSFileManager * manager = [NSFileManager defaultManager];
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:@"temp"];
    NSString *strVideoURLMD5 = [[NSString stringWithFormat:@"%@",videoURL] MD5String];
    path = [path stringByAppendingPathComponent:strVideoURLMD5];
    path = [path stringByAppendingPathExtension:@"mp4"];
    if ([manager fileExistsAtPath:path]) {
        [manager removeItemAtPath:path error:nil];
    }
    return [manager createFileAtPath:path contents:nil attributes:nil];
}
+ (void)cacheVideoFile:(NSURL *)videoURL
{
    NSString *folderPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    folderPath = [folderPath stringByAppendingPathComponent:@"video"];
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    if (![fileMgr fileExistsAtPath:folderPath]) {
        NSError *error;
        [fileMgr createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"创建cache文件夹失败,error's localizedDescription:%@ , error's localizedFailureReason:%@",[error localizedDescription],[error localizedFailureReason]);
        }else{
            NSLog(@"创建cache文件夹成功");
        }
    }
    NSError *error;
    NSString *tempPath = [WCCFileManager tempVideoFilePathWithURL:videoURL];
    NSString *cachePath = [WCCFileManager cachedVideoFilePathWithURL:videoURL];
    BOOL success = [[NSFileManager defaultManager] copyItemAtPath:tempPath toPath:cachePath error:&error];
    if (error || !success) {
        NSLog(@"从 %@ 文件夹移动 %@ 文件至 %@ 文件夹失败",tempPath,[WCCFileHandle fileNameWithVideoURL:videoURL],cachePath);
    }else{
        NSLog(@"从 %@ 文件夹移动文件 %@ 至 %@ 文件夹成功",tempPath,[WCCFileHandle fileNameWithVideoURL:videoURL],cachePath);
    }
    [WCCFileHandle shareInstance].isFileCached = YES;
}

+ (NSString *)fileNameWithVideoURL:(NSURL *)videoURL
{
    NSString *fileName = [NSString stringWithFormat:@"%@",videoURL];
    fileName = [fileName MD5String];
    fileName = [fileName stringByAppendingString:@".mp4"];
    return fileName;
}

+ (NSData *)readTempFileDataWithOffset:(NSUInteger)offset length:(NSUInteger)length videoURL:(NSURL *)videoURL{
    NSFileHandle * handle = [NSFileHandle fileHandleForReadingAtPath:[WCCFileManager tempVideoFilePathWithURL:videoURL]];
    [handle seekToFileOffset:offset];
    return [handle readDataOfLength:length];
}


@end
