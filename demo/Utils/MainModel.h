//
//  MainModel.h
//  demo
//
//  Created by wcc on 2018/8/1.
//  Copyright © 2018年 wcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainModel : NSObject
@property (nonatomic, strong) NSString * strAppVersion;
@property (nonatomic, strong) NSString * strBuild;
@property (nonatomic, strong) NSString * strDeviceModel;
+ (MainModel *)shareObject;
@end
