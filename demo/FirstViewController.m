//
//  FirstViewController.m
//  demo
//
//  Created by wcc on 2018/4/11.
//  Copyright © 2018年 wcc. All rights reserved.
//

#import "FirstViewController.h"
#import "CAShapeLayer+WCCAdd.h"
#import "MainModel.h"

@interface FirstViewController ()<POPAnimationDelegate>
@property (nonatomic,strong) CAShapeLayer *pie;
@end
BOOL flag;



@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DLog(@"app version %@ %@",[MainModel shareObject].strAppVersion,[MainModel shareObject].strDeviceModel);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseTableViewCell *cell = [BaseTableViewCell factoryCellWithTableView:tableView];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 30;
}
- (void)configCell:(id)cell atIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *myCell = cell;
    myCell.textLabel.text = @"here is text label.";
    myCell.detailTextLabel.text = @"here is detail text label.";
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
    }
}
@end
