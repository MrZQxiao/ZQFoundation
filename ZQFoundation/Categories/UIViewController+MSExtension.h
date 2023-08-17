//
//  UIViewController+MSExtension.h
//  MIS
//
//  Created by LIUZHEN on 2017/2/14.
//  Copyright © 2017年 58. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - MSExtension

@interface UIViewController (MSExtension)

/**
 *  当前控制器
 */
+ (__kindof UIViewController *)currentViewController;

/**
 *  设置控制器方向
 *
 *  @param orientation 方向
 */
- (void)setupOrientation:(UIInterfaceOrientation)orientation;

/**
 *  还原控制器方向
 */
- (void)resetRotation;

@end

