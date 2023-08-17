//
//  UIColor+MSExtension.h
//  MIS
//
//  Created by LIUZHEN on 2016/12/12.
//  Copyright © 2016年 58. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ZQExtension)

#pragma mark - Color with hex

/**
 *  可以传入FFFFFF、#FFFFFF、0XFFFFFF类型的颜色值
 *
 *  @param hexString 色值
 *
 *  @return 透明度为1的对应UIColor
 */
+ (UIColor *_Nullable)ms_colorWithHexString:(NSString *_Nullable)hexString;

/**
 *  可以传入FFFFFF、#FFFFFF、0XFFFFFF类型的颜色值
 *
 *  @param hexString    色值
 *  @param alpha        0.0~1.0透明度数值
 *
 *  @return UIColor
 */
+ (UIColor *_Nonnull)ms_colorWithHexString:(NSString *_Nullable)hexString colorAlpha:(float)alpha;


+ (UIColor *_Nonnull)ms_colorWithHex:(long)hexColor;

+ (UIColor *_Nonnull)ms_colorWithHex:(long)hexColor alpha:(CGFloat)alpha;
#pragma mark - convienence

/**
 直接传入小于255的整型值来创建颜色

 @param red 0～255
 @param green 0～255
 @param blue 0～255
 @param alpha 0～1
 @return UIColor
 */
+ (UIColor *_Nonnull)ms_colorWithRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha;



#pragma mark - Debugging color

/**
 * 生成随机色
 *
 * @return UIColor
 */
+ (UIColor *_Nonnull)ms_randomColor;


#pragma mark - Get color's description

/**
 Returns the color's RGB value as a hex string (lowercase).
 Such as @"0066cc".
 
 It will return nil when the color space is not RGB
 
 @return The color's value as a hex string.
 */
- (nullable NSString *)hexString;

/**
 Returns the color's RGBA value as a hex string (lowercase).
 Such as @"0066ccff".
 
 It will return nil when the color space is not RGBA
 
 @return The color's value as a hex string.
 */
- (nullable NSString *)hexStringWithAlpha;
@end
