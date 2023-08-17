//
//  UIDevice+MSExtension.h
//  MISFoundationDev
//
//  Created by haozhenyi on 2018/4/13.
//  Copyright © 2018年 com.58.MIS-Foundation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (ZQExtension)
/// 是否是iPad
@property (nonatomic, assign, readonly, class) BOOL isiPad;

/// 系统大版本号
@property (nonatomic, assign, readonly, class) NSInteger systemVersionNumber;
/// 设备的版本信息
@property (nonatomic, copy, readonly, class) NSString *versionInfo;
/// 设备名
@property (nonatomic, copy, readonly, class) NSString *deviceModel;


/// 获取设备当前网络IP地址
+ (NSString *)getIPAddress:(BOOL)preferIPv4;

/// 获取所有相关IP信息
+ (NSDictionary *)getIPAddresses;

+ (NSString *)uuid;

#pragma mark - shake

/// 开始震动
- (void)startVibrate;

/// 结束震动
- (void)endVibrate;
@end
