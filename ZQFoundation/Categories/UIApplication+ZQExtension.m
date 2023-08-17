//
//  UIApplication+MSExtension.m
//  MISFoundationDev
//
//  Created by haozhenyi on 2018/4/13.
//  Copyright © 2018年 com.58.MIS-Foundation. All rights reserved.
//

#import "UIApplication+ZQExtension.h"
#import "UIScreen+ZQExtension.h"

@implementation UIApplication (ZQExtension)

+ (CGFloat)navigationBarHeight {
    return [self statusBarHeight] + 44;
}

+ (CGFloat)tabBarHeight {
    CGFloat tabbarH = 66;
    return [UIScreen isIPhoneXSize] ? tabbarH + 34 : tabbarH;
}

+ (CGFloat)statusBarHeight {
    CGFloat height = UIApplication.sharedApplication.statusBarFrame.size.height;
    if (@available(iOS 13.0, *)) {
        height = UIApplication.sharedApplication.keyWindow.windowScene.statusBarManager.statusBarFrame.size.height;
    }
    return height;
}

+ (CGFloat)iphoneXTabarOffset {
    return [UIScreen isIPhoneXSize] ? 34 : 0;
}

+ (CGFloat)iphoneXNavigationBarOffset {
    return [UIScreen isIPhoneXSize] ? 24 : 0;
}

// app build版本
+ (NSString *)bundleVersion {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appBuild = [infoDictionary objectForKey:@"CFBundleVersion"];
    return appBuild;
}

- (void)call:(NSString *)phoneNumber {
    if (![phoneNumber isKindOfClass:NSString.class]) return;
    if (phoneNumber.length <= 0) return;
    
    if (![phoneNumber hasPrefix:@"tel:"]) {
        phoneNumber = [NSString stringWithFormat:@"tel:%@",phoneNumber];
    }
    NSURL *phone = [NSURL URLWithString:phoneNumber];
    if (phone) {
        [self openURL:phone options:@{} completionHandler:nil];
    }
}

@end
