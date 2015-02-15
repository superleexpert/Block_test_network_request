//
//  ViewController.m
//  BlockNetwork
//
//  Created by Lee on 2/3/15.
//  Copyright (c) 2015 My Company. All rights reserved.
//

#import "ViewController.h"
#import "Tracker.h"

typedef NS_ENUM(NSInteger, BlockTest) {
    test1 = -1,
    test2 = 0,
    test3 = 1,
    test4 = 2,
};

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self aBlockTest];
    [self aBlockCallBack];
    [self aBlockNetworkInstance];
    [self aMyBlock];
    [self aEnumTest:1];
    [self testString];
    [self orderTest];

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

- (void)aEnumTest:(NSInteger)test
{
    switch (test) {
        case test1:
            NSLog(@"test :%ld", test1);
            break;
        case test2:
            NSLog(@"test :%ld", test2);
            break;
        case test3:
            NSLog(@"test :%ld", test3);
            break;
        case test4:
            NSLog(@"test :%ld", test4);
            break;
        default:
            break;
    }
}

- (void)testString
{
    NSString *testStr = @"测试字符串类型的retain count长度";
    NSLog(@"Retain count :%ld", CFGetRetainCount((__bridge CFTypeRef)testStr));//值是1152921504606846975，使用直接赋值的方法可以看到其Retain count是一个64位下的最大值，相当于分配在全局变量区，启动时直接初始化
    NSString *test1 = [NSString stringWithString:testStr];
    NSString *test2 = [NSString stringWithFormat:@"%@", testStr];
    NSString *test3 = testStr;
    testStr = @"改变字符串";
    NSLog(@"test1 :%@,\n test2 :%@,\n test3 :%@", test1, test2, test3);
}

- (void)orderTest
{
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"1", @"6", @"2", @"5", @"4", @"3", @"4", @"2", nil];
    [self sort:array];
}

- (void)sort:(NSMutableArray *)arr
{
    for (int i = 1; i < arr.count; i ++) {//首先遍历数组，从第二个元素开始选取来插入排序
        NSInteger temp = [arr[i] integerValue];
        for (int j = i - 1; j >= 0 && temp < [arr[j] integerValue]; j --) {//插入比较大小，从遍历对象的前一个元素开始比较；每次比较后j--继续比较前面的元素
            arr[j + 1] = arr[j];//被遍历元素被赋值为前一个大的元素，
            arr[j] = [NSNumber numberWithInteger:temp];//先前移动一个元素位置
        }
    }
    NSLog(@"插入排序后：%@",arr);  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
