//
//  ViewController.m
//  YJFoundationGather
//
//  Created by YJHou on 2017/5/17.
//  Copyright © 2017年 https://github.com/stackhou. All rights reserved.
//

#import "ViewController.h"
#import "NSArray+YJFoundation.h"
#import "NSString+YJFoundation.h"
#import "UIColor+YJFoundation.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *array = @[@"12", @"34", @"Case"];
    NSString *string = @"https://github.com/stackhou?id=300&name=北京";
    NSDictionary *dict = @{@"id":@600, @"name":@"中国北京"};
    NSString *jsonString = @"{\"ids\":12, \"name\":\"yj\"}";
    
    NSString *htmlString = @"<html><head><title>1233</title></head></html>";
    
    NSLog(@"-->%@", [@"1001" yj_positiveFormat]);
    
    self.view.backgroundColor = [UIColor yj_colorWithHexString:@"FF1493"];
    
    [htmlString logLevel:1 format:@"----%@---%ld", @"我是", 12];

    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
