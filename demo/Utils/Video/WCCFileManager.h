//
//  WCCFileManager.h
//  demo
//
//  Created by wcc on 2018/4/19.
//  Copyright © 2018年 wcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCCFileManager : NSObject
/**
 判断指定 URL 对应的视频文件的本地缓存是否存在

 @param videoURL 传入的视频 URL
 @return 视频文件的缓存在本地是否存在
 */
+ (BOOL)checkCachedVideoFileExsitsWithURL:(NSURL *)videoURL;
+ (NSString *)cachedVideoFilePathWithURL:(NSURL *)videoURL;
+ (NSString *)tempVideoFilePath;
+ (NSString *)tempVideoFilePathWithURL:(NSURL *)videoURL;
+ (void)cacheVideoToDiskWithVideoURL:(NSURL *)videoURL;
+ (BOOL)createTempFileWithVideoURL:(NSURL *)videoURL;
+ (void)clearTempFolderFiles;
@end

@interface NSString(add)
+ (NSString *)getMD5String:(NSString *)key;

- (NSString *)MD5String;
@end
