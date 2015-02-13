//
//  Tracker.h
//  BlockTest
//
//  Created by Lee on 12/23/14.
//  Copyright (c) 2014 My Company. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CallBack)(id obj, NSError *error);
typedef void (^NetworkHandle)(id respondData, NSError *error, int status);
typedef void(^LeeBlock)(NSArray *array);

@interface Tracker : NSObject{
    NSDictionary *_blockDic;
}

@property (copy, nonatomic) CallBack callBack;
@property (copy, nonatomic) NetworkHandle networkHandle;
@property (copy, nonatomic) LeeBlock leeBlock;

+ (instancetype)sharedInstance;

- (void)callBack:(void(^)(id obj, NSError *error))parameter;
//网络请求，respondData为请求返回数据结构体，error为错误信息，status为请求网路状态码
- (instancetype)sendNetworkRequest:(NSString *)url complete:(void (^)(NSDictionary *respondData, NSError * error, int status))complete;
- (void)blockTest;

@end
