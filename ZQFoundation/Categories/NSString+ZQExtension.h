//
//  NSString+MSExtension.h
//  MIS
//
//  Created by LIUZHEN on 2017/2/20.
//  Copyright © 2017年 58. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 文件类型

 - MISFileTypeWord: MS Word
 - MISFileTypeExcel: MS Excel
 - MISFileTypePPT: MS PowerPoint
 - MISFileTypeOffice: MS Office
 - MISFileTypeVideo: 视频文件
 - MISFileTypeAudio: 音频文件
 - MISFileTypePicture: 图片
 - MISFileTypeZip: 压缩文件
 - MISFileTypeUnknow: 未知
 */
typedef NS_ENUM(NSUInteger,MISFileType) {
    MISFileTypeWord,
    MISFileTypeExcel,
    MISFileTypePPT,
    MISFileTypeOffice,
    MISFileTypeVideo,
    MISFileTypeAudio,
    MISFileTypePicture,
    MISFileTypeZip,
    MISFileTypeUnknow,
};


@interface NSString (ZQExtension)

/**
 *  去除字符串前后空格
 */
- (NSString *)trim;

/**
 *  判断字符串是否非空
 *
 *  @param str 待判定的字符串
 *
 *  @return YES or NO
 */
+ (BOOL)isNotBlank:(NSString *)str;

/**
 *  判断字符串是否为空
 *
 *  @param str 待判定的字符串
 *
 *  @return YES or NO
 */
+ (BOOL)isBlank:(NSString *)str;

/**
 *  判断字符串是否为数字
 *
 *  @param str 待判定的字符串
 *
 *  @return YES or NO
 */
+ (BOOL)isDigit:(NSString *)str;

/**
 *  判断字符串是否为中文
 *
 *  @param str 待判定的字符串
 *
 *  @return YES or NO
 */
+ (BOOL)isChinese:(NSString *)str;

/**
 *  禁止输入表情
 *
 *  @param text 待判定的字符串
 */
+ (NSString *)disable_emoji:(NSString *)text;

/**
 *  中英文混合字符串长度：一般情况下，中文2个字符，英文1个字符。
 */
- (NSInteger)convertStringLength;

/**
 *  中英文混合字符串长度：一般情况下，中文2个字符，英文1个字符。Unicode编码
 */
- (NSInteger)convertStringLength1;

/**
 *  名片扫描电话校正
 */
+ (NSString *)decreaseBracketsBy:(NSString *)string;

/**
 *  生成指定长度的字符串
 *
 *  @param length 长度
 *
 *  @return 字符串
 */
+ (NSString *)randomWords:(NSInteger)length;

/**
 *  生成指定长度的中文字符串
 *
 *  @param length 指定长度
 *
 *  @return 字符串
 */
+ (NSString *)randomChineseWords:(NSInteger)length;

/**
 *  计算文字宽高
 *
 *  @param size     约束大小
 *  @param fontSize 文字字体大小
 *
 *  @return 文字Size
 */
- (CGSize)sizeForConstrain:(CGSize)size fontSize:(NSInteger)fontSize;

/**
 计算文字尺寸

 @param size 尺寸
 @param font 字体
 @return 文字的宽高
 */
- (CGSize)sizeForConstrain:(CGSize)size font:(UIFont *)font;

/**
 *  计算富文本字体高度
 *
 *  @param lineSpeace 行高
 *  @param font       字体
 *  @param width      字体所占宽度
 *
 *  @return 富文本高度
 */
- (CGFloat)getSpaceLabelHeightwithSpeace:(CGFloat)lineSpeace withFont:(UIFont*)font withWidth:(CGFloat)width;


/// 动态计算高度 参数字体大小 宽度  字符串
- (CGFloat)autolableHeightWithFont:(UIFont *)font Width:(CGFloat)width;

/// 动态计算宽度
- (CGFloat)autolableWidthtWithFont:(UIFont *)font;

/**
 *  生成指定长度的随机字符串 - 字母数字
 *
 *  @param length 长度
 *
 *  @return 随机字符串
 */
+ (NSString *)randomWDs:(NSInteger)length;


#pragma mark - MD5

/**
 *  获取MD5加密码
 */
- (NSString *)MD5;

/**
 *  获取SHA1加密码
 */
- (NSString *)SHA1;

/** 字符转byte */
- (NSData *)stringToByte;

/// byte转16进制
+ (NSString *)hexStringFromData:(NSData *)data;


/// 是否包含字符串
+ (BOOL)stringContainsEmoji:(NSString *)string;

/// 根据填写的city名 自动拼接区号
+ (NSString *)handlePhoneByPhone:(NSString *)string city:(NSString *)city;

/// 固定电话及手机校验
+ (BOOL)validateMobile:(NSString *)mobile;

/// 文件类型
- (MISFileType)fileType;

/// 文件大小转字符串
+ (NSString *)convertFileSize:(long long)size;

/// URL编码
+ (NSString*)encodeString:(NSString*)unencodedString;
- (NSString *)stringByEncoded;

/// URL解码
+ (NSString *)decodeString:(NSString*)encodedString;

/// 根据`包`名和`图片`名在mainBundle获取图片路径
+ (NSString *)stringWithBundleName:(NSString *)bundlePath imageName:(NSString *)imageName;

/// 根据`包`名和`图片`名在bundleClass所在的bundle获取图片路径
+ (NSString *)stringWithBundleClass:(Class)bundleClass bundleName:(NSString *)bundleName imageName:(NSString *)imageName;

//文件大小格式化
+ (NSString *)sizeToString:(long long)size ;

/// 获取字符串中包含子字符串subString的range数组
- (NSMutableArray *)getRangeWithSubString:(NSString *)subString;

@end
