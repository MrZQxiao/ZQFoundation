//
//  UIScreen+MSExtension.m
//  MISFoundationDev
//
//  Created by haozhenyi on 2018/4/13.
//  Copyright © 2018年 com.58.MIS-Foundation. All rights reserved.
//

#import "UIScreen+ZQExtension.h"

@implementation UIScreen (ZQExtension)
+ (CGFloat)mainWidth {
    return CGRectGetWidth([[UIScreen mainScreen] bounds]);
}

+ (CGFloat)mainHeight {
    return CGRectGetHeight([[UIScreen mainScreen] bounds]);
}

+ (CGFloat)mainHeightScaleForIphone5 {
    return (([UIScreen mainScreen].bounds.size.height) / 568);
}

+ (CGFloat)mainWidthScaleForIphone5 {
    return (([UIScreen mainScreen].bounds.size.width) / 320);
}

+ (BOOL)isIPhone4Size {
    return ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO);
}

+ (BOOL)isIPhone5Size {
    return ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO);
}

+ (BOOL)isIPhone6Size {
    return ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO);
}

+ (BOOL)isIPhone6pSize {
    return ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO);
}

+ (BOOL)isIPhoneXSize {
    BOOL isPhoneX = NO;
    if (@available(iOS 11.0, *)) {
        isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > .0f;
    }
    return isPhoneX;
}

+ (BOOL)isIPhoneXMaxSize {
    return ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) ||
        CGSizeEqualToSize(CGSizeMake(1284, 2778), [[UIScreen mainScreen] currentMode].size) : NO);
}

@end
