//
//  WCCFileManager.m
//  demo
//
//  Created by wcc on 2018/4/19.
//  Copyright © 2018年 wcc. All rights reserved.
//

#import "WCCFileManager.h"
#import "WCCVideoRequestTask.h"

#import <CommonCrypto/CommonDigest.h>

@implementation WCCFileManager

+ (BOOL)checkCachedVideoFileExsitsWithURL:(NSURL *)videoURL
{
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:@"video"];
    NSString *strVideoURL = [NSString stringWithFormat:@"%@",videoURL];
    NSString *strMD5VideoURL = [strVideoURL md5String];
    path = [path stringByAppendingPathComponent:strMD5VideoURL];
    path = [path stringByAppendingPathExtension:@"mp4"];
    if ([[NSFileManager defaultManager]fileExistsAtPath:path]) {
        return YES;
    }else{
        return NO;
    }
    
}

+ (NSString *)cachedVideoFilePathWithURL:(NSURL *)videoURL
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:@"video"];
    NSString *strFileNameMD5 = [[NSString stringWithFormat:@"%@",videoURL] MD5String];
    path = [path stringByAppendingPathComponent:strFileNameMD5];
    path = [path stringByAppendingPathExtension:@"mp4"];
    
    return path;
}

/**
 创建temp目录

 @return 目录
 */
+ (NSString *)tempVideoFilePath
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:@"temp"];
    return path;
}

/**
 创建temp目录下的临时文件

 @param videoURL 视频链接URL
 @return 临时文件目录地址
 */
+ (NSString *)tempVideoFilePathWithURL:(NSURL *)videoURL
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:@"temp"];
    NSString *strFileNameMD5 = [[NSString stringWithFormat:@"%@",videoURL] MD5String];
    path = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4",strFileNameMD5]];
    return path;
}

+ (BOOL)createTempFileWithVideoURL:(NSURL *)videoURL
{
    NSURL *originalURL = [videoURL originalSchemeURL];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *tempFolder = [WCCFileManager tempVideoFilePath];
    NSString *tempFile = [WCCFileManager tempVideoFilePathWithURL:originalURL];
    
    if ([fileManager fileExistsAtPath:tempFile]) {
        NSError *error;
        BOOL success = [fileManager removeItemAtPath:tempFile error:&error];
        if (error || !success) {
            NSLog(@"清除临时文件 %@ 失败",tempFile);
        }else{
            NSLog(@"清除临时文件 %@ 成功",tempFile);
        }
    }
    __block BOOL createFile,createFolder;
    [[GCDManager shareInstance] asyncExecuteOnSerialQueue:^{
        createFolder = [fileManager createDirectoryAtPath:tempFolder withIntermediateDirectories:YES attributes:nil error:nil];
    }];
    [[GCDManager shareInstance] asyncExecuteOnSerialQueue:^{
        createFile = [fileManager createFileAtPath:tempFile contents:nil attributes:nil];
    }];
    return createFile;
}

+ (void)cacheVideoToDiskWithVideoURL:(NSURL *)videoURL
{
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:@"video"];
    if (![fileMgr fileExistsAtPath:path]) {
        NSError *error;
        BOOL success = [fileMgr createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (error && success) {
            NSLog(@"创建视频缓存文件夹失败");
        }else{
            NSLog(@"创建视频缓存文件夹成功");
        }
    }
}
+ (void)clearTempFolderFiles
{
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSString *tempPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    tempPath = [tempPath stringByAppendingPathComponent:@"temp"];
    if ([fileMgr fileExistsAtPath:@"*.mp4"]) {
        
    }
}

@end

@implementation NSString(add)
+ (NSString *)getMD5String:(NSString *)key
{
    NSString *filename = nil;
    if ( [key length] > 0 ) {
        const char *str = [key UTF8String];
        unsigned char r[CC_MD5_DIGEST_LENGTH];
        CC_MD5(str, (CC_LONG)strlen(str), r);
        filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                    r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    }
    return filename;
}

- (NSString *)MD5String
{
    NSString *filename = nil;
    if ( [self length] > 0 ) {
        const char *str = [self UTF8String];
        unsigned char r[CC_MD5_DIGEST_LENGTH];
        CC_MD5(str, (CC_LONG)strlen(str), r);
        filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                    r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    }
    return filename;
}

@end
