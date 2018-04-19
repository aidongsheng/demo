//
//  WCCFileManager.m
//  demo
//
//  Created by wcc on 2018/4/19.
//  Copyright © 2018年 wcc. All rights reserved.
//

#import "WCCFileManager.h"
#import <CommonCrypto/CommonDigest.h>

@implementation WCCFileManager

+ (BOOL)checkVideoFileExsitsWithURL:(NSURL *)videoURL
{
    NSString *strVideoURL = [NSString stringWithFormat:@"%@",videoURL];
    NSString *strMD5VideoURL = [strVideoURL md5String];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, NO) lastObject];
    path = [path stringByAppendingPathComponent:@"Video"];
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
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, NO) lastObject];
    path = [path stringByAppendingPathComponent:@"Video"];
    NSString *strFileNameMD5 = [[NSString stringWithFormat:@"%@",videoURL] MD5String];
    path = [path stringByAppendingPathComponent:strFileNameMD5];
    path = [path stringByAppendingPathExtension:@"mp4"];
    return path;
}
+ (void)cacheVideoToDiskWithVideoURL:(NSURL *)videoURL
{
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, NO) lastObject];
    path = [path stringByAppendingPathComponent:@"Video"];
    if (![fileMgr fileExistsAtPath:path]) {
        NSError *error;
        [fileMgr createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"创建视频缓存文件夹失败");
        }else{
            NSLog(@"创建视频缓存文件夹成功");
        }
        
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