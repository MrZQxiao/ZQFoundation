//
//  UIControl+MSExtension.h
//  MIS
//
//  Created by Nie on 2016/12/14.
//  Copyright © 2016年 58. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface UIControl (ZQExtension)

/**
 *  接受两次点击的时间间隔 防止多次点击多次响应
 */
@property (nonatomic, assign) NSTimeInterval acceptEventInterval;

@end
