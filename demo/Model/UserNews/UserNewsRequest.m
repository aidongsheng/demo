//
//  UserNewsRequest.m
//  demo
//
//  Created by wcc on 2018/8/3.
//  Copyright © 2018年 wcc. All rights reserved.
//

#import "UserNewsRequest.h"
#import "UserNewsModel.h"

@implementation UserNewsRequest

- (NSString *)requestUrl
{
    return [UrlHelper userNews];
}
- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGET;
}
- (nullable id)requestArgument
{
    return @{};
}
- (YTKRequestSerializerType)requestSerializerType
{
    return YTKRequestSerializerTypeJSON;
}
- (YTKResponseSerializerType)responseSerializerType
{
    return YTKResponseSerializerTypeJSON;
}
///  Username and password used for HTTP authorization. Should be formed as @[@"Username", @"Password"].
- (nullable NSArray<NSString *> *)requestAuthorizationHeaderFieldArray
{
    return @[@"username",@"password"];
}

///  Additional HTTP request header field.
- (nullable NSDictionary<NSString *, NSString *> *)requestHeaderFieldValueDictionary
{
    return @{@"a":@"b"};
}
@end
