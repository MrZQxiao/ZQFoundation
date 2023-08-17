//
//  NSObject+MSSyncToMainThread.h
//  MIS
//
//  Created by SaraWu on 2018/6/26.
//  Copyright © 2018 58. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ZQSyncToMainThread)

/**
 主线程同步执行

 @param methodName 执行block
 */
- (void)performSelectorOnMainThreadWithSync:(void (^)(void))methodName;

/**
 主线程异步执行

 @param methodName 执行block
 */
- (void)performSelectorOnMainThreadWithAsync:(void (^)(void))methodName;

/**
 异步到全局队列

 @param customEvent 执行block
 */
- (void)performSelectorOnOtherThreadWithAsync:(void (^)(void))customEvent;


@end

