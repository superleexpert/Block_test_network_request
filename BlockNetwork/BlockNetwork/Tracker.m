//
//  Tracker.m
//  BlockTest
//
//  Created by Lee on 12/23/14.
//  Copyright (c) 2014 My Company. All rights reserved.
//

#import "Tracker.h"
#import "AFNetWorking.h"

@implementation Tracker

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static id sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Tracker alloc] init];
    });
    return sharedInstance;
}

- (void)callBack:(void(^)(id obj, NSError *error))parameter
{
    _callBack = parameter;
    
    _blockDic = @{@"1":@"11", @"2":@"22", @"3":@"33"};
    
    if (!_blockDic) {
        NSError *err = [[NSError alloc] init];
        _callBack(nil, err);
        return;
    }
    
    _callBack(_blockDic, nil);
}

- (instancetype)sendNetworkRequest:(NSString *)url complete:(void (^)(NSDictionary *respondData, NSError * error, int status))complete
{
    _networkHandle = complete;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript" , @"text/plain" , @"text/html", nil];
    [manager POST:url
       parameters:@{@"loginName":@"yourLoginName",
                    @"loginPassword":@"yourLoginPassword"}
          success:^(AFHTTPRequestOperation *operation, id responseObject){
              NSLog(@"Network request success: %@", responseObject);
              __block int status = [responseObject[@"status"] intValue];
              if (_networkHandle) {
                  _networkHandle(responseObject,nil, status);
              }
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error){
              NSLog(@"Network request failed: %@", error.description);
              if (_networkHandle) {
                  _networkHandle(nil,error,0);
              }
          }];
    
    return self;
}

- (void)blockTest
{
    NSArray *array = @[@"Lee01", @"Lee02", @"Lee03"];
    _leeBlock(array);
}

@end
