//
//  NSObject+MSSyncToMainThread.m
//  MIS
//
//  Created by SaraWu on 2018/6/26.
//  Copyright © 2018 58. All rights reserved.
//

#import "NSObject+ZQExtension.h"

@implementation NSObject (ZQSyncToMainThread)

- (void)performSelectorOnMainThreadWithSync:(void (^)(void))customEvent {
    if (!customEvent) return;
    
    if ([NSThread isMainThread]) {
        customEvent();
    } else {
        dispatch_sync(dispatch_get_main_queue(), ^{
            customEvent();
        });
    }
}

- (void)performSelectorOnMainThreadWithAsync:(void (^)(void))customEvent {
    if (!customEvent) return;
    
    if ([NSThread isMainThread]) {
        customEvent();
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            customEvent();
        });
    }
}

- (void)performSelectorOnOtherThreadWithAsync:(void (^)(void))customEvent {
    if (!customEvent) return;
    
    if ([NSThread isMainThread]) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            customEvent();
        });
    } else {
        customEvent();
    }
}

@end
