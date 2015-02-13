//
//  ViewController.m
//  BlockNetwork
//
//  Created by Lee on 2/3/15.
//  Copyright (c) 2015 My Company. All rights reserved.
//

#import "ViewController.h"
#import "Tracker.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self aBlockTest];
    [self aBlockCallBack];
    [self aBlockNetworkInstance];
    [self aMyBlock];
}

- (void)aBlockTest
{
    // Basic block test, return int value.
    int a = 7;
    int (^fuckBlock)(int) = ^(int num) {
        return num * a;
    };
    NSLog(@"fuckBlock test: %d", fuckBlock(5));
}

- (void)aBlockCallBack
{
    // Replace delegate or method by value.
    Tracker *tracker = [[Tracker alloc] init];
    [tracker callBack:^(id obj, NSError *error){
        NSLog(@"Tracker block data: %@ or error %@", obj, error);
    }];
}

- (void)aBlockNetworkInstance
{
    [[Tracker sharedInstance] sendNetworkRequest:@"http://www.networkBlock.com" complete:^(NSDictionary *respondData, NSError * error, int status){
        NSLog(@"Do something for your network request success or failed!");
    }];
}

- (void)aMyBlock
{
    Tracker *tracker = [[Tracker alloc] init];
    tracker.leeBlock = ^(NSArray *array){
        NSLog(@"TODU %@", array);
    };
    [tracker blockTest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
