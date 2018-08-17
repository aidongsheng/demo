//
//  BaseTableViewCell.m
//  demo
//
//  Created by wcc on 2018/8/3.
//  Copyright © 2018年 wcc. All rights reserved.
//

#import "BaseTableViewCell.h"

static BaseTableViewCell *instance;

@implementation BaseTableViewCell
//
//+ (BaseTableViewCell *)shareCell
//{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        if (!instance) {
//            instance = [[BaseTableViewCell alloc]init];
//        }
//    });
//    return instance;
//}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"aaffee"];
    }
    return self;
}

+ (id)factoryCellWithTableView:(UITableView *)tableView
{
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[BaseTableViewCell identifier]];
    if (!cell) {
        cell = [[BaseTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[BaseTableViewCell identifier]];
    }
    return cell;
}

+ (NSString *)identifier
{
    return NSStringFromClass([self class]);
}

@end
