//
//  UIScreen+MSExtension.h
//  MISFoundationDev
//
//  Created by haozhenyi on 2018/4/13.
//  Copyright © 2018年 com.58.MIS-Foundation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScreen (ZQExtension)
/// 主屏幕宽度
@property (nonatomic, assign, readonly, class) CGFloat mainWidth;
/// 主屏幕高度
@property (nonatomic, assign, readonly, class) CGFloat mainHeight;
/// 主屏幕高度与iphone5高度的比例
@property (nonatomic, assign, readonly, class) CGFloat mainHeightScaleForIphone5;
/// 主屏幕高度与iphone5款度的比例
@property (nonatomic, assign, readonly, class) CGFloat mainWidthScaleForIphone5;
/// 主屏幕尺寸是否是iPhone4的尺寸
@property (nonatomic, assign, readonly, class) BOOL isIPhone4Size;
/// 主屏幕尺寸是否是iPhone5的尺寸
@property (nonatomic, assign, readonly, class) BOOL isIPhone5Size;
/// 主屏幕尺寸是否是iPhone6的尺寸
@property (nonatomic, assign, readonly, class) BOOL isIPhone6Size;
/// 主屏幕尺寸是否是iPhone6P的尺寸
@property (nonatomic, assign, readonly, class) BOOL isIPhone6pSize;
/// 主屏幕尺寸是否是iPhoneX的尺寸
@property (nonatomic, assign, readonly, class) BOOL isIPhoneXSize;
/// 主屏幕尺寸是否是iPhoneX Max的尺寸
@property (nonatomic, assign, readonly, class) BOOL isIPhoneXMaxSize;

@end
