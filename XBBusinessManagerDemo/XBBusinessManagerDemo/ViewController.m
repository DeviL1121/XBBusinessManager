//
//  ViewController.m
//  XBBusinessManagerDemo
//
//  Created by Scarecrow on 15/9/24.
//  Copyright (c) 2015年 XB. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "XBBusinessManager.h"
@interface ViewController ()<XBBusinessManagerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadHomeTag];
}

- (void)loadHomeTag
{
    NSDictionary *params = @{
                             @"xxx":@"ooo",
                             };
    [XBBusinessManager requestBusinessAction:XBHomeTagList byRequestType:XBHttpRequestTypeGet andParameters:params andCallbackDelegate:self andDataType:nil andIdentifier:@"home"];
}

#pragma - mark XBBusinessDelegate
/**< 返回业务数据信息成功  */
- (void)XBBusinessDataFetchedSuccess:(NSArray *)data forAction:(NSString *)action andIdentifier:(NSString *)identifier
{
    NSLog(@"data===%@",data);
    NSLog(@"identifier===%@",identifier);
}

/**< 返回业务数据信息失败  */
- (void)XBBusinessDataFetchedError:(NSError *)error forAction:(NSString *)action andIdentifier:(NSString *)identifier
{
    NSLog(@"error===%@",error);
    NSLog(@"identifier===%@",identifier);

}

/**< 无网络  */
- (void)XBBusinessNetworkNotReachable
{
    NSLog(@"网络断开");
}
/**< 使用手机流量  */

- (void)XBBusinessNetworkChangedToWWAN
{
    NSLog(@"使用手机流量");
    
}


- (void)test1
{
    NSDictionary *params = @{
                             @"xxx":@"ooo"
                             };
    [[AFHTTPRequestOperationManager manager] POST:@"http://www.baidu.com" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //do someing
        //eg : [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //do someing
    }];
}

@end
