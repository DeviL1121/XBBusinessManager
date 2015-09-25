//
//  ViewController.m
//  XBBusinessManagerDemo
//
//  Created by Scarecrow on 15/9/24.
//  Copyright (c) 2015年 XB. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)test2
{
    
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
