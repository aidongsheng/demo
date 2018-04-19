//
//  WCCFileHandle.h
//  demo
//
//  Created by wcc on 2018/4/19.
//  Copyright © 2018年 wcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCCFileHandle : NSObject
+ (BOOL)createTempFileWithVideoURL:(NSURL *)videoURL;
+ (void)cacheVideoFile:(NSURL *)videoURL;
+ (NSData *)readTempFileDataWithOffset:(NSUInteger)offset length:(NSUInteger)length videoURL:(NSURL *)videoURL;
@end
