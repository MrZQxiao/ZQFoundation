//
//  UIApplication+MSExtension.h
//  MISFoundationDev
//
//  Created by haozhenyi on 2018/4/13.
//  Copyright © 2018年 com.58.MIS-Foundation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (ZQExtension)

/// 导航栏高度
@property (nonatomic, assign, readonly, class) CGFloat navigationBarHeight;
/// tabbar高度
@property (nonatomic, assign, readonly, class) CGFloat tabBarHeight;
/// 状态栏高度
@property (nonatomic, assign, readonly, class) CGFloat statusBarHeight;
/// 刘海设备tabbar比普通设备高出值
@property (nonatomic, assign, readonly, class) CGFloat iphoneXTabarOffset;
/// 刘海设备导航栏比普通设备高出值
@property (nonatomic, assign, readonly, class) CGFloat iphoneXNavigationBarOffset;
/// 包的版本号
@property (nonatomic, copy, readonly, class) NSString *bundleVersion;

/// 打电话
/// @param phoneNumber 电话号码
- (void)call:(NSString *)phoneNumber;
@end
