//
//  BaseTableViewCell.h
//  demo
//
//  Created by wcc on 2018/8/3.
//  Copyright © 2018年 wcc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell
@property (nonatomic, strong) id model;


+ (id)factoryCellWithTableView:(UITableView *)tableView;

+ (NSString *)identifier;

@end
