//
//  UIView+MSExtension.h
//  MIS
//
//  Created by LIUZHEN on 2017/2/7.
//  Copyright © 2017年 58. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZQExtension)

/// x
@property (nonatomic, assign) CGFloat ms_left;
/// y
@property (nonatomic, assign) CGFloat ms_top;
/// x + width
@property (nonatomic, assign) CGFloat ms_right;
/// y + height
@property (nonatomic, assign) CGFloat ms_bottom;
/// 宽度
@property (nonatomic, assign) CGFloat ms_width;
/// 高度
@property (nonatomic, assign) CGFloat ms_height;
/// 便捷获取centerX
@property (nonatomic, assign) CGFloat ms_centerX;
/// 便捷获取centerY
@property (nonatomic, assign) CGFloat ms_centerY;
/// 便捷获取origin
@property (nonatomic, assign) CGPoint ms_origin;
/// 便捷获取size
@property (nonatomic, assign) CGSize  ms_size;
/// 获取当前控制器
@property (nonatomic, weak, readonly) UIViewController *viewController;

// 绘制圆角
- (void)ms_layerViewCornerRadii:(CGFloat)cornerRadii byRoundingCorners:(UIRectCorner)corners;

@end

