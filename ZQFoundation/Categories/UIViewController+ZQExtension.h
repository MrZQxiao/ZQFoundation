//
//  UIViewController+ZQExtension.h
//  ZQFoundation
//
//  Created by LY on 2023/8/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (ZQExtension)

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

NS_ASSUME_NONNULL_END
